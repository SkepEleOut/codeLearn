/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 127.0.0.1:3306
 Source Schema         : db

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 22/03/2020 19:09:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alive_ip
-- ----------------------------
DROP TABLE IF EXISTS `alive_ip`;
CREATE TABLE `alive_ip`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datetime` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime(0) NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `markdown` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auto
-- ----------------------------
DROP TABLE IF EXISTS `auto`;
CREATE TABLE `auto`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sign` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datetime` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for blockip
-- ----------------------------
DROP TABLE IF EXISTS `blockip`;
CREATE TABLE `blockip`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) NOT NULL,
  `ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datetime` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bought
-- ----------------------------
DROP TABLE IF EXISTS `bought`;
CREATE TABLE `bought`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) NOT NULL,
  `shopid` bigint(20) NOT NULL,
  `datetime` bigint(20) NOT NULL,
  `renew` bigint(11) NOT NULL,
  `coupon` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(12, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for code
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(11) NOT NULL,
  `number` decimal(11, 2) NOT NULL,
  `isused` int(11) NOT NULL DEFAULT 0,
  `userid` bigint(20) NOT NULL,
  `usedatetime` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `onetime` int(11) NOT NULL,
  `expire` bigint(20) NOT NULL,
  `shop` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `credit` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for detect_ban_log
-- ----------------------------
DROP TABLE IF EXISTS `detect_ban_log`;
CREATE TABLE `detect_ban_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `user_id` int(11) NOT NULL COMMENT '用户 ID',
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户邮箱',
  `detect_number` int(11) NOT NULL COMMENT '本次违规次数',
  `ban_time` int(11) NOT NULL COMMENT '本次封禁时长',
  `start_time` bigint(20) NOT NULL COMMENT '统计开始时间',
  `end_time` bigint(20) NOT NULL COMMENT '统计结束时间',
  `all_detect_number` int(11) NOT NULL COMMENT '累计违规次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '审计封禁日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for detect_list
-- ----------------------------
DROP TABLE IF EXISTS `detect_list`;
CREATE TABLE `detect_list`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `text` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `regex` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for detect_log
-- ----------------------------
DROP TABLE IF EXISTS `detect_log`;
CREATE TABLE `detect_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `list_id` bigint(20) NOT NULL,
  `datetime` bigint(20) NOT NULL,
  `node_id` int(11) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for disconnect_ip
-- ----------------------------
DROP TABLE IF EXISTS `disconnect_ip`;
CREATE TABLE `disconnect_ip`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) NOT NULL,
  `ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datetime` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for email_verify
-- ----------------------------
DROP TABLE IF EXISTS `email_verify`;
CREATE TABLE `email_verify`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_in` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gconfig
-- ----------------------------
DROP TABLE IF EXISTS `gconfig`;
CREATE TABLE `gconfig`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置键名',
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '值类型',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置值',
  `oldvalue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '之前的配置值',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名称',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置描述',
  `operator_id` int(11) NOT NULL COMMENT '操作员 ID',
  `operator_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作员名称',
  `operator_email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作员邮箱',
  `last_update` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '网站配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for link
-- ----------------------------
DROP TABLE IF EXISTS `link`;
CREATE TABLE `link`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `port` int(11) NOT NULL,
  `token` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ios` int(11) NOT NULL DEFAULT 0,
  `userid` bigint(20) NOT NULL,
  `isp` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `geo` int(11) NULL DEFAULT NULL,
  `method` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for login_ip
-- ----------------------------
DROP TABLE IF EXISTS `login_ip`;
CREATE TABLE `login_ip`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) NOT NULL,
  `ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datetime` bigint(20) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for payback
-- ----------------------------
DROP TABLE IF EXISTS `payback`;
CREATE TABLE `payback`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `total` decimal(12, 2) NOT NULL,
  `userid` bigint(20) NOT NULL,
  `ref_by` bigint(20) NOT NULL,
  `ref_get` decimal(12, 2) NOT NULL,
  `datetime` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for paylist
-- ----------------------------
DROP TABLE IF EXISTS `paylist`;
CREATE TABLE `paylist`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) NOT NULL,
  `total` decimal(12, 2) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `tradeno` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `datetime` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for phone_message
-- ----------------------------
DROP TABLE IF EXISTS `phone_message`;
CREATE TABLE `phone_message`  (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号',
  `message` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '验证码',
  `type` int(3) NOT NULL COMMENT '1: 注册 2：找回密码',
  `valid` int(20) NOT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for radius_ban
-- ----------------------------
DROP TABLE IF EXISTS `radius_ban`;
CREATE TABLE `radius_ban`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relay
-- ----------------------------
DROP TABLE IF EXISTS `relay`;
CREATE TABLE `relay`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `source_node_id` bigint(20) NOT NULL,
  `dist_node_id` bigint(20) NOT NULL,
  `dist_ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `port` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(12, 2) NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `auto_renew` int(11) NOT NULL,
  `auto_reset_bandwidth` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for speedtest
-- ----------------------------
DROP TABLE IF EXISTS `speedtest`;
CREATE TABLE `speedtest`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) NOT NULL,
  `datetime` bigint(20) NOT NULL,
  `telecomping` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telecomeupload` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telecomedownload` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `unicomping` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `unicomupload` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `unicomdownload` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cmccping` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cmccupload` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cmccdownload` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ss_invite_code
-- ----------------------------
DROP TABLE IF EXISTS `ss_invite_code`;
CREATE TABLE `ss_invite_code`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `updated_at` timestamp(0) NOT NULL DEFAULT '2016-06-01 08:00:00',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ss_node
-- ----------------------------
DROP TABLE IF EXISTS `ss_node`;
CREATE TABLE `ss_node`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` int(3) NOT NULL,
  `server` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `method` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `info` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort` int(3) NOT NULL,
  `custom_method` tinyint(1) NOT NULL DEFAULT 0,
  `traffic_rate` float NOT NULL DEFAULT 1,
  `node_class` int(11) NOT NULL DEFAULT 0,
  `node_speedlimit` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `node_connector` int(11) NOT NULL DEFAULT 0,
  `node_bandwidth` bigint(20) NOT NULL DEFAULT 0,
  `node_bandwidth_limit` bigint(20) NOT NULL DEFAULT 0,
  `bandwidthlimit_resetday` int(11) NOT NULL DEFAULT 0,
  `node_heartbeat` bigint(20) NOT NULL DEFAULT 0,
  `node_ip` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `node_group` int(11) NOT NULL DEFAULT 0,
  `custom_rss` int(11) NOT NULL DEFAULT 0,
  `mu_only` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ss_node_info
-- ----------------------------
DROP TABLE IF EXISTS `ss_node_info`;
CREATE TABLE `ss_node_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `uptime` float NOT NULL,
  `load` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `log_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ss_node_online_log
-- ----------------------------
DROP TABLE IF EXISTS `ss_node_online_log`;
CREATE TABLE `ss_node_online_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `online_user` int(11) NOT NULL,
  `log_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ss_password_reset
-- ----------------------------
DROP TABLE IF EXISTS `ss_password_reset`;
CREATE TABLE `ss_password_reset`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `token` varchar(128) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `init_time` int(11) NOT NULL,
  `expire_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for telegram_session
-- ----------------------------
DROP TABLE IF EXISTS `telegram_session`;
CREATE TABLE `telegram_session`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `type` int(11) NOT NULL,
  `session_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datetime` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for telegram_tasks
-- ----------------------------
DROP TABLE IF EXISTS `telegram_tasks`;
CREATE TABLE `telegram_tasks`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` int(8) NOT NULL COMMENT '任务类型',
  `status` int(2) NOT NULL DEFAULT 0 COMMENT '任务状态',
  `chatid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT 'Telegram Chat ID',
  `messageid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT 'Telegram Message ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '任务详细内容',
  `process` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '临时任务进度',
  `userid` int(11) NOT NULL DEFAULT 0 COMMENT '网站用户 ID',
  `tguserid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT 'Telegram User ID',
  `executetime` bigint(20) NOT NULL COMMENT '任务执行时间',
  `datetime` bigint(20) NOT NULL COMMENT '任务产生时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Telegram 任务列表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ticket
-- ----------------------------
DROP TABLE IF EXISTS `ticket`;
CREATE TABLE `ticket`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rootid` bigint(20) NOT NULL,
  `userid` bigint(20) NOT NULL,
  `datetime` bigint(20) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for unblockip
-- ----------------------------
DROP TABLE IF EXISTS `unblockip`;
CREATE TABLE `unblockip`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datetime` bigint(20) NOT NULL,
  `userid` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pass` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `passwd` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `t` int(11) NOT NULL DEFAULT 0,
  `u` bigint(20) NOT NULL,
  `d` bigint(20) NOT NULL,
  `plan` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'A',
  `transfer_enable` bigint(20) NOT NULL,
  `port` int(11) NOT NULL,
  `switch` tinyint(4) NOT NULL DEFAULT 1,
  `enable` tinyint(4) NOT NULL DEFAULT 1,
  `last_detect_ban_time` datetime(0) NULL DEFAULT '1989-06-04 00:05:00',
  `all_detect_number` int(11) NOT NULL DEFAULT 0,
  `type` tinyint(4) NOT NULL DEFAULT 1,
  `last_get_gift_time` int(11) NOT NULL DEFAULT 0,
  `last_check_in_time` int(11) NOT NULL DEFAULT 0,
  `last_rest_pass_time` int(11) NOT NULL DEFAULT 0,
  `reg_date` datetime(0) NOT NULL,
  `invite_num` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `money` decimal(12, 2) NOT NULL,
  `ref_by` int(11) NOT NULL DEFAULT 0,
  `expire_time` int(11) NOT NULL DEFAULT 0,
  `method` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'rc4-md5',
  `is_email_verify` tinyint(4) NOT NULL DEFAULT 0,
  `reg_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '127.0.0.1',
  `node_speedlimit` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `node_connector` int(11) NOT NULL DEFAULT 0,
  `is_admin` int(2) NOT NULL DEFAULT 0,
  `im_type` int(11) NULL DEFAULT 1,
  `im_value` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `last_day_t` bigint(20) NOT NULL DEFAULT 0,
  `sendDailyMail` int(11) NOT NULL DEFAULT 0,
  `class` int(11) NOT NULL DEFAULT 0,
  `class_expire` datetime(0) NOT NULL DEFAULT '1989-06-04 00:05:00',
  `expire_in` datetime(0) NOT NULL DEFAULT '2099-06-04 00:05:00',
  `theme` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ga_token` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ga_enable` int(11) NOT NULL DEFAULT 0,
  `pac` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `node_group` int(11) NOT NULL DEFAULT 0,
  `auto_reset_day` int(11) NOT NULL DEFAULT 0,
  `auto_reset_bandwidth` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `protocol` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'origin',
  `protocol_param` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `obfs` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'plain',
  `obfs_param` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `forbidden_ip` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `forbidden_port` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `disconnect_ip` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `is_hide` int(11) NOT NULL DEFAULT 0,
  `is_multi_user` int(11) NOT NULL DEFAULT 0,
  `telegram_id` bigint(20) NULL DEFAULT NULL,
  `valid` int(20) NOT NULL,
  `invite_code` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_name`(`user_name`) USING BTREE,
  INDEX `uid`(`id`) USING BTREE,
  INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_subscribe_log
-- ----------------------------
DROP TABLE IF EXISTS `user_subscribe_log`;
CREATE TABLE `user_subscribe_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `user_id` int(11) NOT NULL COMMENT '用户 ID',
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户邮箱',
  `subscribe_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '获取的订阅类型',
  `request_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求 IP',
  `request_time` datetime(0) NOT NULL COMMENT '请求时间',
  `request_user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '请求 UA 信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户订阅日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_token
-- ----------------------------
DROP TABLE IF EXISTS `user_token`;
CREATE TABLE `user_token`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `expire_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_traffic_log
-- ----------------------------
DROP TABLE IF EXISTS `user_traffic_log`;
CREATE TABLE `user_traffic_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `u` bigint(20) NOT NULL,
  `d` bigint(20) NOT NULL,
  `node_id` int(11) NOT NULL,
  `rate` float NOT NULL,
  `traffic` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `log_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
