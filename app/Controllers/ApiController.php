<?php

namespace App\Controllers;

use App\Services\Factory;
use App\Utils\Helper;
use App\Models\InviteCode;
use App\Services\Config;
use App\Utils\Check;
use App\Utils\Tools;
use App\Utils\Radius;
use Exception;
use voku\helper\AntiXSS;
use App\Utils\Hash;
use App\Utils\Da;
use App\Services\Auth;
use App\Services\Mail;
use App\Models\User;
use App\Models\LoginIp;
use App\Models\EmailVerify;
use App\Models\Node;
use App\Models\Shop;
use App\Models\Ann;
use App\Models\PhoneMessage;
use App\Utils\GA;
use App\Utils\Geetest;
use App\Utils\TelegramSessionManager;
use App\Utils\Mcrypt;

/**
 *  ApiController
 */
class ApiController extends BaseController
{
    /**
     * API
     */
    public function login($request, $response, $args)
    {
        $phone = $request->getParam('phone');
        $passwd = $request->getParam('passwd');
        $user = User::where('phone', '=', $phone)->first();

        if ($user == null) {
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '账号不存在'
            ]);
        }

        if (!Hash::checkPassword($user->pass, $passwd)) {
            $loginIP = new LoginIp();
            $loginIP->ip = $_SERVER['REMOTE_ADDR'];
            $loginIP->userid = $user->id;
            $loginIP->datetime = time();
            $loginIP->type = 1;
            $loginIP->save();

            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '密码不存在'
            ]);
        }


        $time = 3600 * 24;
        if ($rememberMe) {
            $time = 3600 * 24 * (Config::get('rememberMeDuration') ?: 7);
        }

        if ($user->ga_enable == 1) {
            $ga = new GA();
            $rcode = $ga->verifyCode($user->ga_token, $code);
            if (!$rcode) {
                return $this->echoJson($response, [
                    'code' => 1,
                    'msg' => '两步验证码错误，如果您是丢失了生成器或者错误地设置了这个选项，您可以尝试重置密码，即可取消这个选项。'
                ]);
            }
        }

        $token = $this -> genarateToken($response, $user);
        if($token == 'error'){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => 'token 错误'
            ]);
        }

        Auth::login($user->id, $time);

        $loginIP = new LoginIp();
        $loginIP->ip = $_SERVER['REMOTE_ADDR'];
        $loginIP->userid = $user->id;
        $loginIP->datetime = time();
        $loginIP->type = 0;
        $loginIP->save();

        return $this->echoJson($response, [
            'code' => 0,
            'msg' => '登录成功',
            'data' => [
                'token' => $token
            ]
        ]);
    }

    /**
     * Register
     */
    public function register($request, $response)
    {
        if (Config::get('register_mode') === 'close') {
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '未开放注册。'
            ]);
        }

        $name = $request->getParam('phone');
        $phone = $request->getParam('phone');
        $passwd = $request->getParam('passwd');
        $repasswd = $request->getParam('repasswd');
        //手机验证码
        $message = $request->getParam('message');
        //邀请码
        $code = $request->getParam('invite_code');
        $code = trim($code);
    
        //验证手机
        $phoneMessage = PhoneMessage::orderBy('valid', 'DESC')->where('phone', '=', $phone)->first();
        if(!$phoneMessage){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '手机号码不正确'
            ]);
        }
        $_phone = $phoneMessage->phone;
        $_message = $phoneMessage->message;
        $_type = $phoneMessage->type;
        $_validate = $phoneMessage->valid;

        if($_phone != $phone){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '手机号错误'
            ]);
        }

        if($_message != $message){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '验证码错误'
            ]);
        }

        if($_SERVER['REQUEST_TIME'] >  $_validate){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '验证码过期，请重新获取'
            ]);
        }

        // check pwd length
        if (strlen($passwd) < 8) {
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '密码请大于8位'
            ]);
        }

        // check pwd re
        if ($passwd != $repasswd) {
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '两次密码输入不符'
            ]);
        }

        // if ($imtype == '' || $wechat == '') {
        //     return $this->echoJson($response, [
        //         'code' => 1,
        //         'msg' => '请填上你的联络方式'
        //     ]);
        // }
        // do reg user
        $user = new User();
        $antiXss = new AntiXSS();

        $isExsit = $user -> where('phone', '=', $phone) -> first();
        if($isExsit){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '用户已存在'
            ]);
        }

        //邀请码是否有效，无效则略过
        $inviteUser = User::where('invite_code', $code)->first();
        $userValid = $_SERVER['REQUEST_TIME'];
        if($inviteUser){
            //奖励时间为1天
            $bounsDate = 3600 * 24 * 1;
            $userValid += $bounsDate;
            //邀请人增加时间
            $inviteUserNewValid = intval($inviteUser['valid']) + $bounsDate;
            User::where('invite_code', $code)->update(['valid' => $inviteUserNewValid]);
        }

        $user->user_name = $antiXss->xss_clean($name);
        $user->phone = $phone;
        $user->valid = $userValid;
        $user->invite_code = createInviteCode();
        $user->email = (uniqid(rand(1000,9999),true)).'@sspanel.com';
        $user->pass = Hash::passwordHash($passwd);
        $user->passwd = Tools::genRandomChar(6);
        $user->port = Tools::getAvPort();
        $user->t = 0;
        $user->u = 0;
        $user->d = 0;
        $user->method = Config::get('reg_method');
        $user->protocol = Config::get('reg_protocol');
        $user->protocol_param = Config::get('reg_protocol_param');
        $user->obfs = Config::get('reg_obfs');
        $user->obfs_param = Config::get('reg_obfs_param');
        $user->forbidden_ip = Config::get('reg_forbidden_ip');
        $user->forbidden_port = Config::get('reg_forbidden_port');
        $user->im_type = 1;
        $user->im_value = $antiXss->xss_clean( (uniqid(rand(1000,9999),true)));
        $user->transfer_enable = Tools::toGB(Config::get('defaultTraffic'));
        $user->invite_num = '-1';
        $user->auto_reset_day = Config::get('reg_auto_reset_day');
        $user->auto_reset_bandwidth = Config::get('reg_auto_reset_bandwidth');
        $user->money = 0;
        $user->valid = $userValid;
        $user->invite_code = createInviteCode();
        $user->class_expire = date('Y-m-d H:i:s', time() + Config::get('user_class_expire_default') * 3600);
        $user->class = Config::get('user_class_default');
        $user->node_connector = Config::get('user_conn');
        $user->node_speedlimit = Config::get('user_speedlimit');
        $user->expire_in = date('Y-m-d H:i:s', time() + Config::get('user_expire_in_default') * 86400);
        $user->reg_date = date('Y-m-d H:i:s');
        $user->reg_ip = $_SERVER['REMOTE_ADDR'];
        $user->plan = 'A';
        $user->theme = Config::get('theme');

        $groups = explode(',', Config::get('ramdom_group'));

        $user->node_group = $groups[array_rand($groups)];

        $ga = new GA();
        $secret = $ga->createSecret();

        $user->ga_token = $secret;
        $user->ga_enable = 0;

        if ($user->save()) {
            return $this->echoJson($response, [
                'code' => 0,
                'msg' => '注册成功！'
            ]);
        }

        return $this->echoJson($response, [
            'code' => 1,
            'msg' => '未知错误'
        ]);

    }

    /**
     * UserInfo
     */
    public function getUserInfo($request, $response, $args){
        $accessToken = Helper::getParam($request, 'token');
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        $userId = $token->userId;
        if ($userId == null) {
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '用户未登录'
            ]);
        }
        $user = User::where('id', '=', $userId)->first();
        if(!$user){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => 'token错误'
            ]);
        }
        $res = [
            'phone' => $user['phone'],
            'username' => $user['user_name'],
            'money' => $user['money'],
            'valid' => $user['valid'],
            'type' =>  $user['type'],
            'invite_code' => $user['invite_code'],
        ];
        return $this->echoJson($response, [
            'code' => 0,
            'msg' => '成功',
            'data' => $res
        ]);
    }
    /**
     * NodeList
     */
    public function getNodeList($request, $response, $args){
        $accessToken = Helper::getParam($request, 'token');
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        $userId = $token->userId;
        if ($userId == null) {
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '用户未登录'
            ]);
        }
        $user = User::where('id', '=', $userId)->first();
        if(!$user){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => 'token错误'
            ]);
        }

        $res = Node::where('type', '==', 1)->get();
        $contry = [
            '日本' => 'rb',
            '香港' => 'xg'
        ];
        $node = [];
        foreach($res as $value){
            $_area = explode(' ', $value['name']);
            $node[] = [
                'id' => $value['id'],
                'name' => $value['name'],
                'area' => $contry[$_area[0]], 
                'node_class' => $value['node_class'],
                'type_name' => '视频专线' 
            ];
        }
        return $this->echoJson($response, [
            'code' => 0,
            'msg' => '成功',
            'data' => $node
        ]);
    }

    /**
     * connect
     */
    public function connect($request, $response, $args){
        $accessToken = Helper::getParam($request, 'token');
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        $userId = $token->userId;
        $nodeId = $request->getParam('nodeId');
        $type = $request->getParam('type');
        if ($userId == null) {
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '用户未登录'
            ]);
        }
        $user = User::where('id', '=', $userId)->first();
        if(!$user){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => 'token错误'
            ]);
        }
        //用户信息
        $user = User::where('id', '=', $userId)->first();
        $userLevel = $user['class'];
        //节点信息
        $node = Node::where('id', '=', $nodeId)->first();
        $nodeLevel = $node['node_class'];
        //判断用户等级是否与节点匹配
        if($userLevel != $nodeLevel){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '该线路为高级线路，您可以升级后进行连接'
            ]);
        }
        //加密
        $server = $node['server'];
        $port = $user['port'];
        $password = $user['passwd'];
        $method = $user['method'];
        $key = 'ls258159';
        //链接信息
        if($type === 'win' || $type == 'os'){
            $command = 'ss-local -s '.$server.' -p '.$port.' -l 1080 -k '.$password.' -m '.$method.' -t 300';
        }else if($type == 'ios' || $type == 'android'){
            $command = [
                'server' => $server,
                'port' => $port,
                'password' => $password,
                'methond' => $method
            ];
        }else{
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '参数不全'
            ]);
        }
        return $this->echoJson($response, [
            'code' => 0,
            'msg' => '成功',
            'data' => [
                'info' => $command
            ]
        ]);
    }

    /**
     * GoodsList
     */
    public function getShopList($request, $response, $args){
        $accessToken = Helper::getParam($request, 'token');
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        $userId = $token->userId;
        if ($userId == null) {
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '用户未登录'
            ]);
        }
        $user = User::where('id', '=', $userId)->first();
        if(!$user){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => 'token错误'
            ]);
        }

        $res = Shop::get();

        $goods = [];
        foreach($res as $value){
            $content = object_array(json_decode($value['content']));
            $goods[] = [
                'id' => $value['id'],
                'name' => $value['name'],
                'price' => $value['price'],
                'content' => $content 
            ];
        }
        return $this->echoJson($response, [
            'code' => 0,
            'msg' => '成功',
            'data' => $goods
        ]);
    }

    /**
     * AnnList
     */
    public function getAnnList($request, $response, $args){
        $accessToken = Helper::getParam($request, 'token');
        $storage = Factory::createTokenStorage();
        $token = $storage->get($accessToken);
        $userId = $token->userId;
        if ($userId == null) {
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '用户未登录'
            ]);
        }
        $user = User::where('id', '=', $userId)->first();
        if(!$user){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => 'token错误'
            ]);
        }

        $res = Ann::get();
        return $this->echoJson($response, [
            'code' => 0,
            'msg' => '成功',
            'data' => $res
        ]);
    }

    //发送手机验证码
    public function sendPhoneCode($request, $response){
        $url = 'https://106.ihuyi.com/webservice/sms.php?method=Submit';
        $code = $this -> random(6,1);
        $account = 'C64536493';
        $apikey = 'b85528bda248afd312da86b9b804f02e ';
        $content = '您的验证码是'.$code.'，短信有效期五分钟。';
        $time = time();
        $phone = $request->getParam('phone');
        $type = $request->getParam('type') == null ? 0 : $request->getParam('type');
        $type = intval(trim($type));
        if($phone == null){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '手机号码不能为空'
            ]);
        }
        if($type < 0){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '参数错误'
            ]);
        }
        $password = md5($account.$apikey.$phone.$content.$time);
        $data = [
            'account' => $account,
            'password' => $password,
            'mobile' => $phone,
            'content' => $content,
            'time' => $_SERVER['REQUEST_TIME'],
            'format' => 'json'
        ];
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_NOBODY, true);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        $res  = curl_exec($curl);
        $error = curl_error($curl);
        curl_close($curl);

        if($error){
            return $this->echoJson($response, [
                'code' => 1,
                'msg' => '获取失败',
                'data' => $error
            ]);
        }
        if($res['SubmitResult']['code'] == 2 ){
            $phoneMessage = new PhoneMessage();
            $phoneMessage->phone = $phone;
            $phoneMessage->code = $code;
            $phoneMessage->type = $type;
            $phoneMessage->valid = $_SERVER['REQUEST_TIME'] + 300;
            if($phoneMessage->save()){
                return $this->echoJson($response, [
                    'code' => 0,
                    'msg' => '成功'
                ]);
            }
        }
    }

    /**
     * Genarate Token
     */
    private function genarateToken($response, $user){
        $tokenStr = Tools::genToken();
        $storage = Factory::createTokenStorage();
        $expireTime = time() + 3600 * 24 * 7;
        if ($storage->store($tokenStr, $user, $expireTime)) {
            return $tokenStr;
        }
        return 'error';
    }
    //生成验证码
    private function random($length = 6 , $numeric = 0) {
        PHP_VERSION < '4.2.0' && mt_srand((double)microtime() * 1000000);
        if($numeric) {
            $hash = sprintf('%0'.$length.'d', mt_rand(0, pow(10, $length) - 1));
        } else {
            $hash = '';
            $chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789abcdefghjkmnpqrstuvwxyz';
            $max = strlen($chars) - 1;
            for($i = 0; $i < $length; $i++) {
                $hash .= $chars[mt_rand(0, $max)];
            }
        }
        return $hash;
    }
}

function object_array($array) {  
    if(is_object($array)) {  
        $array = (array)$array;  
    } if(is_array($array)) {  
        foreach($array as $key=>$value) {  
            $array[$key] = object_array($value);  
            }  
    }  
    return $array;  
};

function createInviteCode() {
    $code = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';    
    $rand = $code[rand(0,25)]    
        .strtoupper(dechex(date('m')))    
        .date('d').substr(time(),-5)    
        .substr(microtime(),2,5)    
        .sprintf('%02d',rand(0,99));    
    for(    
        $a = md5( $rand, true ),    
        $s = '0123456789ABCDEFGHIJKLMNOPQRSTUV',    
        $d = '',    
        $f = 0;    
        $f < 8;        
        $g = ord( $a[ $f ] ),    
        $d .= $s[ ( $g ^ ord( $a[ $f + 8 ] ) ) - $g & 0x1F ],    
        $f++    
    );    
    return $d;    
};