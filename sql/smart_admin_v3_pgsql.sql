/*
 Navicat Premium Data Transfer

 Source Server         : 
 Source Server Type    : PostgreSQL
 Source Server Version : 170004 (170004)
 Source Host           : 
 Source Catalog        : smart_admin_v3
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 170004 (170004)
 File Encoding         : 65001

 Date: 17/04/2025 21:47:14
*/

-- ----------------------------
-- Sequence structure for t_smart_job_log_log_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_smart_job_log_log_id_seq";
CREATE SEQUENCE "public"."t_smart_job_log_log_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_category";
CREATE TABLE "public"."t_category" (
  "category_id" SERIAL,
  "category_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "category_type" int2 NOT NULL,
  "parent_id" int4 NOT NULL,
  "sort" int4 NOT NULL,
  "disabled_flag" bool NOT NULL  DEFAULT FALSE,
  "deleted_flag" bool NOT NULL  DEFAULT FALSE,
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_category"."category_id" IS '分类id';
COMMENT ON COLUMN "public"."t_category"."category_name" IS '分类名称';
COMMENT ON COLUMN "public"."t_category"."category_type" IS '分类类型';
COMMENT ON COLUMN "public"."t_category"."parent_id" IS '父级id';
COMMENT ON COLUMN "public"."t_category"."sort" IS '排序';
COMMENT ON COLUMN "public"."t_category"."disabled_flag" IS '是否禁用';
COMMENT ON COLUMN "public"."t_category"."deleted_flag" IS '是否删除';
COMMENT ON TABLE "public"."t_category" IS '分类表，主要用于商品分类';

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO "public"."t_category" VALUES (1, '手机', 1, 0, 0, false, false, NULL, '2022-10-10 22:27:24', '2022-07-14 20:55:15');
INSERT INTO "public"."t_category" VALUES (2, '键盘', 1, 0, 0, false, false, NULL, '2022-09-14 21:39:00', '2022-07-14 20:55:48');
INSERT INTO "public"."t_category" VALUES (3, '自定义1', 2, 0, 0, false, false, NULL, '2022-09-14 22:01:06', '2022-07-14 20:56:03');
INSERT INTO "public"."t_category" VALUES (4, '自定义2', 2, 0, 0, false, false, NULL, '2022-09-14 22:01:10', '2022-07-14 20:56:09');
INSERT INTO "public"."t_category" VALUES (351, '鼠标', 1, 0, 0, false, false, NULL, '2022-09-14 21:39:06', '2022-09-14 21:39:06');
INSERT INTO "public"."t_category" VALUES (352, '苹果', 1, 1, 0, false, false, NULL, '2022-09-14 21:39:25', '2022-09-14 21:39:25');
INSERT INTO "public"."t_category" VALUES (353, '华为', 1, 1, 0, false, false, NULL, '2022-09-14 21:39:32', '2022-09-14 21:39:32');
INSERT INTO "public"."t_category" VALUES (354, 'IKBC', 1, 2, 0, false, false, NULL, '2022-09-14 21:39:38', '2022-09-14 21:39:38');
INSERT INTO "public"."t_category" VALUES (355, '双飞燕', 1, 2, 0, false, false, NULL, '2022-09-14 21:39:47', '2022-09-14 21:39:47');
INSERT INTO "public"."t_category" VALUES (356, '罗技', 1, 351, 0, false, false, NULL, '2022-09-14 21:39:57', '2022-09-14 21:39:57');
INSERT INTO "public"."t_category" VALUES (357, '小米', 1, 1, 0, false, false, NULL, '2022-10-10 22:27:39', '2022-10-10 22:27:39');
INSERT INTO "public"."t_category" VALUES (360, 'iphone', 1, 352, 0, false, false, NULL, '2023-12-04 21:26:55', '2023-12-01 19:54:22');

-- ----------------------------
-- Table structure for t_change_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_change_log";
CREATE TABLE "public"."t_change_log" (
  "change_log_id" BIGSERIAL,
  "version" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "type" int4 NOT NULL,
  "publish_author" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "public_date" date NOT NULL,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "link" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_change_log"."change_log_id" IS '更新日志id';
COMMENT ON COLUMN "public"."t_change_log"."version" IS '版本';
COMMENT ON COLUMN "public"."t_change_log"."type" IS '更新类型:[1:特大版本功能更新;2:功能更新;3:bug修复]';
COMMENT ON COLUMN "public"."t_change_log"."publish_author" IS '发布人';
COMMENT ON COLUMN "public"."t_change_log"."public_date" IS '发布日期';
COMMENT ON COLUMN "public"."t_change_log"."content" IS '更新内容';
COMMENT ON COLUMN "public"."t_change_log"."link" IS '跳转链接';
COMMENT ON COLUMN "public"."t_change_log"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_change_log"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_change_log" IS '系统更新日志';

-- ----------------------------
-- Records of t_change_log
-- ----------------------------
INSERT INTO "public"."t_change_log" VALUES (2, 'v1.1.0', 2, '卓大', '2020-05-09', 'SmartAdmin中后台系统 v1.1.0 版本（20200422）正式更新上线，更新内容如下：

1.【新增】增加员工姓名查询

2.【新增】增加文件预览组件

3.【新增】新增四级菜单
', 'http://smartadmin.1024lab.net/views/1.x/base/About.html', '2022-10-04 21:33:50', '2022-10-04 21:33:50');
INSERT INTO "public"."t_change_log" VALUES (8, 'v1.0.0', 1, '卓大', '2019-11-01', 'SmartAdmin中后台系统 v1.0.0 版本（20191101）正式更新上线，更新内容如下：

1.【新增】人员管理

2.【新增】系统设置

3.【新增】心跳服务

4.【新增】动态加载

5.【新增】缓存策略

6.【新增】定时任务', 'http://smartadmin.1024lab.net/views/1.x/base/About.html', '2022-10-04 21:33:50', '2022-10-04 21:33:50');
INSERT INTO "public"."t_change_log" VALUES (9, 'v1.2.0', 2, '卓大', '2020-05-23', 'SmartAdmin中后台系统 v1.2.0 版本（20200515）正式更新上线，更新内容如下：

1.【新增】增加数据权限

2.【新增】帮助文档', NULL, '2022-10-04 21:33:50', '2022-10-04 21:33:50');
INSERT INTO "public"."t_change_log" VALUES (10, 'v1.2.1', 3, '卓大', '2020-05-24', 'SmartAdmin中后台系统 v1.2.1 版本（20200524）正式更新上线，更新内容如下：

1.【修复】四级菜单权限bug

2.【修复】缓存keepalive的Bug

', NULL, '2022-10-04 21:33:50', '2022-10-04 21:33:50');
INSERT INTO "public"."t_change_log" VALUES (11, 'v1.3.0', 2, '卓大', '2020-06-01', 'SmartAdmin中后台系统 v1.3.0 版本（20200601）正式更新上线，更新内容如下：

1.【新增】工作台看板功能

2.【新增】天气预报功能

3.【新增】记录上次登录IP功能', NULL, '2022-10-04 21:33:50', '2022-10-04 21:33:50');
INSERT INTO "public"."t_change_log" VALUES (12, 'v1.4.0', 2, '卓大', '2020-06-06', 'SmartAdmin中后台系统 v1.4.0 版本（20200606）正式更新上线，更新内容如下：

1.【新增】联系客服功能

2.【新增】意见反馈功能', NULL, '2022-10-04 21:33:50', '2022-10-04 21:33:50');
INSERT INTO "public"."t_change_log" VALUES (13, 'v1.5.0', 2, '卓大', '2020-06-14', 'SmartAdmin中后台系统 v1.5.0 版本（20200614）正式更新上线，更新内容如下：

1.【新增】OA系统

2.【新增】通知公告', NULL, '2022-10-04 21:33:50', '2022-10-04 21:33:50');
INSERT INTO "public"."t_change_log" VALUES (14, 'v1.6.0', 2, '卓大', '2020-06-17', 'SmartAdmin中后台系统 v1.6.0 版本（20200617）正式更新上线，更新内容如下：

1.【新增】代码生成

2.【新增】通知公告', NULL, '2022-10-04 21:33:50', '2022-10-04 21:33:50');
INSERT INTO "public"."t_change_log" VALUES (15, 'v2.0.0', 1, '卓大', '2022-10-22', 'SmartAdmin中后台系统 v2.0.0 版本（20191101）正式更新上线，更新内容如下：

1.【新增】人员管理

2.【新增】系统设置

3.【新增】心跳服务

4.【新增】动态加载

5.【新增】缓存策略

6.【新增】定时任务', 'http://smartadmin.1024lab.net/views/1.x/base/About.html', '2022-10-04 21:33:50', '2022-10-04 21:33:50');
INSERT INTO "public"."t_change_log" VALUES (16, 'v1.7.0', 2, '卓大', '2022-10-22', 'SmartAdmin中后台系统 v1.7.0 版本（20200624）正式更新上线，更新内容如下：

1.【新增】商品管理

2.【新增】商品分类', NULL, '2022-10-04 21:33:50', '2022-10-04 21:33:50');
INSERT INTO "public"."t_change_log" VALUES (18, 'v3.0.0', 1, '卓大', '2024-01-01', 'SmartAdmin中后台系统 v3.0.0 版本（20240101）正式更新上线，更新内容如下：


1、【新增】权限从SpringSecurity 转成 Sa-Token

2、【新增】增加接口 加密、解密功能

3、【新增】增加网络安全相关功能：登录限制、密码复杂度、最大在线时长等

4、【新增】ant desgin vue 为 4.x 最新版本

5、【新增】升级 vite5

6、【新增】swagger增加knife4j接口文档

7、【优化】后端sa-common 改名为 sa-base

8、【优化】优化官网文档说明
', NULL, '2022-10-04 21:33:50', '2022-10-04 21:33:50');

-- ----------------------------
-- Table structure for t_code_generator_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_code_generator_config";
CREATE TABLE "public"."t_code_generator_config" (
  "table_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "basic" text COLLATE "pg_catalog"."default",
  "fields" text COLLATE "pg_catalog"."default",
  "insert_and_update" text COLLATE "pg_catalog"."default",
  "delete_info" text COLLATE "pg_catalog"."default",
  "query_fields" text COLLATE "pg_catalog"."default",
  "table_fields" text COLLATE "pg_catalog"."default",
  "detail" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_code_generator_config"."table_name" IS '表名';
COMMENT ON COLUMN "public"."t_code_generator_config"."basic" IS '基础命名信息';
COMMENT ON COLUMN "public"."t_code_generator_config"."fields" IS '字段列表';
COMMENT ON COLUMN "public"."t_code_generator_config"."insert_and_update" IS '新建、修改';
COMMENT ON COLUMN "public"."t_code_generator_config"."delete_info" IS '删除';
COMMENT ON COLUMN "public"."t_code_generator_config"."query_fields" IS '查询';
COMMENT ON COLUMN "public"."t_code_generator_config"."table_fields" IS '列表';
COMMENT ON COLUMN "public"."t_code_generator_config"."detail" IS '详情';
COMMENT ON COLUMN "public"."t_code_generator_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_code_generator_config"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_code_generator_config" IS '代码生成器的每个表的配置';

-- ----------------------------
-- Records of t_code_generator_config
-- ----------------------------

-- ----------------------------
-- Table structure for t_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_config";
CREATE TABLE "public"."t_config" (
  "config_id" BIGSERIAL,
  "config_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "config_key" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "config_value" text COLLATE "pg_catalog"."default" NOT NULL,
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_config"."config_id" IS '主键';
COMMENT ON COLUMN "public"."t_config"."config_name" IS '参数名字';
COMMENT ON COLUMN "public"."t_config"."config_key" IS '参数key';
COMMENT ON COLUMN "public"."t_config"."update_time" IS '上次修改时间';
COMMENT ON COLUMN "public"."t_config"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_config" IS '系统配置';

-- ----------------------------
-- Records of t_config
-- ----------------------------
INSERT INTO "public"."t_config" VALUES (1, '万能密码', 'super_password', '1024ok', '执行示例任务2', '2025-04-12 20:19:49', '2021-12-16 23:32:46');
INSERT INTO "public"."t_config" VALUES (2, '三级等保', 'level3_protect_config', '{
	"fileDetectFlag":true,
	"loginActiveTimeoutMinutes":30,
	"loginFailLockMinutes":30,
	"loginFailMaxTimes":3,
	"maxUploadFileSizeMb":30,
	"passwordComplexityEnabled":true,
	"regularChangePasswordMonths":3,
	"regularChangePasswordNotAllowRepeatTimes":3,
	"twoFactorLoginEnabled":false
}', 'SmartJob Sample2 update', '2025-04-12 20:19:49', '2024-08-13 11:44:49');

-- ----------------------------
-- Table structure for t_data_tracer
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_data_tracer";
CREATE TABLE "public"."t_data_tracer" (
  "data_tracer_id" BIGSERIAL,
  "data_id" int8 NOT NULL,
  "type" int4 NOT NULL,
  "content" text COLLATE "pg_catalog"."default",
  "diff_old" text COLLATE "pg_catalog"."default",
  "diff_new" text COLLATE "pg_catalog"."default",
  "extra_data" text COLLATE "pg_catalog"."default",
  "user_id" int8 NOT NULL,
  "user_type" int4 NOT NULL,
  "user_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "ip" varchar(50) COLLATE "pg_catalog"."default",
  "ip_region" varchar(1000) COLLATE "pg_catalog"."default",
  "user_agent" varchar(2000) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_data_tracer"."data_id" IS '各种单据的id';
COMMENT ON COLUMN "public"."t_data_tracer"."type" IS '单据类型';
COMMENT ON COLUMN "public"."t_data_tracer"."content" IS '操作内容';
COMMENT ON COLUMN "public"."t_data_tracer"."diff_old" IS '差异：旧的数据';
COMMENT ON COLUMN "public"."t_data_tracer"."diff_new" IS '差异：新的数据';
COMMENT ON COLUMN "public"."t_data_tracer"."extra_data" IS '额外信息';
COMMENT ON COLUMN "public"."t_data_tracer"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."t_data_tracer"."user_type" IS '用户类型：1 后管用户 ';
COMMENT ON COLUMN "public"."t_data_tracer"."user_name" IS '用户名称';
COMMENT ON COLUMN "public"."t_data_tracer"."ip" IS 'ip';
COMMENT ON COLUMN "public"."t_data_tracer"."ip_region" IS 'ip地区';
COMMENT ON COLUMN "public"."t_data_tracer"."user_agent" IS '用户ua';
COMMENT ON COLUMN "public"."t_data_tracer"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_data_tracer"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_data_tracer" IS '各种单据操作记录';

-- ----------------------------
-- Records of t_data_tracer
-- ----------------------------
INSERT INTO "public"."t_data_tracer" VALUES (35, 10, 1, '新增', NULL, NULL, NULL, 47, 1, '善逸', '127.0.0.1', '0|0|0|内网IP|内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 Edg/109.0.1518.61', '2023-10-07 19:02:24', '2023-10-07 19:02:24');
INSERT INTO "public"."t_data_tracer" VALUES (36, 11, 1, '新增', NULL, NULL, NULL, 1, 1, '管理员', '127.0.0.1', '0|0|0|内网IP|内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', '2023-12-01 19:55:53', '2023-12-01 19:55:53');
INSERT INTO "public"."t_data_tracer" VALUES (37, 12, 1, '新增', NULL, NULL, NULL, 1, 1, '管理员', '127.0.0.1', '0|0|0|内网IP|内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', '2023-12-01 19:57:26', '2023-12-01 19:57:26');
INSERT INTO "public"."t_data_tracer" VALUES (38, 11, 1, '', NULL, NULL, NULL, 1, 1, '管理员', '127.0.0.1', '0|0|0|内网IP|内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', '2023-12-01 19:58:09', '2023-12-01 19:58:09');
INSERT INTO "public"."t_data_tracer" VALUES (39, 2, 3, '修改企业信息', '统一社会信用代码:"1024lab"<br/>详细地址:"1024大楼"<br/>区县名称:"洛龙区"<br/>禁用状态:false<br/>类型:有限企业<br/>城市名称:"洛阳市"<br/>删除状态:false<br/>联系人:"卓大"<br/>省份名称:"河南省"<br/>企业logo:"public/common/fb827d63dda74a60ab8b4f70cc7c7d0a_20221022145641_jpg"<br/>联系人电话:"18637925892"<br/>企业名称:"1024创新实验室"<br/>邮箱:"lab1024@163.com"', '营业执照:"public/common/59b1ca99b7fe45d78678e6295798a699_20231201200459.jpg"<br/>统一社会信用代码:"1024lab1"<br/>详细地址:"1024大楼"<br/>区县名称:"洛龙区"<br/>禁用状态:false<br/>类型:外资企业<br/>城市名称:"洛阳市"<br/>删除状态:false<br/>联系人:"卓大1"<br/>省份名称:"河南省"<br/>企业logo:""<br/>联系人电话:"18637925892"<br/>企业名称:"1024创新实验室1"<br/>邮箱:"lab1024@163.com"', NULL, 1, 1, '管理员', '127.0.0.1', '0|0|0|内网IP|内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', '2023-12-01 20:05:05', '2023-12-01 20:05:05');
INSERT INTO "public"."t_data_tracer" VALUES (40, 2, 3, '修改企业信息', '营业执照:"public/common/59b1ca99b7fe45d78678e6295798a699_20231201200459.jpg"<br/>统一社会信用代码:"1024lab1"<br/>详细地址:"1024大楼"<br/>区县名称:"洛龙区"<br/>禁用状态:false<br/>类型:外资企业<br/>城市名称:"洛阳市"<br/>删除状态:false<br/>联系人:"卓大1"<br/>省份名称:"河南省"<br/>企业logo:""<br/>联系人电话:"18637925892"<br/>企业名称:"1024创新实验室1"<br/>邮箱:"lab1024@163.com"', '营业执照:"public/common/59b1ca99b7fe45d78678e6295798a699_20231201200459.jpg"<br/>统一社会信用代码:"1024lab"<br/>详细地址:"1024大楼"<br/>区县名称:"洛龙区"<br/>禁用状态:false<br/>类型:外资企业<br/>城市名称:"洛阳市"<br/>删除状态:false<br/>联系人:"卓大"<br/>省份名称:"河南省"<br/>企业logo:""<br/>联系人电话:"18637925892"<br/>企业名称:"1024创新实验室"<br/>邮箱:"lab1024@163.com"', NULL, 1, 1, '管理员', '127.0.0.1', '0|0|0|内网IP|内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', '2023-12-01 20:05:54', '2023-12-01 20:05:54');
INSERT INTO "public"."t_data_tracer" VALUES (41, 2, 3, '更新银行:<br/>', NULL, NULL, NULL, 1, 1, '管理员', '127.0.0.1', '0|0|0|内网IP|内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', '2023-12-01 20:09:17', '2023-12-01 20:09:17');
INSERT INTO "public"."t_data_tracer" VALUES (42, 2, 3, '更新发票：<br/>删除状态:由【false】变更为【】', NULL, NULL, NULL, 1, 1, '管理员', '127.0.0.1', '0|0|0|内网IP|内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', '2023-12-01 20:09:20', '2023-12-01 20:09:20');
INSERT INTO "public"."t_data_tracer" VALUES (49, 1, 3, '修改企业信息', '营业执照:"public/common/852b7e19bef94af39c1a6156edf47cfb_20221022170332_jpg"<br/>统一社会信用代码:"1024lab_block"<br/>详细地址:"区块链大楼"<br/>区县名称:"洛龙区"<br/>禁用状态:false<br/>类型:有限企业<br/>城市名称:"洛阳市"<br/>删除状态:false<br/>联系人:"开云"<br/>省份名称:"河南省"<br/>企业logo:"public/common/f4a76fa720814949a610f05f6f9545bf_20221022170256_jpg"<br/>联系人电话:"18637925892"<br/>企业名称:"1024创新区块链实验室"', '营业执照:"public/common/1d89055e5680426280446aff1e7e627c_20240306112451.jpeg"<br/>统一社会信用代码:"1024lab_block"<br/>详细地址:"区块链大楼"<br/>区县名称:"洛龙区"<br/>禁用状态:false<br/>类型:有限企业<br/>城市名称:"洛阳市"<br/>删除状态:false<br/>联系人:"开云"<br/>省份名称:"河南省"<br/>企业logo:"public/common/34f5ac0fc097402294aea75352c128f0_20240306112435.png"<br/>联系人电话:"18637925892"<br/>企业名称:"1024创新区块链实验室"', NULL, 1, 1, '管理员', '127.0.0.1', '0|0|0|内网IP|内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', '2024-03-06 11:24:55', '2024-03-06 11:24:55');
INSERT INTO "public"."t_data_tracer" VALUES (99, 12, 1, '', NULL, NULL, NULL, 1, 1, '管理员', '127.0.0.1', '0|0|0|内网IP|内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', '2024-09-03 21:06:32', '2024-09-03 21:06:32');

-- ----------------------------
-- Table structure for t_department
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_department";
CREATE TABLE "public"."t_department" (
  "department_id" BIGSERIAL,
  "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "manager_id" int8,
  "parent_id" int8 NOT NULL,
  "sort" int4 NOT NULL,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_department"."department_id" IS '部门主键id';
COMMENT ON COLUMN "public"."t_department"."name" IS '部门名称';
COMMENT ON COLUMN "public"."t_department"."manager_id" IS '部门负责人id';
COMMENT ON COLUMN "public"."t_department"."parent_id" IS '部门的父级id';
COMMENT ON COLUMN "public"."t_department"."sort" IS '部门排序';
COMMENT ON COLUMN "public"."t_department"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_department"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_department" IS '部门';

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO "public"."t_department" VALUES (1, '1024创新实验室', 1, 0, 1, '2022-10-19 20:17:09', '2022-10-19 20:17:09');
INSERT INTO "public"."t_department" VALUES (2, '开发部', 44, 1, 1000, '2022-10-19 20:22:23', '2022-10-19 20:22:23');
INSERT INTO "public"."t_department" VALUES (3, '产品部', 2, 1, 99, '2022-10-21 10:25:30', '2022-10-21 10:25:30');
INSERT INTO "public"."t_department" VALUES (4, '销售部', 64, 1, 9, '2022-10-21 10:25:47', '2022-10-21 10:25:47');
INSERT INTO "public"."t_department" VALUES (5, '测试部', 48, 1, 0, '2022-11-05 10:54:18', '2022-11-05 10:54:18');
INSERT INTO "public"."t_department" VALUES (7, '直播组', 44, 1, 1111, '2024-07-02 19:38:15', '2024-07-02 19:38:15');
INSERT INTO "public"."t_department" VALUES (8, '抖音组', 47, 7, 0, '2024-07-02 19:39:11', '2024-07-02 19:39:11');

-- ----------------------------
-- Table structure for t_dict
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_dict";
CREATE TABLE "public"."t_dict" (
  "dict_id" BIGSERIAL,
  "dict_name" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "dict_code" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "remark" varchar(1000) COLLATE "pg_catalog"."default",
  "disabled_flag" bool NOT NULL  DEFAULT FALSE,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_dict"."dict_id" IS '字典id';
COMMENT ON COLUMN "public"."t_dict"."dict_name" IS '字典名字';
COMMENT ON COLUMN "public"."t_dict"."dict_code" IS '字典编码';
COMMENT ON COLUMN "public"."t_dict"."remark" IS '字典备注';
COMMENT ON COLUMN "public"."t_dict"."disabled_flag" IS '禁用状态';
COMMENT ON COLUMN "public"."t_dict"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_dict"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_dict" IS '字典表';

-- ----------------------------
-- Records of t_dict
-- ----------------------------
INSERT INTO "public"."t_dict" VALUES (1, '商品地区', 'GOODS_PLACE', '用于商品管理中的商品地区1', false, '2025-03-27 14:42:26', '2025-03-31 11:23:03');

-- ----------------------------
-- Table structure for t_dict_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_dict_data";
CREATE TABLE "public"."t_dict_data" (
  "dict_data_id" BIGSERIAL,
  "dict_id" int8 NOT NULL,
  "data_value" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "data_label" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "remark" varchar(1000) COLLATE "pg_catalog"."default",
  "sort_order" int4 NOT NULL,
  "disabled_flag" bool NOT NULL  DEFAULT FALSE,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_dict_data"."dict_data_id" IS '字典数据id';
COMMENT ON COLUMN "public"."t_dict_data"."dict_id" IS '字典id';
COMMENT ON COLUMN "public"."t_dict_data"."data_value" IS '字典项值';
COMMENT ON COLUMN "public"."t_dict_data"."data_label" IS '字典项显示名称';
COMMENT ON COLUMN "public"."t_dict_data"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_dict_data"."sort_order" IS '排序（越大越靠前）';
COMMENT ON COLUMN "public"."t_dict_data"."disabled_flag" IS '禁用状态';
COMMENT ON COLUMN "public"."t_dict_data"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_dict_data"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_dict_data" IS '字典数据表';

-- ----------------------------
-- Records of t_dict_data
-- ----------------------------
INSERT INTO "public"."t_dict_data" VALUES (2, 1, 'LUO_YANG', '洛阳', 'sad', 2, false, '2025-03-27 15:52:39', '2025-03-27 20:53:21');
INSERT INTO "public"."t_dict_data" VALUES (3, 1, 'ZHENG_ZHOU', '郑州', '', 0, false, '2025-03-27 18:58:16', '2025-03-27 20:53:32');
INSERT INTO "public"."t_dict_data" VALUES (7, 1, 'BEI_JING', '北京', '', 0, false, '2025-03-27 20:53:45', '2025-03-27 20:53:45');
INSERT INTO "public"."t_dict_data" VALUES (8, 1, 'SHANG_HAI', '上海', '', 0, false, '2025-03-27 20:53:45', '2025-03-27 20:53:45');

-- ----------------------------
-- Table structure for t_employee
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_employee";
CREATE TABLE "public"."t_employee" (
  "employee_id" BIGSERIAL,
  "login_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "login_pwd" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "actual_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "avatar" varchar(200) COLLATE "pg_catalog"."default",
  "gender" int2 NOT NULL,
  "phone" varchar(15) COLLATE "pg_catalog"."default",
  "department_id" int8 NOT NULL,
  "position_id" int8,
  "email" varchar(100) COLLATE "pg_catalog"."default",
  "disabled_flag" bool NOT NULL  DEFAULT FALSE,
  "deleted_flag" bool NOT NULL  DEFAULT FALSE,
  "administrator_flag" bool NOT NULL  DEFAULT FALSE,
  "remark" varchar(200) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_employee"."employee_id" IS '主键';
COMMENT ON COLUMN "public"."t_employee"."login_name" IS '登录帐号';
COMMENT ON COLUMN "public"."t_employee"."login_pwd" IS '登录密码';
COMMENT ON COLUMN "public"."t_employee"."actual_name" IS '员工名称';
COMMENT ON COLUMN "public"."t_employee"."gender" IS '性别';
COMMENT ON COLUMN "public"."t_employee"."phone" IS '手机号码';
COMMENT ON COLUMN "public"."t_employee"."department_id" IS '部门id';
COMMENT ON COLUMN "public"."t_employee"."position_id" IS '职务ID';
COMMENT ON COLUMN "public"."t_employee"."email" IS '邮箱';
COMMENT ON COLUMN "public"."t_employee"."disabled_flag" IS '是否被禁用 0否1是';
COMMENT ON COLUMN "public"."t_employee"."deleted_flag" IS '是否删除0否 1是';
COMMENT ON COLUMN "public"."t_employee"."administrator_flag" IS '是否为超级管理员: 0 不是，1是';
COMMENT ON COLUMN "public"."t_employee"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_employee"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_employee"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_employee" IS '员工表';

-- ----------------------------
-- Records of t_employee
-- ----------------------------
INSERT INTO "public"."t_employee" VALUES (1, 'admin', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '管理员', 'public/common/1eea469452484ffea4a42570c4072466_20240702220447.jpg', 0, '13500000000', 1, 3, NULL, false, false, true, NULL, '2024-09-03 21:39:17', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (2, 'huke', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '胡克', NULL, 0, '13123123121', 1, 4, NULL, false, false, false, NULL, '2024-09-03 21:36:09', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (44, 'zhuoda', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '卓大', NULL, 1, '18637925892', 1, 6, NULL, false, false, false, NULL, '2024-09-03 21:36:10', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (47, 'shanyi', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '善逸', 'public/common/f823b00873684f0a9d31f0d62316cc8e_20240630015141.jpg', 1, '17630506613', 2, 5, NULL, false, false, false, '这个是备注', '2024-09-03 21:36:11', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (48, 'qinjiu', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '琴酒', NULL, 2, '14112343212', 2, 6, NULL, false, false, false, NULL, '2024-09-03 21:36:12', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (63, 'kaiyun', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '开云', NULL, 0, '13112312346', 2, 5, NULL, false, false, false, NULL, '2024-09-03 21:36:13', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (64, 'qingye', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '清野', NULL, 1, '13123123111', 2, 4, NULL, false, false, false, NULL, '2024-09-03 21:36:14', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (65, 'feiye', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '飞叶', NULL, 1, '13123123112', 4, 3, NULL, false, false, false, NULL, '2024-09-03 21:36:14', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (66, 'luoyi', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '罗伊', NULL, 1, '13123123142', 4, 2, NULL, true, false, false, NULL, '2024-09-03 21:36:15', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (67, 'chuxiao', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '初晓', NULL, 1, '13123123123', 1, 2, NULL, true, false, false, NULL, '2024-09-03 21:36:18', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (68, 'xuanpeng', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '玄朋', NULL, 1, '13123123124', 1, 3, NULL, false, false, false, NULL, '2024-09-03 21:36:18', '2022-10-04 21:33:50');
INSERT INTO "public"."t_employee" VALUES (73, 'limbo', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '陈琳博', NULL, 1, '18906662339', 2, 4, NULL, false, false, false, NULL, '2024-09-03 21:36:24', '2024-07-17 10:36:16');
INSERT INTO "public"."t_employee" VALUES (74, 'xzh', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', 'admin1', NULL, 1, '13654567897', 5, 6, NULL, false, false, false, NULL, '2024-09-03 21:36:21', '2024-08-09 09:49:56');
INSERT INTO "public"."t_employee" VALUES (69, 'peixian', '$argon2id$v=19$m=16384,t=2,p=1$e/hqRAZYCYHydMS3SPo7yA$5hdCxLG7q+Jtf6KLJHVg/yb0I8LZrPuKUF66jLq+Drc', '玄朋', NULL, 1, '18377482773', 1, 4, '1534273@qq.com', false, false, false, NULL, '2025-04-11 22:50:26', '2022-10-04 21:33:50');

-- ----------------------------
-- Table structure for t_feedback
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_feedback";
CREATE TABLE "public"."t_feedback" (
  "feedback_id" BIGSERIAL,
  "feedback_content" text COLLATE "pg_catalog"."default",
  "feedback_attachment" varchar(500) COLLATE "pg_catalog"."default",
  "user_id" int8 NOT NULL,
  "user_type" int4 NOT NULL,
  "user_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_feedback"."feedback_id" IS '主键';
COMMENT ON COLUMN "public"."t_feedback"."feedback_content" IS '反馈内容';
COMMENT ON COLUMN "public"."t_feedback"."feedback_attachment" IS '反馈图片';
COMMENT ON COLUMN "public"."t_feedback"."user_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_feedback"."user_type" IS '创建人用户类型';
COMMENT ON COLUMN "public"."t_feedback"."user_name" IS '创建人姓名';
COMMENT ON COLUMN "public"."t_feedback"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_feedback"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_feedback" IS '意见反馈';

-- ----------------------------
-- Records of t_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for t_file
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_file";
CREATE TABLE "public"."t_file" (
  "file_id" BIGSERIAL,
  "folder_type" int2 NOT NULL,
  "file_name" varchar(100) COLLATE "pg_catalog"."default",
  "file_size" int4,
  "file_key" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "file_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "creator_id" int8,
  "creator_user_type" int4,
  "creator_name" varchar(100) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_file"."file_id" IS '主键ID';
COMMENT ON COLUMN "public"."t_file"."folder_type" IS '文件夹类型';
COMMENT ON COLUMN "public"."t_file"."file_name" IS '文件名称';
COMMENT ON COLUMN "public"."t_file"."file_size" IS '文件大小';
COMMENT ON COLUMN "public"."t_file"."file_key" IS '文件key，用于文件下载';
COMMENT ON COLUMN "public"."t_file"."file_type" IS '文件类型';
COMMENT ON COLUMN "public"."t_file"."creator_id" IS '创建人，即上传人';
COMMENT ON COLUMN "public"."t_file"."creator_user_type" IS '创建人用户类型';
COMMENT ON COLUMN "public"."t_file"."creator_name" IS '创建人姓名';
COMMENT ON COLUMN "public"."t_file"."update_time" IS '上次更新时间';
COMMENT ON COLUMN "public"."t_file"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_file" IS '文件';

-- ----------------------------
-- Records of t_file
-- ----------------------------

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_goods";
CREATE TABLE "public"."t_goods" (
  "goods_id" SERIAL,
  "goods_status" int4,
  "category_id" int4 NOT NULL,
  "goods_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "place" varchar(255) COLLATE "pg_catalog"."default",
  "price" numeric(10,2) NOT NULL,
  "shelves_flag" bool NOT NULL  DEFAULT FALSE,
  "deleted_flag" bool NOT NULL  DEFAULT FALSE,
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_goods"."goods_status" IS '商品状态:[1:预约中,2:售卖中,3:售罄]';
COMMENT ON COLUMN "public"."t_goods"."category_id" IS '商品类目';
COMMENT ON COLUMN "public"."t_goods"."goods_name" IS '商品名称';
COMMENT ON COLUMN "public"."t_goods"."place" IS '产地';
COMMENT ON COLUMN "public"."t_goods"."price" IS '价格';
COMMENT ON COLUMN "public"."t_goods"."shelves_flag" IS '上架状态';
COMMENT ON COLUMN "public"."t_goods"."deleted_flag" IS '删除状态';
COMMENT ON COLUMN "public"."t_goods"."remark" IS '备注';
COMMENT ON TABLE "public"."t_goods" IS '商品';

-- ----------------------------
-- Records of t_goods
-- ----------------------------
INSERT INTO "public"."t_goods" VALUES (1, 1, 353, 'Mote60', 'BEI_JING', 9999.00, true, false, NULL, '2022-10-21 19:57:49', '2021-09-01 22:25:30');
INSERT INTO "public"."t_goods" VALUES (7, 1, 352, 'iphone15 pro', 'LUO_YANG', 50000.00, true, false, '备注', '2024-06-16 09:34:08', '2022-10-21 19:58:07');
INSERT INTO "public"."t_goods" VALUES (8, 1, 352, 'iphone14', 'ZHENG_ZHOU', 150.00, false, false, '', '2022-10-21 19:12:49', '2022-10-21 19:00:11');
INSERT INTO "public"."t_goods" VALUES (10, 1, 357, '小米15', 'LUO_YANG', 7999.00, true, false, '', '2023-10-07 19:02:24', '2023-10-07 19:02:24');
INSERT INTO "public"."t_goods" VALUES (11, 1, 354, '青轴键盘', 'ZHENG_ZHOU', 199.00, true, false, '支持usb', '2023-12-01 19:58:09', '2023-12-01 19:55:53');
INSERT INTO "public"."t_goods" VALUES (12, 1, 356, '罗技双模鼠标', 'BEI_JING,ZHENG_ZHOU', 99.00, false, false, '支持蓝牙', '2024-09-03 21:06:32', '2023-12-01 19:57:25');

-- ----------------------------
-- Table structure for t_heart_beat_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_heart_beat_record";
CREATE TABLE "public"."t_heart_beat_record" (
  "heart_beat_record_id" SERIAL,
  "project_path" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "server_ip" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "process_no" int4 NOT NULL,
  "process_start_time" timestamp(6) NOT NULL,
  "heart_beat_time" timestamp(6) NOT NULL
)
;
COMMENT ON COLUMN "public"."t_heart_beat_record"."heart_beat_record_id" IS '自增id';
COMMENT ON COLUMN "public"."t_heart_beat_record"."project_path" IS '项目名称';
COMMENT ON COLUMN "public"."t_heart_beat_record"."server_ip" IS '服务器ip';
COMMENT ON COLUMN "public"."t_heart_beat_record"."process_no" IS '进程号';
COMMENT ON COLUMN "public"."t_heart_beat_record"."process_start_time" IS '进程开启时间';
COMMENT ON COLUMN "public"."t_heart_beat_record"."heart_beat_time" IS '心跳时间';
COMMENT ON TABLE "public"."t_heart_beat_record" IS '公用服务 - 服务心跳';

-- ----------------------------
-- Records of t_heart_beat_record
-- ----------------------------

-- ----------------------------
-- Table structure for t_help_doc
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_help_doc";
CREATE TABLE "public"."t_help_doc" (
  "help_doc_id" BIGSERIAL,
  "help_doc_catalog_id" int8 NOT NULL,
  "title" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "content_text" text COLLATE "pg_catalog"."default" NOT NULL,
  "content_html" text COLLATE "pg_catalog"."default" NOT NULL,
  "attachment" varchar(1000) COLLATE "pg_catalog"."default",
  "sort" int4 NOT NULL,
  "page_view_count" int4 NOT NULL,
  "user_view_count" int4 NOT NULL,
  "author" varchar(1000) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_help_doc"."help_doc_catalog_id" IS '类型1公告 2动态';
COMMENT ON COLUMN "public"."t_help_doc"."title" IS '标题';
COMMENT ON COLUMN "public"."t_help_doc"."content_text" IS '文本内容';
COMMENT ON COLUMN "public"."t_help_doc"."content_html" IS 'html内容';
COMMENT ON COLUMN "public"."t_help_doc"."attachment" IS '附件';
COMMENT ON COLUMN "public"."t_help_doc"."sort" IS '排序';
COMMENT ON COLUMN "public"."t_help_doc"."page_view_count" IS '页面浏览量，传说中的pv';
COMMENT ON COLUMN "public"."t_help_doc"."user_view_count" IS '用户浏览量，传说中的uv';
COMMENT ON COLUMN "public"."t_help_doc"."author" IS '作者';
COMMENT ON TABLE "public"."t_help_doc" IS '帮助文档';

-- ----------------------------
-- Records of t_help_doc
-- ----------------------------
INSERT INTO "public"."t_help_doc" VALUES (32, 6, '企业名称该写什么？', '需求1：管理公司基本信息，包含：企业名称、Logo、地区、营业执照、联系人 等等，可以 增删拆改需求2：管理公司的银行账户，包含：银行信息、账户名称、账号、类型等，可以 增删拆改需求3：管理公司的发票信息，包含：开票抬头、纳税号、银行账户、开户行、备注等，可以 增删拆改需求4：对于公司信息、银行信息、发票信息 任何的修改，都有记录 数据变动记录；', '<ul><li style="text-align: start;">需求1：管理公司基本信息，包含：企业名称、Logo、地区、营业执照、联系人 等等，可以 增删拆改</li><li style="text-align: start;">需求2：管理公司的银行账户，包含：银行信息、账户名称、账号、类型等，可以 增删拆改</li><li style="text-align: start;">需求3：管理公司的发票信息，包含：开票抬头、纳税号、银行账户、开户行、备注等，可以 增删拆改</li><li style="text-align: start;">需求4：对于公司信息、银行信息、发票信息 任何的修改，都有记录 数据变动记录；</li></ul>', '', 0, 55, 1, '卓大', '2024-07-07 23:15:28', '2022-11-22 10:41:48');
INSERT INTO "public"."t_help_doc" VALUES (33, 6, '谁有权限查看企业信息', '需求1：管理公司基本信息，包含：企业名称、Logo、地区、营业执照、联系人 等等，可以 增删拆改需求2：管理公司的银行账户，包含：银行信息、账户名称、账号、类型等，可以 增删拆改需求3：管理公司的发票信息，包含：开票抬头、纳税号、银行账户、开户行、备注等，可以 增删拆改需求4：对于公司信息、银行信息、发票信息 任何的修改，都有记录 数据变动记录；', '<ul><li style="text-align: start;">需求1：管理公司基本信息，包含：企业名称、Logo、地区、营业执照、联系人 等等，可以 增删拆改</li><li style="text-align: start;">需求2：管理公司的银行账户，包含：银行信息、账户名称、账号、类型等，可以 增删拆改</li><li style="text-align: start;">需求3：管理公司的发票信息，包含：开票抬头、纳税号、银行账户、开户行、备注等，可以 增删拆改</li><li style="text-align: start;">需求4：对于公司信息、银行信息、发票信息 任何的修改，都有记录 数据变动记录；</li></ul>', '', 0, 13, 1, '卓大', '2024-04-10 19:36:55', '2022-11-22 10:42:19');

-- ----------------------------
-- Table structure for t_help_doc_catalog
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_help_doc_catalog";
CREATE TABLE "public"."t_help_doc_catalog" (
  "help_doc_catalog_id" BIGSERIAL,
  "name" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
  "sort" int4 NOT NULL,
  "parent_id" int8 NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_help_doc_catalog"."help_doc_catalog_id" IS '帮助文档目录';
COMMENT ON COLUMN "public"."t_help_doc_catalog"."name" IS '名称';
COMMENT ON COLUMN "public"."t_help_doc_catalog"."sort" IS '排序字段';
COMMENT ON COLUMN "public"."t_help_doc_catalog"."parent_id" IS '父级id';
COMMENT ON TABLE "public"."t_help_doc_catalog" IS '帮助文档-目录';

-- ----------------------------
-- Records of t_help_doc_catalog
-- ----------------------------
INSERT INTO "public"."t_help_doc_catalog" VALUES (6, '企业信息', 0, 0, '2022-11-05 10:52:40', '2022-11-22 10:37:38');
INSERT INTO "public"."t_help_doc_catalog" VALUES (9, '企业信用', 0, 6, '2023-12-01 20:16:54', '2023-12-01 20:16:54');
INSERT INTO "public"."t_help_doc_catalog" VALUES (10, '采购文档', 0, 11, '2023-12-01 20:17:08', '2023-12-01 20:17:29');
INSERT INTO "public"."t_help_doc_catalog" VALUES (11, '进销存', 0, 0, '2023-12-01 20:17:23', '2023-12-01 20:17:23');

-- ----------------------------
-- Table structure for t_help_doc_relation
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_help_doc_relation";
CREATE TABLE "public"."t_help_doc_relation" (
  "relation_id" int8 NOT NULL,
  "relation_name" varchar(255) COLLATE "pg_catalog"."default",
  "help_doc_id" int8 NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_help_doc_relation"."relation_id" IS '关联id';
COMMENT ON COLUMN "public"."t_help_doc_relation"."relation_name" IS '关联名称';
COMMENT ON COLUMN "public"."t_help_doc_relation"."help_doc_id" IS '文档id';
COMMENT ON TABLE "public"."t_help_doc_relation" IS '帮助文档-关联表';

-- ----------------------------
-- Records of t_help_doc_relation
-- ----------------------------
INSERT INTO "public"."t_help_doc_relation" VALUES (0, '首页', 32, '2023-12-04 13:34:17', '2023-12-04 13:34:17');
INSERT INTO "public"."t_help_doc_relation" VALUES (0, '首页', 33, '2023-12-04 13:34:21', '2023-12-04 13:34:21');

-- ----------------------------
-- Table structure for t_help_doc_view_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_help_doc_view_record";
CREATE TABLE "public"."t_help_doc_view_record" (
  "help_doc_id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "user_name" varchar(255) COLLATE "pg_catalog"."default",
  "page_view_count" int4,
  "first_ip" varchar(255) COLLATE "pg_catalog"."default",
  "first_user_agent" varchar(1000) COLLATE "pg_catalog"."default",
  "last_ip" varchar(255) COLLATE "pg_catalog"."default",
  "last_user_agent" varchar(1000) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_help_doc_view_record"."help_doc_id" IS '通知公告id';
COMMENT ON COLUMN "public"."t_help_doc_view_record"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."t_help_doc_view_record"."user_name" IS '用户名称';
COMMENT ON COLUMN "public"."t_help_doc_view_record"."page_view_count" IS '查看次数';
COMMENT ON COLUMN "public"."t_help_doc_view_record"."first_ip" IS '首次ip';
COMMENT ON COLUMN "public"."t_help_doc_view_record"."first_user_agent" IS '首次用户设备等标识';
COMMENT ON COLUMN "public"."t_help_doc_view_record"."last_ip" IS '最后一次ip';
COMMENT ON COLUMN "public"."t_help_doc_view_record"."last_user_agent" IS '最后一次用户设备等标识';
COMMENT ON TABLE "public"."t_help_doc_view_record" IS '帮助文档-查看记录';

-- ----------------------------
-- Records of t_help_doc_view_record
-- ----------------------------

-- ----------------------------
-- Table structure for t_login_fail
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_login_fail";
CREATE TABLE "public"."t_login_fail" (
  "login_fail_id" BIGSERIAL,
  "user_id" int8 NOT NULL,
  "user_type" int4 NOT NULL,
  "login_name" varchar(1000) COLLATE "pg_catalog"."default",
  "login_fail_count" int4,
  "lock_flag" bool NOT NULL DEFAULT FALSE,
  "login_lock_begin_time" timestamp(6),
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_login_fail"."login_fail_id" IS '自增id';
COMMENT ON COLUMN "public"."t_login_fail"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."t_login_fail"."user_type" IS '用户类型';
COMMENT ON COLUMN "public"."t_login_fail"."login_name" IS '登录名';
COMMENT ON COLUMN "public"."t_login_fail"."login_fail_count" IS '连续登录失败次数';
COMMENT ON COLUMN "public"."t_login_fail"."lock_flag" IS '锁定状态:1锁定，0未锁定';
COMMENT ON COLUMN "public"."t_login_fail"."login_lock_begin_time" IS '连续登录失败锁定开始时间';
COMMENT ON COLUMN "public"."t_login_fail"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_login_fail"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_login_fail" IS '登录失败次数记录表';

-- ----------------------------
-- Records of t_login_fail
-- ----------------------------

-- ----------------------------
-- Table structure for t_login_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_login_log";
CREATE TABLE "public"."t_login_log" (
  "login_log_id" BIGSERIAL,
  "user_id" int4 NOT NULL,
  "user_type" int4 NOT NULL,
  "user_name" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
  "login_ip" varchar(1000) COLLATE "pg_catalog"."default",
  "login_ip_region" varchar(1000) COLLATE "pg_catalog"."default",
  "user_agent" text COLLATE "pg_catalog"."default",
  "login_device" varchar(1000) COLLATE "pg_catalog"."default",
  "login_result" int4 NOT NULL,
  "remark" varchar(2000) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_login_log"."login_log_id" IS '主键';
COMMENT ON COLUMN "public"."t_login_log"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."t_login_log"."user_type" IS '用户类型';
COMMENT ON COLUMN "public"."t_login_log"."user_name" IS '用户名';
COMMENT ON COLUMN "public"."t_login_log"."login_ip" IS '用户ip';
COMMENT ON COLUMN "public"."t_login_log"."login_ip_region" IS '用户ip地区';
COMMENT ON COLUMN "public"."t_login_log"."user_agent" IS 'user-agent信息';
COMMENT ON COLUMN "public"."t_login_log"."login_device" IS '登录设备';
COMMENT ON COLUMN "public"."t_login_log"."login_result" IS '登录结果：0成功 1失败 2 退出';
COMMENT ON COLUMN "public"."t_login_log"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_login_log"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_login_log"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_login_log" IS '用户登录日志';

-- ----------------------------
-- Records of t_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_mail_template
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_mail_template";
CREATE TABLE "public"."t_mail_template" (
  "template_code" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "template_subject" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "template_content" text COLLATE "pg_catalog"."default" NOT NULL,
  "template_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "disable_flag" bool NOT NULL  DEFAULT FALSE,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_mail_template"."template_subject" IS '模板名称';
COMMENT ON COLUMN "public"."t_mail_template"."template_content" IS '模板内容';
COMMENT ON COLUMN "public"."t_mail_template"."template_type" IS '解析类型 string，freemarker';
COMMENT ON COLUMN "public"."t_mail_template"."disable_flag" IS '是否禁用';
COMMENT ON COLUMN "public"."t_mail_template"."update_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_mail_template"."create_time" IS '创建时间';

-- ----------------------------
-- Records of t_mail_template
-- ----------------------------
INSERT INTO "public"."t_mail_template" VALUES ('login_verification_code', '登录验证码', '<!DOCTYPE HTML>
<html>
<head>
  <title>登录提醒</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <style>
      * {
          font-family: SimSun;
          /* 4号字体 */
          font-size: 18px;
          /* 22磅行间距 */
          line-height: 29px;
      }

      .main_font_size {
          font-size: 12.0pt;
      }

      .mainContent {
          line-height: 28px;
      }

      p {
          margin: 0 auto;
          text-align: justify;
      }
  </style>

</head>
<body>
<div>
  <div style="margin: 0px auto;width: 690px;">
    <div class="mainContent">
      <h1>验证码</h1>
      <p>请在验证页面输入此验证码</p>
      <p><b>${code}</b></p>
      <p>验证码将于此电子邮件发出 5 分钟后过期。</p>
      <p>如果你未曾提出此请求，可以忽略这封电子邮件。</p>
    </div>

  </div>
</div>
</body>
</html>', 'freemarker', false, '2024-08-06 09:13:08', '2024-07-28 13:56:06');

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_menu";
CREATE TABLE "public"."t_menu" (
  "menu_id" BIGSERIAL,
  "menu_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "menu_type" int4 NOT NULL,
  "parent_id" int8 NOT NULL,
  "sort" int4,
  "path" varchar(255) COLLATE "pg_catalog"."default",
  "component" varchar(255) COLLATE "pg_catalog"."default",
  "perms_type" int4,
  "api_perms" text COLLATE "pg_catalog"."default",
  "web_perms" text COLLATE "pg_catalog"."default",
  "icon" varchar(100) COLLATE "pg_catalog"."default",
  "context_menu_id" int8,
  "frame_flag" bool NOT NULL  DEFAULT FALSE,
  "frame_url" text COLLATE "pg_catalog"."default",
  "cache_flag" bool NOT NULL  DEFAULT FALSE,
  "visible_flag" bool NOT NULL  DEFAULT FALSE,
  "disabled_flag" bool NOT NULL  DEFAULT FALSE,
  "deleted_flag" bool NOT NULL  DEFAULT FALSE,
  "create_user_id" int8 NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_user_id" int8,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_menu"."menu_id" IS '菜单ID';
COMMENT ON COLUMN "public"."t_menu"."menu_name" IS '菜单名称';
COMMENT ON COLUMN "public"."t_menu"."menu_type" IS '类型';
COMMENT ON COLUMN "public"."t_menu"."parent_id" IS '父菜单ID';
COMMENT ON COLUMN "public"."t_menu"."sort" IS '显示顺序';
COMMENT ON COLUMN "public"."t_menu"."path" IS '路由地址';
COMMENT ON COLUMN "public"."t_menu"."component" IS '组件路径';
COMMENT ON COLUMN "public"."t_menu"."perms_type" IS '权限类型';
COMMENT ON COLUMN "public"."t_menu"."api_perms" IS '后端权限字符串';
COMMENT ON COLUMN "public"."t_menu"."web_perms" IS '前端权限字符串';
COMMENT ON COLUMN "public"."t_menu"."icon" IS '菜单图标';
COMMENT ON COLUMN "public"."t_menu"."context_menu_id" IS '功能点关联菜单ID';
COMMENT ON COLUMN "public"."t_menu"."frame_flag" IS '是否为外链';
COMMENT ON COLUMN "public"."t_menu"."frame_url" IS '外链地址';
COMMENT ON COLUMN "public"."t_menu"."cache_flag" IS '是否缓存';
COMMENT ON COLUMN "public"."t_menu"."visible_flag" IS '显示状态';
COMMENT ON COLUMN "public"."t_menu"."disabled_flag" IS '禁用状态';
COMMENT ON COLUMN "public"."t_menu"."deleted_flag" IS '删除状态';
COMMENT ON COLUMN "public"."t_menu"."create_user_id" IS '创建人';
COMMENT ON COLUMN "public"."t_menu"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_menu"."update_user_id" IS '更新人';
COMMENT ON COLUMN "public"."t_menu"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_menu" IS '菜单表';

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO "public"."t_menu" VALUES (26, '菜单管理', 2, 50, 1, '/menu/list', '/system/menu/menu-list.vue', NULL, NULL, NULL, 'CopyOutlined', NULL, false, NULL, true, true, false, false, 2, '2021-08-09 15:04:35', 1, '2023-12-01 19:39:03');
INSERT INTO "public"."t_menu" VALUES (40, '删除', 3, 26, NULL, NULL, NULL, 1, 'system:menu:batchDelete', 'system:menu:batchDelete', NULL, 26, false, NULL, false, true, false, false, 1, '2021-08-12 09:45:56', 1, '2023-10-07 18:15:50');
INSERT INTO "public"."t_menu" VALUES (45, '组织架构', 1, 0, 3, '/organization', NULL, NULL, NULL, NULL, 'UserSwitchOutlined', NULL, false, NULL, false, true, false, false, 1, '2021-08-12 16:13:27', 1, '2024-07-02 19:27:44');
INSERT INTO "public"."t_menu" VALUES (46, '员工管理', 2, 45, 3, '/organization/employee', '/system/employee/index.vue', NULL, NULL, NULL, 'AuditOutlined', NULL, false, NULL, false, true, false, false, 1, '2021-08-12 16:21:50', 1, '2024-07-02 20:15:23');
INSERT INTO "public"."t_menu" VALUES (47, '商品管理', 2, 48, 1, '/erp/goods/list', '/business/erp/goods/goods-list.vue', NULL, NULL, NULL, 'AliwangwangOutlined', NULL, false, NULL, true, true, false, false, 1, '2021-08-12 17:58:39', 1, '2023-12-01 19:33:08');
INSERT INTO "public"."t_menu" VALUES (48, '商品管理', 1, 138, 3, '/goods', NULL, NULL, NULL, NULL, 'BarcodeOutlined', NULL, false, NULL, false, true, false, false, 1, '2021-08-12 18:02:59', 1, '2024-07-08 13:58:46');
INSERT INTO "public"."t_menu" VALUES (50, '系统设置', 1, 0, 6, '/setting', NULL, NULL, NULL, NULL, 'SettingOutlined', NULL, false, NULL, false, true, false, false, 1, '2021-08-13 16:41:33', 1, '2023-12-01 19:38:03');
INSERT INTO "public"."t_menu" VALUES (76, '角色管理', 2, 45, 4, '/organization/role', '/system/role/index.vue', NULL, NULL, NULL, 'SlidersOutlined', NULL, false, NULL, false, true, false, false, 1, '2021-08-26 10:31:00', 1, '2024-07-02 20:15:28');
INSERT INTO "public"."t_menu" VALUES (78, '商品分类', 2, 48, 2, '/erp/catalog/goods', '/business/erp/catalog/goods-catalog.vue', NULL, NULL, NULL, 'ApartmentOutlined', NULL, false, NULL, true, true, false, false, 1, '2022-05-18 23:34:14', 1, '2023-12-01 19:33:13');
INSERT INTO "public"."t_menu" VALUES (79, '自定义分组', 2, 48, 3, '/erp/catalog/custom', '/business/erp/catalog/custom-catalog.vue', NULL, NULL, NULL, 'AppstoreAddOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-05-18 23:37:53', 1, '2023-12-01 19:33:16');
INSERT INTO "public"."t_menu" VALUES (81, '用户操作记录', 2, 213, 6, '/support/operate-log/operate-log-list', '/support/operate-log/operate-log-list.vue', NULL, NULL, NULL, 'VideoCameraOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-05-20 12:37:24', 44, '2024-08-13 14:34:10');
INSERT INTO "public"."t_menu" VALUES (85, '组件演示', 2, 84, NULL, '/demonstration/index', '/support/demonstration/index.vue', NULL, NULL, NULL, 'ClearOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-05-20 23:16:46', NULL, '2022-05-20 23:16:46');
INSERT INTO "public"."t_menu" VALUES (86, '添加部门', 3, 46, 1, NULL, NULL, 1, 'system:department:add', 'system:department:add', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-26 23:33:37', 1, '2023-10-07 18:26:35');
INSERT INTO "public"."t_menu" VALUES (87, '修改部门', 3, 46, 2, NULL, NULL, 1, 'system:department:update', 'system:department:update', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-26 23:34:11', 1, '2023-10-07 18:26:44');
INSERT INTO "public"."t_menu" VALUES (88, '删除部门', 3, 46, 3, NULL, NULL, 1, 'system:department:delete', 'system:department:delete', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-26 23:34:49', 1, '2023-10-07 18:26:49');
INSERT INTO "public"."t_menu" VALUES (91, '添加员工', 3, 46, NULL, NULL, NULL, 1, 'system:employee:add', 'system:employee:add', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:11:38', 1, '2023-10-07 18:27:46');
INSERT INTO "public"."t_menu" VALUES (92, '编辑员工', 3, 46, NULL, NULL, NULL, 1, 'system:employee:update', 'system:employee:update', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:12:10', 1, '2023-10-07 18:27:49');
INSERT INTO "public"."t_menu" VALUES (93, '禁用启用员工', 3, 46, NULL, NULL, NULL, 1, 'system:employee:disabled', 'system:employee:disabled', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:12:37', 1, '2023-10-07 18:27:53');
INSERT INTO "public"."t_menu" VALUES (94, '调整员工部门', 3, 46, NULL, NULL, NULL, 1, 'system:employee:department:update', 'system:employee:department:update', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:12:59', 1, '2023-10-07 18:27:34');
INSERT INTO "public"."t_menu" VALUES (95, '重置密码', 3, 46, NULL, NULL, NULL, 1, 'system:employee:password:reset', 'system:employee:password:reset', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:13:30', 1, '2023-10-07 18:27:57');
INSERT INTO "public"."t_menu" VALUES (96, '删除员工', 3, 46, NULL, NULL, NULL, 1, 'system:employee:delete', 'system:employee:delete', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:14:08', 1, '2023-10-07 18:28:01');
INSERT INTO "public"."t_menu" VALUES (97, '添加角色', 3, 76, NULL, NULL, NULL, 1, 'system:role:add', 'system:role:add', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:34:00', 1, '2023-10-07 18:42:31');
INSERT INTO "public"."t_menu" VALUES (98, '删除角色', 3, 76, NULL, NULL, NULL, 1, 'system:role:delete', 'system:role:delete', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:34:19', 1, '2023-10-07 18:42:35');
INSERT INTO "public"."t_menu" VALUES (99, '编辑角色', 3, 76, NULL, NULL, NULL, 1, 'system:role:update', 'system:role:update', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:34:55', 1, '2023-10-07 18:42:44');
INSERT INTO "public"."t_menu" VALUES (100, '更新数据范围', 3, 76, NULL, NULL, NULL, 1, 'system:role:dataScope:update', 'system:role:dataScope:update', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:37:03', 1, '2023-10-07 18:41:49');
INSERT INTO "public"."t_menu" VALUES (101, '批量移除员工', 3, 76, NULL, NULL, NULL, 1, 'system:role:employee:batch:delete', 'system:role:employee:batch:delete', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:39:05', 1, '2023-10-07 18:43:32');
INSERT INTO "public"."t_menu" VALUES (102, '移除员工', 3, 76, NULL, NULL, NULL, 1, 'system:role:employee:delete', 'system:role:employee:delete', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:39:21', 1, '2023-10-07 18:43:37');
INSERT INTO "public"."t_menu" VALUES (103, '添加员工', 3, 76, NULL, NULL, NULL, 1, 'system:role:employee:add', 'system:role:employee:add', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:39:38', 1, '2023-10-07 18:44:05');
INSERT INTO "public"."t_menu" VALUES (104, '修改权限', 3, 76, NULL, NULL, NULL, 1, 'system:role:menu:update', 'system:role:menu:update', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-05-27 00:41:55', 1, '2023-10-07 18:44:11');
INSERT INTO "public"."t_menu" VALUES (105, '添加', 3, 26, NULL, NULL, NULL, 1, 'system:menu:add', 'system:menu:add', NULL, 26, false, NULL, false, true, false, false, 1, '2022-05-27 00:44:37', 1, '2023-10-07 17:35:35');
INSERT INTO "public"."t_menu" VALUES (106, '编辑', 3, 26, NULL, NULL, NULL, 1, 'system:menu:update', 'system:menu:update', NULL, 26, false, NULL, false, true, false, false, 1, '2022-05-27 00:44:59', 1, '2023-10-07 17:35:48');
INSERT INTO "public"."t_menu" VALUES (109, '参数配置', 2, 50, 3, '/config/config-list', '/support/config/config-list.vue', NULL, NULL, NULL, 'AntDesignOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-05-27 13:34:41', 1, '2022-06-23 16:24:16');
INSERT INTO "public"."t_menu" VALUES (110, '数据字典', 2, 50, 4, '/setting/dict', '/support/dict/index.vue', NULL, NULL, NULL, 'BarcodeOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-05-27 17:53:00', 1, '2022-05-27 18:09:14');
INSERT INTO "public"."t_menu" VALUES (111, '监控服务', 1, 0, 100, '/monitor', NULL, NULL, NULL, NULL, 'BarChartOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-06-17 11:13:23', 1, '2023-11-28 17:43:56');
INSERT INTO "public"."t_menu" VALUES (113, '查询', 3, 112, NULL, NULL, NULL, NULL, NULL, 'ad', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-06-17 11:31:36', NULL, '2022-06-17 11:31:36');
INSERT INTO "public"."t_menu" VALUES (114, '运维工具', 1, 0, 200, NULL, NULL, NULL, NULL, NULL, 'NodeCollapseOutlined', NULL, false, NULL, false, true, false, true, 1, '2022-06-20 10:09:16', 1, '2023-12-01 19:36:18');
INSERT INTO "public"."t_menu" VALUES (117, 'Reload', 2, 50, 12, '/hook', '/support/reload/reload-list.vue', NULL, NULL, NULL, 'ReloadOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-06-20 10:16:49', 1, '2023-12-01 19:39:17');
INSERT INTO "public"."t_menu" VALUES (122, '数据库监控', 2, 111, 4, '/support/druid/index', NULL, NULL, NULL, NULL, 'ConsoleSqlOutlined', NULL, true, 'http://localhost:1024/druid', true, true, false, false, 1, '2022-06-20 14:49:33', 1, '2023-02-16 19:15:58');
INSERT INTO "public"."t_menu" VALUES (130, '单号管理', 2, 50, 6, '/support/serial-number/serial-number-list', '/support/serial-number/serial-number-list.vue', NULL, NULL, NULL, 'NumberOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-06-24 14:45:22', 1, '2022-06-28 16:23:41');
INSERT INTO "public"."t_menu" VALUES (132, '公告管理', 2, 138, 2, '/oa/notice/notice-list', '/business/oa/notice/notice-list.vue', NULL, NULL, NULL, 'SoundOutlined', NULL, false, NULL, true, true, false, false, 1, '2022-06-24 18:23:09', 1, '2024-07-08 13:58:51');
INSERT INTO "public"."t_menu" VALUES (133, '缓存管理', 2, 50, 11, '/support/cache/cache-list', '/support/cache/cache-list.vue', NULL, NULL, NULL, 'BorderInnerOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-06-24 18:52:25', 1, '2023-12-01 19:39:13');
INSERT INTO "public"."t_menu" VALUES (138, '功能Demo', 1, 0, 1, NULL, NULL, NULL, NULL, NULL, 'BankOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-06-24 20:09:18', 1, '2024-07-08 13:46:54');
INSERT INTO "public"."t_menu" VALUES (142, '公告详情', 2, 132, NULL, '/oa/notice/notice-detail', '/business/oa/notice/notice-detail.vue', NULL, NULL, NULL, NULL, NULL, false, NULL, false, false, false, false, 1, '2022-06-25 16:38:47', 1, '2022-09-14 19:46:17');
INSERT INTO "public"."t_menu" VALUES (143, '登录登出记录', 2, 213, 5, '/support/login-log/login-log-list', '/support/login-log/login-log-list.vue', NULL, NULL, NULL, 'LoginOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-06-28 15:01:38', 44, '2024-08-13 14:33:49');
INSERT INTO "public"."t_menu" VALUES (144, '企业管理', 2, 138, 1, '/oa/enterprise/enterprise-list', '/business/oa/enterprise/enterprise-list.vue', NULL, NULL, NULL, 'ShopOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-09-14 17:00:07', 1, '2024-07-08 13:48:24');
INSERT INTO "public"."t_menu" VALUES (145, '企业详情', 2, 138, NULL, '/oa/enterprise/enterprise-detail', '/business/oa/enterprise/enterprise-detail.vue', NULL, NULL, NULL, NULL, NULL, false, NULL, false, false, false, false, 1, '2022-09-14 18:52:52', 1, '2022-11-22 10:39:07');
INSERT INTO "public"."t_menu" VALUES (147, '帮助文档', 2, 218, 1, '/help-doc/help-doc-manage-list', '/support/help-doc/management/help-doc-manage-list.vue', NULL, NULL, NULL, 'FolderViewOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-09-14 19:59:01', 1, '2023-12-01 19:38:23');
INSERT INTO "public"."t_menu" VALUES (148, '意见反馈', 2, 218, 2, '/feedback/feedback-list', '/support/feedback/feedback-list.vue', NULL, NULL, NULL, 'CoffeeOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-09-14 19:59:52', 1, '2023-12-01 19:38:40');
INSERT INTO "public"."t_menu" VALUES (149, '我的通知', 2, 132, NULL, '/oa/notice/notice-employee-list', '/business/oa/notice/notice-employee-list.vue', NULL, NULL, NULL, NULL, NULL, false, NULL, false, false, false, false, 1, '2022-09-14 20:29:41', 1, '2022-09-14 20:31:23');
INSERT INTO "public"."t_menu" VALUES (150, '我的通知公告详情', 2, 132, NULL, '/oa/notice/notice-employee-detail', '/business/oa/notice/notice-employee-detail.vue', NULL, NULL, NULL, NULL, NULL, false, NULL, false, false, false, false, 1, '2022-09-14 20:30:25', 1, '2022-09-14 20:31:38');
INSERT INTO "public"."t_menu" VALUES (151, '代码生成', 2, 0, 600, '/support/code-generator', '/support/code-generator/code-generator-list.vue', NULL, NULL, NULL, 'CoffeeOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-09-21 18:25:05', 1, '2022-10-22 11:27:58');
INSERT INTO "public"."t_menu" VALUES (152, '更新日志', 2, 218, 3, '/support/change-log/change-log-list', '/support/change-log/change-log-list.vue', NULL, NULL, NULL, 'HeartOutlined', NULL, false, NULL, false, true, false, false, 44, '2022-10-10 10:31:20', 1, '2023-12-01 19:38:51');
INSERT INTO "public"."t_menu" VALUES (153, '清除缓存', 3, 133, NULL, NULL, NULL, 1, 'support:cache:delete', 'support:cache:delete', NULL, 133, false, NULL, false, true, true, false, 1, '2022-10-15 22:45:13', 1, '2023-10-07 16:22:29');
INSERT INTO "public"."t_menu" VALUES (154, '获取缓存key', 3, 133, NULL, NULL, NULL, 1, 'support:cache:keys', 'support:cache:keys', NULL, 133, false, NULL, false, true, true, false, 1, '2022-10-15 22:45:48', 1, '2023-10-07 16:22:35');
INSERT INTO "public"."t_menu" VALUES (156, '查看结果', 3, 117, NULL, NULL, NULL, 1, 'support:reload:result', 'support:reload:result', NULL, 117, false, NULL, false, true, false, false, 1, '2022-10-15 23:17:23', 1, '2023-10-07 14:31:47');
INSERT INTO "public"."t_menu" VALUES (157, '单号生成', 3, 130, NULL, NULL, NULL, 1, 'support:serialNumber:generate', 'support:serialNumber:generate', NULL, 130, false, NULL, false, true, false, false, 1, '2022-10-15 23:21:06', 1, '2023-10-07 18:22:46');
INSERT INTO "public"."t_menu" VALUES (158, '生成记录', 3, 130, NULL, NULL, NULL, 1, 'support:serialNumber:record', 'support:serialNumber:record', NULL, 130, false, NULL, false, true, false, false, 1, '2022-10-15 23:21:34', 1, '2023-10-07 18:22:55');
INSERT INTO "public"."t_menu" VALUES (159, '查询', 3, 110, NULL, NULL, NULL, 1, 'support:dict:query', 'support:dict:query', NULL, 110, false, NULL, false, true, false, false, 1, '2022-10-15 23:23:51', 1, '2025-04-08 19:42:25');
INSERT INTO "public"."t_menu" VALUES (160, '添加', 3, 110, NULL, NULL, NULL, 1, 'support:dict:add', 'support:dict:add', NULL, 110, false, NULL, false, true, false, false, 1, '2022-10-15 23:24:05', 1, '2025-04-08 19:43:02');
INSERT INTO "public"."t_menu" VALUES (161, '更新', 3, 110, NULL, NULL, NULL, 1, 'support:dict:update', 'support:dict:update', NULL, 110, false, NULL, false, true, false, false, 1, '2022-10-15 23:24:34', 1, '2025-04-08 19:43:34');
INSERT INTO "public"."t_menu" VALUES (162, '删除', 3, 110, NULL, NULL, NULL, 1, 'support:dict:delete', 'support:dict:delete', NULL, 110, false, NULL, false, true, false, false, 1, '2022-10-15 23:24:55', 1, '2025-04-08 19:43:52');
INSERT INTO "public"."t_menu" VALUES (163, '新建', 3, 109, NULL, NULL, NULL, 1, 'support:config:add', 'support:config:add', NULL, 109, false, NULL, false, true, false, false, 1, '2022-10-15 23:26:56', 1, '2023-10-07 18:16:17');
INSERT INTO "public"."t_menu" VALUES (164, '编辑', 3, 109, NULL, NULL, NULL, 1, 'support:config:update', 'support:config:update', NULL, 109, false, NULL, false, true, false, false, 1, '2022-10-15 23:27:07', 1, '2023-10-07 18:16:24');
INSERT INTO "public"."t_menu" VALUES (165, '查询', 3, 47, NULL, NULL, NULL, 1, 'goods:query', 'goods:query', NULL, 47, false, NULL, false, true, false, false, 1, '2022-10-16 19:55:39', 1, '2023-10-07 13:58:28');
INSERT INTO "public"."t_menu" VALUES (166, '新建', 3, 47, NULL, NULL, NULL, 1, 'goods:add', 'goods:add', NULL, 47, false, NULL, false, true, false, false, 1, '2022-10-16 19:56:00', 1, '2023-10-07 13:58:32');
INSERT INTO "public"."t_menu" VALUES (167, '批量删除', 3, 47, NULL, NULL, NULL, 1, 'goods:batchDelete', 'goods:batchDelete', NULL, 47, false, NULL, false, true, false, false, 1, '2022-10-16 19:56:15', 1, '2023-10-07 13:58:35');
INSERT INTO "public"."t_menu" VALUES (168, '查询', 3, 147, 11, NULL, NULL, 1, 'support:helpDoc:query', 'support:helpDoc:query', NULL, 147, false, NULL, false, true, false, false, 1, '2022-10-16 20:12:13', 1, '2023-10-07 14:05:49');
INSERT INTO "public"."t_menu" VALUES (169, '新建', 3, 147, 12, NULL, NULL, 1, 'support:helpDoc:add', 'support:helpDoc:add', NULL, 147, false, NULL, false, true, false, false, 1, '2022-10-16 20:12:37', 1, '2023-10-07 14:05:56');
INSERT INTO "public"."t_menu" VALUES (170, '新建目录', 3, 147, 1, NULL, NULL, 1, 'support:helpDocCatalog:addCategory', 'support:helpDocCatalog:addCategory', NULL, 147, false, NULL, false, true, false, false, 1, '2022-10-16 20:12:57', 1, '2023-10-07 14:06:38');
INSERT INTO "public"."t_menu" VALUES (171, '修改目录', 3, 147, 2, NULL, NULL, 1, 'support:helpDocCatalog:update', 'support:helpDocCatalog:update', NULL, 147, false, NULL, false, true, false, false, 1, '2022-10-16 20:13:46', 1, '2023-10-07 14:06:49');
INSERT INTO "public"."t_menu" VALUES (173, '新建', 3, 78, NULL, NULL, NULL, 1, 'category:add', 'category:add', NULL, 78, false, NULL, false, true, false, false, 1, '2022-10-16 20:17:02', 1, '2023-10-07 13:54:01');
INSERT INTO "public"."t_menu" VALUES (174, '查询', 3, 78, NULL, NULL, NULL, 1, 'category:tree', 'category:tree', NULL, 78, false, NULL, false, true, false, false, 1, '2022-10-16 20:17:22', 1, '2023-10-07 13:54:33');
INSERT INTO "public"."t_menu" VALUES (175, '编辑', 3, 78, NULL, NULL, NULL, 1, 'category:update', 'category:update', NULL, 78, false, NULL, false, true, false, false, 1, '2022-10-16 20:17:38', 1, '2023-10-07 13:54:18');
INSERT INTO "public"."t_menu" VALUES (176, '删除', 3, 78, NULL, NULL, NULL, 1, 'category:delete', 'category:delete', NULL, 78, false, NULL, false, true, false, false, 1, '2022-10-16 20:17:50', 1, '2023-10-07 13:54:27');
INSERT INTO "public"."t_menu" VALUES (177, '新建', 3, 79, NULL, NULL, NULL, 1, 'category:add', 'custom:category:add', NULL, 78, false, NULL, false, true, false, false, 1, '2022-10-16 20:17:02', 1, '2023-10-07 13:57:32');
INSERT INTO "public"."t_menu" VALUES (178, '查询', 3, 79, NULL, NULL, NULL, 1, 'category:tree', 'custom:category:tree', NULL, 78, false, NULL, false, true, false, false, 1, '2022-10-16 20:17:22', 1, '2023-10-07 13:57:50');
INSERT INTO "public"."t_menu" VALUES (179, '编辑', 3, 79, NULL, NULL, NULL, 1, 'category:update', 'custom:category:update', NULL, 78, false, NULL, false, true, false, false, 1, '2022-10-16 20:17:38', 1, '2023-10-07 13:58:02');
INSERT INTO "public"."t_menu" VALUES (180, '删除', 3, 79, NULL, NULL, NULL, 1, 'category:delete', 'custom:category:delete', NULL, 78, false, NULL, false, true, false, false, 1, '2022-10-16 20:17:50', 1, '2023-10-07 13:58:12');
INSERT INTO "public"."t_menu" VALUES (181, '查询', 3, 144, NULL, NULL, NULL, 1, 'oa:enterprise:query', 'oa:enterprise:query', NULL, 144, false, NULL, false, true, false, false, 1, '2022-10-16 20:25:14', 1, '2023-10-07 12:00:09');
INSERT INTO "public"."t_menu" VALUES (182, '新建', 3, 144, NULL, NULL, NULL, 1, 'oa:enterprise:add', 'oa:enterprise:add', NULL, 144, false, NULL, false, true, false, false, 1, '2022-10-16 20:25:25', 1, '2023-10-07 12:00:17');
INSERT INTO "public"."t_menu" VALUES (183, '编辑', 3, 144, NULL, NULL, NULL, 1, 'oa:enterprise:update', 'oa:enterprise:update', NULL, 144, false, NULL, false, true, false, false, 1, '2022-10-16 20:25:36', 1, '2023-10-07 12:00:38');
INSERT INTO "public"."t_menu" VALUES (184, '删除', 3, 144, NULL, NULL, NULL, 1, 'oa:enterprise:delete', 'oa:enterprise:delete', NULL, 144, false, NULL, false, true, false, false, 1, '2022-10-16 20:25:53', 1, '2023-10-07 12:00:46');
INSERT INTO "public"."t_menu" VALUES (185, '查询', 3, 132, NULL, NULL, NULL, 1, 'oa:notice:query', 'oa:notice:query', NULL, 132, false, NULL, false, true, false, false, 1, '2022-10-16 20:26:38', 1, '2023-10-07 11:43:01');
INSERT INTO "public"."t_menu" VALUES (186, '新建', 3, 132, NULL, NULL, NULL, 1, 'oa:notice:add', 'oa:notice:add', NULL, 132, false, NULL, false, true, false, false, 1, '2022-10-16 20:27:04', 1, '2023-10-07 11:43:07');
INSERT INTO "public"."t_menu" VALUES (187, '编辑', 3, 132, NULL, NULL, NULL, 1, 'oa:notice:update', 'oa:notice:update', NULL, 132, false, NULL, false, true, false, false, 1, '2022-10-16 20:27:15', 1, '2023-10-07 11:43:12');
INSERT INTO "public"."t_menu" VALUES (188, '删除', 3, 132, NULL, NULL, NULL, 1, 'oa:notice:delete', 'oa:notice:delete', NULL, 132, false, NULL, false, true, false, false, 1, '2022-10-16 20:27:23', 1, '2023-10-07 11:43:18');
INSERT INTO "public"."t_menu" VALUES (190, '查询', 3, 152, NULL, NULL, NULL, 1, '', 'support:changeLog:query', NULL, 152, false, NULL, false, true, false, false, 1, '2022-10-16 20:28:33', 1, '2023-10-07 14:25:05');
INSERT INTO "public"."t_menu" VALUES (191, '新建', 3, 152, NULL, NULL, NULL, 1, 'support:changeLog:add', 'support:changeLog:add', NULL, 152, false, NULL, false, true, false, false, 1, '2022-10-16 20:28:46', 1, '2023-10-07 14:24:15');
INSERT INTO "public"."t_menu" VALUES (192, '批量删除', 3, 152, NULL, NULL, NULL, 1, 'support:changeLog:batchDelete', 'support:changeLog:batchDelete', NULL, 152, false, NULL, false, true, false, false, 1, '2022-10-16 20:29:10', 1, '2023-10-07 14:24:22');
INSERT INTO "public"."t_menu" VALUES (193, '文件管理', 2, 50, 20, '/support/file/file-list', '/support/file/file-list.vue', NULL, NULL, NULL, 'FolderOpenOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-10-21 11:26:11', 1, '2022-10-22 11:29:22');
INSERT INTO "public"."t_menu" VALUES (194, '删除', 3, 47, NULL, NULL, NULL, 1, 'goods:delete', 'goods:delete', NULL, 47, false, NULL, false, true, false, false, 1, '2022-10-21 20:00:12', 1, '2023-10-07 13:58:39');
INSERT INTO "public"."t_menu" VALUES (195, '修改', 3, 47, NULL, NULL, NULL, 1, 'goods:update', 'goods:update', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-21 20:05:23', 1, '2023-10-07 13:58:42');
INSERT INTO "public"."t_menu" VALUES (196, '查看详情', 3, 145, NULL, NULL, NULL, 1, 'oa:enterprise:detail', 'oa:enterprise:detail', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-21 20:16:47', 1, '2023-10-07 11:48:59');
INSERT INTO "public"."t_menu" VALUES (198, '删除', 3, 152, NULL, NULL, NULL, 1, 'support:changeLog:delete', 'support:changeLog:delete', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-21 20:42:34', 1, '2023-10-07 14:24:32');
INSERT INTO "public"."t_menu" VALUES (199, '查询', 3, 109, NULL, NULL, NULL, 1, 'support:config:query', 'support:config:query', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-21 20:45:14', 1, '2023-10-07 18:16:27');
INSERT INTO "public"."t_menu" VALUES (200, '查询', 3, 193, NULL, NULL, NULL, 1, 'support:file:query', 'support:file:query', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-21 20:47:23', 1, '2023-10-07 18:24:43');
INSERT INTO "public"."t_menu" VALUES (201, '删除', 3, 147, 14, NULL, NULL, 1, 'support:helpDoc:delete', 'support:helpDoc:delete', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-21 21:03:20', 1, '2023-10-07 14:07:02');
INSERT INTO "public"."t_menu" VALUES (202, '更新', 3, 147, 13, NULL, NULL, 1, 'support:helpDoc:update', 'support:helpDoc:update', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-21 21:03:32', 1, '2023-10-07 14:06:56');
INSERT INTO "public"."t_menu" VALUES (203, '查询', 3, 143, NULL, NULL, NULL, 1, 'support:loginLog:query', 'support:loginLog:query', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-21 21:05:11', 1, '2023-10-07 14:27:23');
INSERT INTO "public"."t_menu" VALUES (204, '查询', 3, 81, NULL, NULL, NULL, 1, 'support:operateLog:query', 'support:operateLog:query', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-22 10:33:31', 1, '2023-10-07 14:27:56');
INSERT INTO "public"."t_menu" VALUES (205, '详情', 3, 81, NULL, NULL, NULL, 1, 'support:operateLog:detail', 'support:operateLog:detail', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-22 10:33:49', 1, '2023-10-07 14:28:04');
INSERT INTO "public"."t_menu" VALUES (206, '心跳监控', 2, 111, 1, '/support/heart-beat/heart-beat-list', '/support/heart-beat/heart-beat-list.vue', 1, NULL, NULL, 'FallOutlined', NULL, false, NULL, false, true, false, false, 1, '2022-10-22 10:47:03', 1, '2022-10-22 18:32:52');
INSERT INTO "public"."t_menu" VALUES (207, '更新', 3, 152, NULL, NULL, NULL, 1, 'support:changeLog:update', 'support:changeLog:update', NULL, NULL, false, NULL, false, true, false, false, 1, '2022-10-22 11:51:32', 1, '2023-10-07 14:24:39');
INSERT INTO "public"."t_menu" VALUES (212, '查询', 3, 117, NULL, NULL, NULL, 1, 'support:reload:query', 'support:reload:query', NULL, NULL, false, NULL, true, true, true, false, 1, '2023-10-07 14:31:36', NULL, '2023-10-07 14:31:36');
INSERT INTO "public"."t_menu" VALUES (213, '网络安全', 1, 0, 5, NULL, NULL, 1, NULL, NULL, 'SafetyCertificateOutlined', NULL, false, NULL, true, true, false, false, 1, '2023-10-17 19:03:08', 1, '2023-12-01 19:38:00');
INSERT INTO "public"."t_menu" VALUES (214, '登录失败锁定', 2, 213, 4, '/support/login-fail', '/support/login-fail/login-fail-list.vue', 1, NULL, NULL, 'LockOutlined', NULL, false, NULL, true, true, false, false, 1, '2023-10-17 19:04:24', 44, '2024-08-13 14:16:26');
INSERT INTO "public"."t_menu" VALUES (215, '接口加解密', 2, 213, 2, '/support/api-encrypt', '/support/api-encrypt/api-encrypt-index.vue', 1, NULL, NULL, 'CodepenCircleOutlined', NULL, false, NULL, true, true, false, false, 1, '2023-10-24 11:49:28', 44, '2024-08-13 12:00:14');
INSERT INTO "public"."t_menu" VALUES (216, '导出', 3, 47, NULL, NULL, NULL, 1, 'goods:exportGoods', 'goods:exportGoods', NULL, NULL, false, NULL, true, true, false, false, 1, '2023-12-01 19:34:03', NULL, '2023-12-01 19:34:03');
INSERT INTO "public"."t_menu" VALUES (217, '导入', 3, 47, 3, NULL, NULL, 1, 'goods:importGoods', 'goods:importGoods', NULL, NULL, false, NULL, true, true, false, false, 1, '2023-12-01 19:34:22', NULL, '2023-12-01 19:34:22');
INSERT INTO "public"."t_menu" VALUES (218, '文档中心', 1, 0, 4, NULL, NULL, 1, NULL, NULL, 'FileSearchOutlined', NULL, false, NULL, true, true, false, false, 1, '2023-12-01 19:37:28', 1, '2023-12-01 19:37:51');
INSERT INTO "public"."t_menu" VALUES (219, '部门管理', 2, 45, 1, '/organization/department', '/system/department/department-list.vue', 1, NULL, NULL, 'ApartmentOutlined', NULL, false, NULL, false, true, false, false, 1, '2024-06-22 16:40:21', 1, '2024-07-02 20:15:17');
INSERT INTO "public"."t_menu" VALUES (221, '定时任务', 2, 50, 25, '/job/list', '/support/job/job-list.vue', 1, NULL, NULL, 'AppstoreOutlined', NULL, false, NULL, true, true, false, false, 2, '2024-06-25 17:57:40', 2, '2024-06-25 19:49:21');
INSERT INTO "public"."t_menu" VALUES (228, '职务管理', 2, 45, 2, '/organization/position', '/system/position/position-list.vue', 1, NULL, NULL, 'ApartmentOutlined', NULL, false, NULL, true, true, false, false, 1, '2024-06-29 11:11:09', 1, '2024-07-02 20:15:11');
INSERT INTO "public"."t_menu" VALUES (229, '查询任务', 3, 221, NULL, NULL, NULL, 1, 'support:job:query', 'support:job:query', NULL, 221, false, NULL, true, true, false, false, 2, '2024-06-29 11:14:15', 2, '2024-06-29 11:15:00');
INSERT INTO "public"."t_menu" VALUES (230, '更新任务', 3, 221, NULL, NULL, NULL, 1, 'support:job:update', 'support:job:update', NULL, 221, false, NULL, true, true, false, false, 2, '2024-06-29 11:15:40', NULL, '2024-06-29 11:15:40');
INSERT INTO "public"."t_menu" VALUES (231, '执行任务', 3, 221, NULL, NULL, NULL, 1, 'support:job:execute', 'support:job:execute', NULL, 221, false, NULL, true, true, false, false, 2, '2024-06-29 11:16:03', NULL, '2024-06-29 11:16:03');
INSERT INTO "public"."t_menu" VALUES (232, '查询记录', 3, 221, NULL, NULL, NULL, 1, 'support:job:log:query', 'support:job:log:query', NULL, 221, false, NULL, true, true, false, false, 2, '2024-06-29 11:16:37', NULL, '2024-06-29 11:16:37');
INSERT INTO "public"."t_menu" VALUES (233, 'knife4j文档', 2, 218, 4, '/knife4j', NULL, 1, NULL, NULL, 'FileWordOutlined', NULL, true, 'http://localhost:1024/doc.html', true, true, false, false, 1, '2024-07-02 20:23:50', 1, '2024-07-08 13:49:15');
INSERT INTO "public"."t_menu" VALUES (234, 'swagger文档', 2, 218, 5, '/swagger', 'http://localhost:1024/swagger-ui/index.html', 1, NULL, NULL, 'ApiOutlined', NULL, true, 'http://localhost:1024/swagger-ui/index.html', true, true, false, false, 1, '2024-07-02 20:35:43', 1, '2024-07-08 13:49:26');
INSERT INTO "public"."t_menu" VALUES (250, '三级等保设置', 2, 213, 1, '/support/level3protect/level3-protect-config-index', '/support/level3protect/level3-protect-config-index.vue', 1, NULL, NULL, 'SafetyOutlined', NULL, false, NULL, true, true, false, false, 44, '2024-08-13 11:41:02', 44, '2024-08-13 11:58:12');
INSERT INTO "public"."t_menu" VALUES (251, '敏感数据脱敏', 2, 213, 3, '/support/level3protect/data-masking-list', '/support/level3protect/data-masking-list.vue', 1, NULL, NULL, 'FileProtectOutlined', NULL, false, NULL, true, true, false, false, 44, '2024-08-13 11:58:00', 44, '2024-08-13 11:59:49');
INSERT INTO "public"."t_menu" VALUES (252, '启用/禁用', 3, 110, NULL, NULL, NULL, 1, 'support:dict:updateDisabled', 'support:dict:updateDisabled', NULL, 110, false, NULL, false, true, false, false, 1, '2025-04-08 19:44:12', 1, '2025-04-08 19:46:03');
INSERT INTO "public"."t_menu" VALUES (253, '查询字典数据', 3, 110, NULL, NULL, NULL, 1, 'support:dictData:query', 'support:dictData:query', NULL, 110, false, NULL, false, true, false, false, 1, '2025-04-08 19:46:47', NULL, '2025-04-08 19:46:47');
INSERT INTO "public"."t_menu" VALUES (254, '添加字典数据', 3, 110, NULL, NULL, NULL, 1, 'support:dictData:add', 'support:dictData:add', NULL, 110, false, NULL, false, true, false, false, 1, '2025-04-08 19:48:00', NULL, '2025-04-08 19:48:00');
INSERT INTO "public"."t_menu" VALUES (255, '更新字典数据', 3, 110, NULL, NULL, NULL, 1, 'support:dictData:update', 'support:dictData:update', NULL, 110, false, NULL, false, true, false, false, 1, '2025-04-08 19:48:19', NULL, '2025-04-08 19:48:19');
INSERT INTO "public"."t_menu" VALUES (256, '删除字典数据', 3, 110, NULL, NULL, NULL, 1, 'support:dictData:delete', 'support:dictData:delete', NULL, 110, false, NULL, false, true, false, false, 1, '2025-04-08 19:48:38', NULL, '2025-04-08 19:48:38');
INSERT INTO "public"."t_menu" VALUES (257, '启用/禁用字典数据', 3, 110, NULL, NULL, NULL, 1, 'support:dictData:updateDisabled', 'support:dictData:updateDisabled', NULL, 110, false, NULL, false, true, false, false, 1, '2025-04-08 19:48:57', NULL, '2025-04-08 19:48:57');
INSERT INTO "public"."t_menu" VALUES (258, '查询企业员工', 3, 145, NULL, NULL, NULL, 1, 'oa:enterprise:queryEmployee', 'oa:enterprise:queryEmployee', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:11:46', 75, '2025-04-08 21:12:24');
INSERT INTO "public"."t_menu" VALUES (259, '查询银行信息', 3, 145, NULL, NULL, NULL, 1, 'oa:bank:query', 'oa:bank:query', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:12:40', NULL, '2025-04-08 21:12:40');
INSERT INTO "public"."t_menu" VALUES (260, '查询发票信息', 3, 145, NULL, NULL, NULL, 1, 'oa:invoice:query', 'oa:invoice:query', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:12:56', NULL, '2025-04-08 21:12:56');
INSERT INTO "public"."t_menu" VALUES (261, '添加企业员工', 3, 145, NULL, NULL, NULL, 1, 'oa:enterprise:addEmployee', 'oa:enterprise:addEmployee', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:35:34', NULL, '2025-04-08 21:35:34');
INSERT INTO "public"."t_menu" VALUES (262, '删除企业员工', 3, 145, NULL, NULL, NULL, 1, 'oa:enterprise:deleteEmployee', 'oa:enterprise:deleteEmployee', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:40:17', NULL, '2025-04-08 21:40:17');
INSERT INTO "public"."t_menu" VALUES (263, '添加银行信息', 3, 145, NULL, NULL, NULL, 1, 'oa:bank:add', 'oa:bank:add', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:45:44', NULL, '2025-04-08 21:45:44');
INSERT INTO "public"."t_menu" VALUES (264, '更新银行信息', 3, 145, NULL, NULL, NULL, 1, 'oa:bank:update', 'oa:bank:update', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:46:02', NULL, '2025-04-08 21:46:02');
INSERT INTO "public"."t_menu" VALUES (265, '删除银行信息', 3, 145, NULL, NULL, NULL, 1, 'oa:bank:delete', 'oa:bank:delete', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:46:12', NULL, '2025-04-08 21:46:12');
INSERT INTO "public"."t_menu" VALUES (266, '添加发票信息', 3, 145, NULL, NULL, NULL, 1, 'oa:invoice:add', 'oa:invoice:add', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:46:30', NULL, '2025-04-08 21:46:30');
INSERT INTO "public"."t_menu" VALUES (267, '更新发票信息', 3, 145, NULL, NULL, NULL, 1, 'oa:invoice:update', 'oa:invoice:update', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:46:47', NULL, '2025-04-08 21:46:47');
INSERT INTO "public"."t_menu" VALUES (268, '删除发票信息', 3, 145, NULL, NULL, NULL, 1, 'oa:invoice:delete', 'oa:invoice:delete', NULL, 145, false, NULL, false, true, false, false, 75, '2025-04-08 21:46:59', NULL, '2025-04-08 21:46:59');
INSERT INTO "public"."t_menu" VALUES (300, '消息管理', 2, 50, 30, '/message', '/support/message/message-list.vue', 1, NULL, NULL, 'MailOutlined', NULL, false, NULL, false, true, false, false, 1, '2025-04-09 14:30:04', 1, '2025-04-10 20:19:36');

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_message";
CREATE TABLE "public"."t_message" (
  "message_id" BIGSERIAL,
  "message_type" int2 NOT NULL,
  "receiver_user_type" int4 NOT NULL,
  "receiver_user_id" int8 NOT NULL,
  "data_id" varchar(500) COLLATE "pg_catalog"."default",
  "title" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "read_flag" bool NOT NULL  DEFAULT FALSE,
  "read_time" timestamp(6),
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_message"."message_id" IS '消息id';
COMMENT ON COLUMN "public"."t_message"."message_type" IS '消息类型';
COMMENT ON COLUMN "public"."t_message"."receiver_user_type" IS '接收者用户类型';
COMMENT ON COLUMN "public"."t_message"."receiver_user_id" IS '接收者用户id';
COMMENT ON COLUMN "public"."t_message"."data_id" IS '相关数据id';
COMMENT ON COLUMN "public"."t_message"."title" IS '标题';
COMMENT ON COLUMN "public"."t_message"."content" IS '内容';
COMMENT ON COLUMN "public"."t_message"."read_flag" IS '是否已读';
COMMENT ON COLUMN "public"."t_message"."read_time" IS '已读时间';
COMMENT ON COLUMN "public"."t_message"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_message"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_message" IS '通知消息';

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO "public"."t_message" VALUES (1, 1, 1, 1, 'null', '张三的对公付款单 【3000元】', '尊敬的各位技术大佬：

1024创新实验室技术分享即将隆重举行

现将有关会议事宜通知如下：

一、会议内容

1、研究探讨SmartAdmin的技术体系

二、会议形式

大会专题小会分组讨论;

三、会议时间及地点

会议报到时间：xxx1年6月14日

会议报到地点：洛阳市', false, '2024-09-02 23:00:54', '2024-06-27 01:14:07', '2024-09-03 20:44:19');
INSERT INTO "public"."t_message" VALUES (2, 2, 1, 1, '234', '刘备的请假单【本周四】', '尊敬的各位技术大佬：

1024创新实验室技术分享即将隆重举行

现将有关会议事宜通知如下：

一、会议内容

1、研究探讨SmartAdmin的技术体系

二、会议形式

大会专题小会分组讨论;

三、会议时间及地点

会议报到时间：xxx1年6月14日

会议报到地点：洛阳市', false, '2024-09-02 23:00:50', '2024-07-04 16:09:49', '2024-09-03 20:44:20');
INSERT INTO "public"."t_message" VALUES (3, 1, 1, 1, '23', '武松的物资采购单【Macbook Pro】', '尊敬的各位技术大佬：

1024创新实验室技术分享即将隆重举行

现将有关会议事宜通知如下：

一、会议内容

1、研究探讨SmartAdmin的技术体系

二、会议形式

大会专题小会分组讨论;

三、会议时间及地点

会议报到时间：xxx1年6月14日

会议报到地点：洛阳市', false, '2024-09-02 23:00:36', '2024-07-07 22:03:14', '2024-09-03 20:44:21');
INSERT INTO "public"."t_message" VALUES (4, 1, 1, 1, '23', '孙悟空的出差申请【出差洛阳】', '尊敬的各位技术大佬：

1024创新实验室技术分享即将隆重举行

现将有关会议事宜通知如下：

一、会议内容

1、研究探讨SmartAdmin的技术体系

二、会议形式

大会专题小会分组讨论;

三、会议时间及地点

会议报到时间：xxx1年6月14日

会议报到地点：洛阳市', false, '2024-09-02 23:02:53', '2024-07-07 22:03:14', '2024-09-03 21:43:53');

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_notice";
CREATE TABLE "public"."t_notice" (
  "notice_id" BIGSERIAL,
  "notice_type_id" int8 NOT NULL,
  "title" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "all_visible_flag" bool NOT NULL  DEFAULT FALSE,
  "scheduled_publish_flag" bool NOT NULL  DEFAULT FALSE,
  "publish_time" timestamp(6) NOT NULL,
  "content_text" text COLLATE "pg_catalog"."default" NOT NULL,
  "content_html" text COLLATE "pg_catalog"."default" NOT NULL,
  "attachment" varchar(1000) COLLATE "pg_catalog"."default",
  "page_view_count" int4 NOT NULL,
  "user_view_count" int4 NOT NULL,
  "source" varchar(1000) COLLATE "pg_catalog"."default",
  "author" varchar(1000) COLLATE "pg_catalog"."default",
  "document_number" varchar(1000) COLLATE "pg_catalog"."default",
  "deleted_flag" bool NOT NULL  DEFAULT FALSE,
  "create_user_id" int8,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_notice"."notice_type_id" IS '类型1公告 2动态';
COMMENT ON COLUMN "public"."t_notice"."title" IS '标题';
COMMENT ON COLUMN "public"."t_notice"."all_visible_flag" IS '是否全部可见';
COMMENT ON COLUMN "public"."t_notice"."scheduled_publish_flag" IS '是否定时发布';
COMMENT ON COLUMN "public"."t_notice"."publish_time" IS '发布时间';
COMMENT ON COLUMN "public"."t_notice"."content_text" IS '文本内容';
COMMENT ON COLUMN "public"."t_notice"."content_html" IS 'html内容';
COMMENT ON COLUMN "public"."t_notice"."attachment" IS '附件';
COMMENT ON COLUMN "public"."t_notice"."page_view_count" IS '页面浏览量，传说中的pv';
COMMENT ON COLUMN "public"."t_notice"."user_view_count" IS '用户浏览量，传说中的uv';
COMMENT ON COLUMN "public"."t_notice"."source" IS '来源';
COMMENT ON COLUMN "public"."t_notice"."author" IS '作者';
COMMENT ON COLUMN "public"."t_notice"."document_number" IS '文号，如：1024创新实验室发〔2022〕字第36号';
COMMENT ON COLUMN "public"."t_notice"."create_user_id" IS '创建人';
COMMENT ON TABLE "public"."t_notice" IS '通知';

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO "public"."t_notice" VALUES (49, 1, 'Spring Boot 3.0.0 首个 RC 发布', true, false, '2024-01-01 20:22:23', 'Spring Boot 3.0.0 首个 RC 发布
Spring Boot 3.0 首个 RC 已发布，此外还为两个分支发布了更新：2.7.5 & 2.6.13。
3.0.0-RC1
发布公告写道，此版本包含 135 项功能增强、文档改进、依赖升级和 Bugfix。
Spring Boot 3.0 的开发工作始于实验性的 Spring Native，旨在为 GraalVM 原生镜像提供支持。在该版本中，开发者现在可以使用标准 Spring Boot Maven 或 Gradle 插件将 Spring Boot 应用程序转换为原生可执行文件，而无需任何特殊配置。
此版本还在参考文档中添加新内容来解释 AOT 处理背后的概念以及如何开始生成第一个 GraalVM 原生镜像。
除此之外，Spring Boot 3.0 还完成了迁移到 JakartaEE 9 的工作，以及将使用的 Java 版本升级到 Java 17。
其他新特性：
为 Spring Data JDBC 提供更灵活的自动配置为 Prometheus 示例提供自动配置增强 Log4j2 功能，包括配置文件支持和环境属性查找
详情查看 Release Note。
Spring Boot 2.7.5 和 2.6.13 的更新内容主要是修复错误，优化文档和升级依赖，详情查看 Release Note (2.7.5、2.6.13)。
相关链接
Spring Boot 的详细介绍：点击查看Spring Boot 的下载地址：点击下载', '<h1 style="text-indent: 0px; text-align: start;"><a href="https://www.oschina.net/news/214401/spring-boot-3-0-0-rc1-released" target="_blank">Spring&nbsp;Boot&nbsp;3.0.0&nbsp;首个&nbsp;RC&nbsp;发布</a></h1><p>Spring&nbsp;Boot&nbsp;3.0 首个&nbsp;RC 已发布，此外还为两个分支发布了更新：2.7.5 & 2.6.13。</p><p>3.0.0-RC1</p><p>发布公告写道，此版本包含 135&nbsp;项功能增强、文档改进、依赖升级和&nbsp;Bugfix。</p><p>Spring&nbsp;Boot&nbsp;3.0&nbsp;的开发工作始于实验性的&nbsp;Spring&nbsp;Native，旨在为&nbsp;GraalVM&nbsp;原生镜像提供支持。在该版本中，开发者现在可以使用标准&nbsp;Spring&nbsp;Boot&nbsp;Maven&nbsp;或&nbsp;Gradle&nbsp;插件将&nbsp;Spring&nbsp;Boot&nbsp;应用程序转换为原生可执行文件，而无需任何特殊配置。</p><p>此版本还在参考文档中添加新内容来解释 AOT&nbsp;处理背后的概念以及如何开始生成第一个&nbsp;GraalVM&nbsp;原生镜像。</p><p>除此之外，Spring&nbsp;Boot&nbsp;3.0&nbsp;还完成了迁移到 JakartaEE&nbsp;9&nbsp;的工作，以及将使用的&nbsp;Java&nbsp;版本升级到&nbsp;Java&nbsp;17。</p><p>其他新特性：</p><p>为&nbsp;Spring&nbsp;Data&nbsp;JDBC&nbsp;提供更灵活的自动配置为&nbsp;Prometheus&nbsp;示例提供自动配置增强&nbsp;Log4j2&nbsp;功能，包括配置文件支持和环境属性查找</p><p>详情查看&nbsp;Release&nbsp;Note。</p><p>Spring&nbsp;Boot&nbsp;2.7.5&nbsp;和&nbsp;2.6.13&nbsp;的更新内容主要是修复错误，优化文档和升级依赖，详情查看&nbsp;Release&nbsp;Note&nbsp;(2.7.5、2.6.13)。</p><p>相关链接</p><p>Spring&nbsp;Boot&nbsp;的详细介绍：点击查看Spring&nbsp;Boot&nbsp;的下载地址：点击下载</p>', '', 0, 0, '开源中国', '卓大', NULL, false, 1, '2024-03-02 18:53:26', '2022-10-22 14:27:33');
INSERT INTO "public"."t_notice" VALUES (50, 1, 'Oracle 推出 JDK 8 的直接替代品', true, false, '2024-01-01 20:22:23', 'Oracle 推出 JDK 8 的直接替代品
来源: OSCHINA
编辑: 白开水不加糖
2022-10-20 08:14:29
 0
为了向传统的 Java 8 服务器工作负载提供 Java 17 级别的性能，Oracle 宣布推出 Java SE Subscription Enterprise Performance Pack (Enterprise Performance Pack)。并声称这是 JDK 8 的直接替代品，现已在 MyOracleSupport 上面向所有 Java SE 订阅客户和 Oracle 云基础设施 (OCI) 用户免费提供。
“Enterprise Performance Pack 为 JDK 8 用户提供了在 JDK 8 和 JDK 17 发布之间的 7 年时间里，为 Java 带来的重大内存管理和性能改进。这些改进包括：现代垃圾回收算法、紧凑字符串、增强的可观察性和数十种其他优化。”
Java 8 发布于 2014 年，和 Java 17 一样都是长期支持 (LTS) 版本；尽管发布距今已有近九年的历史，但仍被很多开发人员和组织所广泛应用。New Relic 发布的一份 “2022 年 Java 生态系统状况报告” 数据表明，Java 8 仍被 46.45% 的 Java 应用程序在生产中使用。
根据介绍，Enterprise Performance Pack 在 Intel 和基于 Arm 的系统（如 Ampere Altra）上支持 headless Linux 64 位工作负载。
Oracle 方面称，使用 Enterprise Performance Pack 的客户将可以立即看到以或接近内存或 CPU 容量运行的 JDK 8 工作负载的好处。在 Oracle 自己的产品和云服务进行的测试表明，高负载应用程序的内存和性能都提高了大约 40%。即使没有接近容量运行的 JDK 8 应用程序，也可以会看到高达 5% 的性能提升。
虽然 Enterprise Performance Pack 中包含的许多改进可以通过默认选项获得，但 Oracle 建议用户还是自己研究文档，以最大限度地提高性能并最大限度地降低内存使用率。例如，通过启用可扩展的低延迟 ZGC 垃圾收集器来提高应用程序响应能力，需要通过 -XX:+UseZGC 选项。', '<h3>Oracle&nbsp;推出&nbsp;JDK&nbsp;8&nbsp;的直接替代品</h3><p>来源:&nbsp;OSCHINA</p><p>编辑: 白开水不加糖</p><p>2022-10-20&nbsp;08:14:29</p><p> 0</p><p>为了向传统的&nbsp;Java&nbsp;8&nbsp;服务器工作负载提供&nbsp;Java&nbsp;17&nbsp;级别的性能，Oracle 宣布推出&nbsp;Java&nbsp;SE&nbsp;Subscription&nbsp;Enterprise&nbsp;Performance&nbsp;Pack&nbsp;(Enterprise&nbsp;Performance&nbsp;Pack)。并声称这是 JDK&nbsp;8&nbsp;的直接替代品，现已在 MyOracleSupport 上面向所有&nbsp;Java&nbsp;SE&nbsp;订阅客户和&nbsp;Oracle&nbsp;云基础设施&nbsp;(OCI)&nbsp;用户免费提供。</p><p>“Enterprise&nbsp;Performance&nbsp;Pack&nbsp;为&nbsp;JDK&nbsp;8&nbsp;用户提供了在&nbsp;JDK&nbsp;8&nbsp;和&nbsp;JDK&nbsp;17&nbsp;发布之间的&nbsp;7&nbsp;年时间里，为&nbsp;Java&nbsp;带来的重大内存管理和性能改进。这些改进包括：现代垃圾回收算法、紧凑字符串、增强的可观察性和数十种其他优化。”</p><p>Java&nbsp;8&nbsp;发布于&nbsp;2014&nbsp;年，和&nbsp;Java&nbsp;17&nbsp;一样都是长期支持&nbsp;(LTS)&nbsp;版本；尽管发布距今已有近九年的历史，但仍被很多开发人员和组织所广泛应用。New&nbsp;Relic&nbsp;发布的一份 “2022&nbsp;年&nbsp;Java&nbsp;生态系统状况报告”&nbsp;数据表明，Java&nbsp;8&nbsp;仍被&nbsp;46.45%&nbsp;的&nbsp;Java&nbsp;应用程序在生产中使用。</p><p>根据介绍，Enterprise&nbsp;Performance&nbsp;Pack&nbsp;在&nbsp;Intel&nbsp;和基于&nbsp;Arm&nbsp;的系统（如&nbsp;Ampere&nbsp;Altra）上支持 headless&nbsp;Linux&nbsp;64&nbsp;位工作负载。</p><p>Oracle 方面称，使用&nbsp;Enterprise&nbsp;Performance&nbsp;Pack&nbsp;的客户将可以立即看到以或接近内存或&nbsp;CPU&nbsp;容量运行的&nbsp;JDK&nbsp;8&nbsp;工作负载的好处。在&nbsp;Oracle&nbsp;自己的产品和云服务进行的测试表明，高负载应用程序的内存和性能都提高了大约&nbsp;40%。即使没有接近容量运行的&nbsp;JDK&nbsp;8&nbsp;应用程序，也可以会看到高达&nbsp;5%&nbsp;的性能提升。</p><p>虽然&nbsp;Enterprise&nbsp;Performance&nbsp;Pack&nbsp;中包含的许多改进可以通过默认选项获得，但 Oracle 建议用户还是自己研究文档，以最大限度地提高性能并最大限度地降低内存使用率。例如，通过启用可扩展的低延迟&nbsp;ZGC&nbsp;垃圾收集器来提高应用程序响应能力，需要通过&nbsp;-XX:+UseZGC&nbsp;选项。</p>', '', 0, 0, 'OSChina', '卓大', NULL, false, 1, '2024-01-08 19:02:12', '2022-10-22 14:29:56');
INSERT INTO "public"."t_notice" VALUES (51, 1, 'Spring Framework 6.0.0 RC2 发布', true, false, '2024-01-01 20:22:23', 'Spring Framework 6.0.0 RC2 发布
Spring Framework 6.0.0 发布了第二个 RC 版本。
新特性
确保可以在构建时评估 classpath 检查 #29352为 JPA 持久化回调引入 Register 反射提示 #29348检查 @RegisterReflectionForBinding 是否至少指定一个类 #29346为 AOT 引擎设置引入 builder API #29341支持检测正在进行的 AOT 处理 #29340重新组织 HTTP Observation 类型 #29334支持在没有 java.beans.Introspector 的前提下，执行基本属性判断 #29320为BindingReflectionHintsRegistrar 添加 Kotlin 数据类组件支持 #29316将 HttpServiceFactory 和 RSocketServiceProxyFactory 切换到 builder 模型，以便优先进行可编程配置 #29296引入基于 GraalVM FieldValueTransformer API 的 PreComputeFieldFeature#29081在 TestContext 框架中引入 SPI 来处理 ApplicationContext 故障 #28826SimpleEvaluationContext 支持禁用 array 分配 #28808DateTimeFormatterRegistrar 支持默认回退到 ISO 解析 #26985
Spring Framework 6.0 作为重大更新，要求使用 Java 17 或更高版本，并且已迁移到 Jakarta EE 9+（在 jakarta 命名空间中取代了以前基于 javax 的 EE API），以及对其他基础设施的修改。基于这些变化，Spring Framework 6.0 支持最新 Web 容器，如 Tomcat 10 / Jetty 11，以及最新的持久性框架 Hibernate ORM 6.1。这些特性仅可用于 Servlet API 和 JPA 的 jakarta 命名空间变体。
值得一提的是，开发者可通过此版本在基于 Spring 的应用中体验 “虚拟线程”（JDK 19 中的预览版 “Project Loom”），查看此文章了解更多细节。现在提供了自定义选项来插入基于虚拟线程的 Executor 实现，目标是在 Project Loom 正式可用时提供 “一等公民” 的配置选项。
除了上述的变化，Spring Framework 6.0 还包含许多其他改进和特性，例如：
提供基于 @HttpExchange 服务接口的 HTTP 接口客户端对 RFC 7807 问题详细信息的支持Spring HTTP 客户端提供基于 Micrometer 的可观察性……
详情查看 Release Note。
按照发布计划，Spring Framework 6.0 将于 11 月正式 GA。', '<h1 style="text-indent: 0px; text-align: start;"><a href="https://www.oschina.net/news/214472/spring-framework-6-0-0-rc2-released" target="_blank">Spring&nbsp;Framework&nbsp;6.0.0&nbsp;RC2&nbsp;发布</a></h1><p style="text-indent: 0px; text-align: left;">Spring&nbsp;Framework&nbsp;6.0.0&nbsp;发布了<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fspring.io%2Fblog%2F2022%2F10%2F20%2Fspring-framework-6-0-0-rc2-available-now" target="_blank">第二个&nbsp;RC&nbsp;版本</a>。</p><p style="text-indent: 0px; text-align: left;"><strong>新特性</strong></p><ul style="text-indent: 0px; text-align: left;"><li>确保可以在构建时评估&nbsp;classpath&nbsp;检查&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F29352" target="_blank">#29352</a></li><li>为&nbsp;JPA&nbsp;持久化回调引入&nbsp;Register&nbsp;反射提示&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F29348" target="_blank">#29348</a></li><li>检查&nbsp;<span style="color: rgb(51, 51, 51); font-size: 13px;"><code>@RegisterReflectionForBinding</code></span>&nbsp;是否至少指定一个类&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F29346" target="_blank">#29346</a></li><li>为&nbsp;AOT&nbsp;引擎设置引入&nbsp;builder&nbsp;API&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F29341" target="_blank">#29341</a></li><li>支持检测正在进行的&nbsp;AOT&nbsp;处理&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F29340" target="_blank">#29340</a></li><li>重新组织&nbsp;HTTP&nbsp;Observation&nbsp;类型&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F29334" target="_blank">#29334</a></li><li>支持在没有&nbsp;java.beans.Introspector&nbsp;的前提下，执行基本属性判断&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F29320" target="_blank">#29320</a></li><li>为<span style="color: rgb(51, 51, 51); font-size: 13px;"><code>BindingReflectionHintsRegistrar</code></span>&nbsp;添加&nbsp;Kotlin&nbsp;数据类组件支持&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F29316" target="_blank">#29316</a></li><li>将&nbsp;HttpServiceFactory&nbsp;和&nbsp;RSocketServiceProxyFactory&nbsp;切换到&nbsp;builder&nbsp;模型，以便优先进行可编程配置&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F29296" target="_blank">#29296</a></li><li>引入基于&nbsp;GraalVM&nbsp;<span style="color: rgb(51, 51, 51); font-size: 13px;"><code>FieldValueTransformer</code></span>&nbsp;API&nbsp;的&nbsp;<span style="color: rgb(51, 51, 51); font-size: 13px;"><code>PreComputeFieldFeature</code></span><a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F29081" target="_blank">#29081</a></li><li>在&nbsp;TestContext&nbsp;框架中引入&nbsp;SPI&nbsp;来处理&nbsp;ApplicationContext&nbsp;故障&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F28826" target="_blank">#28826</a></li><li>SimpleEvaluationContext&nbsp;支持禁用&nbsp;array&nbsp;分配&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F28808" target="_blank">#28808</a></li><li>DateTimeFormatterRegistrar&nbsp;支持默认回退到&nbsp;ISO&nbsp;解析&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Fissues%2F26985" target="_blank">#26985</a></li></ul><p style="text-indent: 0px; text-align: left;"><span style="color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);">Spring&nbsp;Framework&nbsp;6.0&nbsp;作为重大更新，要求</span><span style="color: rgb(51, 51, 51);"><strong>使用&nbsp;Java&nbsp;17&nbsp;或更高版本</strong></span><span style="color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);">，并且已迁移到&nbsp;Jakarta&nbsp;EE&nbsp;9+（在&nbsp;</span><span style="color: rgb(51, 51, 51); font-size: 13px;"><code>jakarta</code></span><span style="color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);">&nbsp;命名空间中取代了以前基于&nbsp;</span><span style="color: rgb(51, 51, 51); font-size: 13px;"><code>javax</code></span><span style="color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);">&nbsp;的&nbsp;EE&nbsp;API），以及对其他基础设施的修改。基于这些变化，Spring&nbsp;Framework&nbsp;6.0&nbsp;支持最新&nbsp;Web&nbsp;容器，如&nbsp;</span><a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Ftomcat.apache.org%2Fwhichversion.html" target="_blank">Tomcat&nbsp;10</a><span style="color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);">&nbsp;/&nbsp;</span><a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fwww.eclipse.org%2Fjetty%2Fdownload.php" target="_blank">Jetty&nbsp;11</a><span style="color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);">，以及最新的持久性框架&nbsp;</span><a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fhibernate.org%2Form%2Freleases%2F6.1%2F" target="_blank">Hibernate&nbsp;ORM&nbsp;6.1</a><span style="color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);">。这些特性仅可用于&nbsp;Servlet&nbsp;API&nbsp;和&nbsp;JPA&nbsp;的&nbsp;jakarta&nbsp;命名空间变体。</span></p><p style="text-indent: 0px; text-align: left;">值得一提的是，开发者可通过此版本在基于&nbsp;Spring&nbsp;的应用中体验&nbsp;“虚拟线程”（JDK&nbsp;19&nbsp;中的预览版&nbsp;“Project&nbsp;Loom”），<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fspring.io%2Fblog%2F2022%2F10%2F11%2Fembracing-virtual-threads" target="_blank">查看此文章</a>了解更多细节。现在提供了自定义选项来插入基于虚拟线程的&nbsp;<span style="color: rgb(51, 51, 51); font-size: 13px;"><code>Executor</code></span>&nbsp;实现，目标是在&nbsp;Project&nbsp;Loom&nbsp;正式可用时提供&nbsp;“一等公民”&nbsp;的配置选项。</p><p style="text-indent: 0px; text-align: left;">除了上述的变化，Spring&nbsp;Framework&nbsp;6.0&nbsp;还包含许多其他改进和特性，例如：</p><ul style="text-indent: 0px; text-align: left;"><li>提供基于&nbsp;<span style="color: rgb(51, 51, 51); font-size: 13px;"><code>@HttpExchange</code></span>&nbsp;服务接口的&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fdocs.spring.io%2Fspring-framework%2Fdocs%2F6.0.0-RC1%2Freference%2Fhtml%2Fintegration.html%23rest-http-interface" target="_blank">HTTP&nbsp;接口客户端</a></li><li>对&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fdocs.spring.io%2Fspring-framework%2Fdocs%2F6.0.0-RC1%2Freference%2Fhtml%2Fweb.html%23mvc-ann-rest-exceptions" target="_blank">RFC&nbsp;7807&nbsp;问题详细信息</a>的支持</li><li>Spring&nbsp;HTTP&nbsp;客户端提供基于&nbsp;Micrometer&nbsp;的可观察性</li><li>……</li></ul><p style="text-indent: 0px; text-align: left;"><a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fspring-projects%2Fspring-framework%2Freleases%2Ftag%2Fv6.0.0-RC2" target="_blank">详情查看&nbsp;Release&nbsp;Note</a>。</p><p style="text-indent: 0px; text-align: left;">按照发布计划，Spring&nbsp;Framework&nbsp;6.0&nbsp;将于&nbsp;11&nbsp;月正式&nbsp;GA。</p>', '', 0, 0, 'CSDN', '罗伊', NULL, false, 1, '2024-01-08 19:02:12', '2022-10-22 14:30:45');
INSERT INTO "public"."t_notice" VALUES (52, 1, 'Windows Terminal 正式成为 Windows 11 默认终端', true, false, '2024-01-01 20:22:23', '今年 7 月 ，微软在 Windows 11 的 Beta 版本测试了将系统默认终端设置为 Windows Terminal 。如今该设置已登录稳定版本，从 Windows 11 22H2 版本开始，Windows Terminal 将正式成为 Windows 11 的默认设置。
默认终端是在打开命令行应用程序时默认启动的终端模拟器。从 Windows 诞生之日起，其默认终端一直是 Windows 控制台主机 conhost.exe。此次更新则意味着，以后 Windows 11 的所有命令行应用程序都将在 Windows Terminal 中自动打开。
Windows Terminal 拥有非常多现代化的功能，毕竟它很新（ 2019 年 5 月在 Microsoft Build 上首次发布），吸取了很多现代终端的灵感。它支持多选项卡和窗格、命令面板等现代化的 UI 和操作方式，以及大量的自定义选项，比如目录、配置文件图标、自定义背景图像、配色方案、字体和透明度。
当然，如果不想用 Windows Terminal，用户也可以在 Windows 设置中的 隐私和安全 > 开发人员页面和 Windows 终端设置 中调整默认终端设置，（此更新使用 “让 Windows 决定” 作为默认选择，即默认采用 Windows Terminal） 。
此外，如果在更新之前就已设置其他默认终端，此次更新不会覆盖你的偏好。
关于 Windows 11 默认终端的更多详情可查看微软博客。', '<p style="text-indent: 0px; text-align: left;">今年&nbsp;7&nbsp;月&nbsp;，微软在&nbsp;Windows&nbsp;11&nbsp;的&nbsp;Beta&nbsp;版本<a href="https://www.oschina.net/news/204429/wt-default-terminal-in-win11-beta-channel" target="">测试</a>了将系统默认终端设置为&nbsp;Windows&nbsp;Terminal&nbsp;。如今该设置已登录稳定版本，从&nbsp;Windows&nbsp;11&nbsp;22H2&nbsp;版本开始，Windows&nbsp;Terminal&nbsp;将<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fdevblogs.microsoft.com%2Fcommandline%2Fwindows-terminal-is-now-the-default-in-windows-11%2F" target="_blank">正式成为</a>&nbsp;Windows&nbsp;11&nbsp;的默认设置。</p><p style="text-indent: 0px; text-align: left;">默认终端是在打开命令行应用程序时默认启动的终端模拟器。从&nbsp;Windows&nbsp;诞生之日起，其默认终端一直是&nbsp;Windows&nbsp;控制台主机&nbsp;conhost.exe。此次更新则意味着，以后&nbsp;Windows&nbsp;11&nbsp;的所有命令行应用程序都将在&nbsp;Windows&nbsp;Terminal&nbsp;中自动打开。</p><p style="text-indent: 0px; text-align: left;">Windows&nbsp;Terminal&nbsp;拥有非常多现代化的功能，毕竟它<span style="color: rgb(51, 51, 51); background-color: rgb(255, 255, 255);">很新（&nbsp;2019&nbsp;年&nbsp;5&nbsp;月在&nbsp;Microsoft&nbsp;Build&nbsp;上首次发布），吸取了很多现代终端的灵感。它支持多</span>选项卡和窗格、命令面板等现代化的&nbsp;UI&nbsp;和操作方式，以及大量的自定义选项，比如目录、配置文件图标、自定义背景图像、配色方案、字体和透明度。</p><p style="text-indent: 0px; text-align: left;">当然，如果不想用&nbsp;Windows&nbsp;Terminal，用户也可以在&nbsp;Windows&nbsp;设置中的&nbsp;<em>隐私和安全&nbsp;&gt;&nbsp;开发人员页面和&nbsp;Windows&nbsp;终端设置&nbsp;</em>中调整默认终端设置，（此更新使用&nbsp;“让&nbsp;Windows&nbsp;决定”&nbsp;作为默认选择，即默认采用&nbsp;Windows&nbsp;Terminal）&nbsp;。</p><p style="text-indent: 0px; text-align: left;">此外，如果在更新之前就已设置其他默认终端，此次更新<strong>不会覆盖</strong>你的偏好。</p><p style="text-indent: 0px; text-align: left;">关于&nbsp;Windows&nbsp;11&nbsp;默认终端的更多详情可查看<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fdevblogs.microsoft.com%2Fcommandline%2Fwindows-terminal-is-now-the-default-in-windows-11%2F" target="_blank">微软博客</a>。</p>', '', 0, 0, '开源中国', '善逸', NULL, false, 1, '2024-01-08 19:02:12', '2022-10-22 14:33:03');
INSERT INTO "public"."t_notice" VALUES (53, 1, 'TypeScript 诞生 10 周年', true, false, '2024-01-01 20:22:23', 'TypeScript 已经诞生 10 年了。10 年前 ——2012 年 10 月 1 日，TypeScript 首次公开亮相。当时主导 TypeScript 开发的 Anders Hejlsberg 这样描述 TypeScript：
它是 JavaScript 的类型化超集，可被编译成常用的 JavaScript。TypeScript 还可以通过启用丰富的工具体验来极大地帮助提升生产力，与此同时开发者保持不变维护现有的代码，并继续使用喜爱的 JavaScript 库。TypeScript is a typed superset of JavaScript that compiles to idiomatic (normal) JavaScript, can dramatically improve your productivity by enabling rich tooling experiences, all while maintaining your existing code and continuing to use the same JavaScript libraries you already love.
微软在博客中回顾了 TypeScript 刚亮相时受到的评价，大多数人对它都是持怀疑态度，毕竟这对于许多 JavaScript 开发者来说，试图将静态类型引入 JavaScript 是一个笑话 —— 或是邪恶的阴谋。反对者则直言这是十分愚蠢的想法，他们认为当时已存在可以编译为 JavaScript 的强类型语言，例如 C#、Java 和 C++。他们还吐槽主导 TypeScript 开发的 Anders Hejlsberg 对静态类型有 “迷之执着”。
当时微软意识到 JavaScript 未来将会被应用到无数场景，而且他们公司内部团队在处理复杂的 JavaScript 代码库时面临着巨大的挑战，所以他们觉得有必要创造强大的工具来帮助编写 JavaScript—— 尤其是针对大型 JavaScript 项目。基于此需求，TypeScript 也确定了自己的定位和特性，它是 JavaScript 的超集，将类型检查和静态分析、显式接口和最佳实践结合到单一语言和编译器中。通过在 JavaScript 上构建，TypeScript 能够更接近目标运行时，同时仅添加支持大型应用程序和大型团队所需的语法糖。
团队还坚持 TypeScript 要能够与现有的 JavaScript 无缝交互，与 JavaScript 共同进化，并且看上去也和 JavaScript 类似。
TypeScript 诞生之初的部分设计目标：
不会对已有的程序增加运行时开销与当前和未来的 ECMAScript 提案保持一致保留所有 JavaScript 代码的运行时行为避免添加表达式类型的语法 (expression-level syntax)使用一致、完全可擦除的结构化类型系统……
这些目标指导着 TypeScript 的发展方向：关注类型系统，成为 JavaScript 的类型检查器，只添加类型检查所需的语法，避免添加新的运行时语法和行为。
微软提到，TypeScript 拥有如今的繁荣生态离不开一个重要属性：开源。TypeScript 一开始就是免费且开源 —— 语言规范和编译器都是开源项目，并且以真正开放的方式来运作。事实上，微软当时对外展现出的姿态并不是现在的 “拥抱开源”，所以他们内部并没真正认识到 TypeScript 的开源是如何帮助它走向成功。因此有人认为，TypeScript 在很大程度上引导微软开始更多地转向开源。
现在，TypeScript 仍在积极发展和迭代改进，并被全球数百万开发者使用。在诸多编程语言排名、指数或开发者调查中，TypeScript 一直位居前列，也是最受欢迎和最常用的编程语言。', '<p style="text-indent: 0px; text-align: start;">TypeScript&nbsp;已经诞生&nbsp;10&nbsp;年了。10&nbsp;年前&nbsp;——2012&nbsp;年&nbsp;10&nbsp;月&nbsp;1&nbsp;日，TypeScript&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fweb.archive.org%2Fweb%2F20121003001910%2Fhttps%3A%2F%2Fblogs.msdn.com%2Fb%2Fsomasegar%2Farchive%2F2012%2F10%2F01%2Ftypescript-javascript-development-at-application-scale.aspx" target="_blank"><strong>首次公开亮相</strong></a>。当时主导&nbsp;TypeScript&nbsp;开发的&nbsp;Anders&nbsp;Hejlsberg&nbsp;这样描述&nbsp;TypeScript：</p><blockquote style="text-indent: 0px; text-align: left;">它是&nbsp;JavaScript&nbsp;的类型化超集，可被编译成常用的&nbsp;JavaScript。TypeScript&nbsp;还可以通过启用丰富的工具体验来极大地帮助提升生产力，与此同时开发者保持不变维护现有的代码，并继续使用喜爱的&nbsp;JavaScript&nbsp;库。TypeScript&nbsp;is&nbsp;a&nbsp;typed&nbsp;superset&nbsp;of&nbsp;JavaScript&nbsp;that&nbsp;compiles&nbsp;to&nbsp;idiomatic&nbsp;(normal)&nbsp;JavaScript,&nbsp;can&nbsp;dramatically&nbsp;improve&nbsp;your&nbsp;productivity&nbsp;by&nbsp;enabling&nbsp;rich&nbsp;tooling&nbsp;experiences,&nbsp;all&nbsp;while&nbsp;maintaining&nbsp;your&nbsp;existing&nbsp;code&nbsp;and&nbsp;continuing&nbsp;to&nbsp;use&nbsp;the&nbsp;same&nbsp;JavaScript&nbsp;libraries&nbsp;you&nbsp;already&nbsp;love.</blockquote><p style="text-indent: 0px; text-align: left;">微软在博客中回顾了&nbsp;TypeScript&nbsp;刚亮相时受到的评价，大多数人对它都是持怀疑态度，毕竟这对于许多&nbsp;JavaScript&nbsp;开发者来说，试图将静态类型引入&nbsp;JavaScript&nbsp;是一个笑话&nbsp;——&nbsp;或是邪恶的阴谋。反对者则直言这是十分愚蠢的想法，他们认为当时已存在可以编译为&nbsp;JavaScript&nbsp;的强类型语言，例如&nbsp;C#、Java&nbsp;和&nbsp;C++。他们还吐槽主导&nbsp;TypeScript&nbsp;开发的&nbsp;Anders&nbsp;Hejlsberg&nbsp;对静态类型有&nbsp;“迷之执着”。</p><p style="text-indent: 0px; text-align: start;">当时微软意识到&nbsp;JavaScript&nbsp;未来将会被应用到无数场景，而且他们公司内部团队在处理复杂的&nbsp;JavaScript&nbsp;代码库时面临着巨大的挑战，所以他们觉得有必要创造强大的工具来帮助编写&nbsp;JavaScript——&nbsp;尤其是针对大型&nbsp;JavaScript&nbsp;项目。基于此需求，TypeScript&nbsp;也确定了自己的定位和特性，它是&nbsp;JavaScript&nbsp;的超集，将类型检查和静态分析、显式接口和最佳实践结合到单一语言和编译器中。通过在&nbsp;JavaScript&nbsp;上构建，TypeScript&nbsp;能够更接近目标运行时，同时仅添加支持大型应用程序和大型团队所需的语法糖。</p><p style="text-indent: 0px; text-align: start;">团队还坚持&nbsp;TypeScript&nbsp;要能够与现有的&nbsp;JavaScript&nbsp;无缝交互，与&nbsp;JavaScript&nbsp;共同进化，并且看上去也和&nbsp;JavaScript&nbsp;类似。</p><p style="text-indent: 0px; text-align: start;">TypeScript&nbsp;诞生之初的部分<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Fmicrosoft%2FTypeScript%2Fwiki%2FTypeScript-Design-Goals%2F53ffa9b1802cd8e18dfe4b2cd4e9ef5d4182df10" target="_blank"><strong>设计目标</strong></a>：</p><ul style="text-indent: 0px; text-align: left;"><li>不会对已有的程序增加运行时开销</li><li>与当前和未来的&nbsp;ECMAScript&nbsp;提案保持一致</li><li>保留所有&nbsp;JavaScript&nbsp;代码的运行时行为</li><li>避免添加表达式类型的语法&nbsp;(expression-level&nbsp;syntax)</li><li>使用一致、完全可擦除的结构化类型系统</li><li>……</li></ul><p style="text-indent: 0px; text-align: start;">这些目标指导着&nbsp;TypeScript&nbsp;的发展方向：关注类型系统，成为&nbsp;JavaScript&nbsp;的类型检查器，只添加类型检查所需的语法，避免添加新的运行时语法和行为。</p><p style="text-indent: 0px; text-align: start;">微软提到，TypeScript&nbsp;拥有如今的繁荣生态离不开一个重要属性：<strong>开源</strong>。TypeScript&nbsp;一开始就是免费且开源&nbsp;——<span style="color: rgb(51, 51, 51);">&nbsp;语言规范和编译器都是开源项目，</span>并且以真正开放的方式来运作。事实上，微软当时对外展现出的姿态并不是现在的&nbsp;“拥抱开源”，所以他们内部并没真正认识到&nbsp;TypeScript&nbsp;的开源是如何帮助它走向成功。因此有人认为，TypeScript&nbsp;在很大程度上引导微软开始更多地转向开源。</p><p style="text-indent: 0px; text-align: start;">现在，TypeScript&nbsp;仍在积极发展和迭代改进，并被全球数百万开发者使用。在诸多编程语言排名、指数或开发者调查中，TypeScript&nbsp;一直位居前列，也是最受欢迎和最常用的编程语言。</p>', '', 0, 0, '开源中国', '开云', NULL, false, 1, '2024-01-08 19:02:12', '2022-10-22 14:34:56');
INSERT INTO "public"."t_notice" VALUES (54, 1, 'JetBrains Fleet 公测，下一代 IDE', true, false, '2024-01-01 20:22:23', 'JetBrains 宣布首次公共预览 Fleet，所有人都可以使用。Fleet 是由 JetBrains 打造的下一代 IDE，于 2021 年首次正式推出。它是一个新的分布式多语言编辑器和 IDE，基于 JetBrains 在后端的 IntelliJ 平台，采用了全新的用户界面和分布式架构从头开始构建。
下载 Fleet：https://www.jetbrains.com.cn/fleet/download/

公告表示，自从最初宣布 Fleet 以来，有超过 137,000 人报名参加私人预览；官方最初之所以决定从封闭式预览开始，是为了能够以渐进的方式处理反馈。现如今，JetBrains Fleet 仍处于起步阶段，还有大量的工作要做。其向公众开放预览的原因有两个方面：“首先，我们认为让所有注册者再等下去是不对的，但单独邀请这么多人对我们来说也缺乏意义。面向公众开放预览对我们来说更容易。第二，也是最重要的，我们一直是一家以开放态度打造产品的公司。我们不希望 Fleet 在这方面有任何不同。”
JetBrains 方面提供了一个图表，以显示 Fleet 目前提供支持的语言和技术，以及每个技术的状态。但值得注意的是，Fleet 仍处于早期阶段，有些事情可能无法按预期工作；所以即使有些东西被列为受支持的，也有可能存在问题。
同时 JetBrains 也强调称，他们并不打算取代其现有的 IDE。
因此，请不要期望在 Fleet 中看到与我们的 IDE（如 IntelliJ IDEA）完全相同的功能。尽管我们会继续开发 Fleet，我们 IDE 的所有功能也不会出现在其中。Fleet 是我们为开发者提供不同用户体验的一个机会。话虽如此，我们确实希望听到你认为 Fleet 还缺少什么功能的反馈，例如特定的重构选项、工具集成等。我们现有的 IDE 将继续发展。我们对其有很多计划，包括性能改进、新的用户界面、远程开发等等。最后，Fleet 还在底层采用了我们现有工具的智慧，所以这些工具都不会消失。
JetBrains 透露，在未来几个月他们将致力于稳定 Fleet，并尽可能地解决得到的反馈。同时，将在以下领域开展工作：
为插件作者提供 API 支持和 SDK–鉴于 Fleet 有一个分布式架构，我们需要努力为插件作者简化工作。 虽然我们保证会为扩展 Fleet 提供一个平台，但也请求大家在这方面多一点耐心。 性能 – 我们希望 Fleet 不仅在内存占用方面，而且在响应时间方面都能表现出色。 有很多地方我们仍然可以提高性能，我们将在这些方面努力。 主题和键盘地图 – 我们知道许多开发者已经习惯了他们现有的编辑器和 IDE，当他们转移到新的 IDE 时，往往会想念他们以前的键盘绑定和主题。 我们将致力于增加对更多主题和键盘映射的支持。 我们当然也会致力于 Vim 的模拟。
更多详情可查看官方博客。', '<p style="text-indent: 0px; text-align: left;">JetBrains&nbsp;<a href="https://my.oschina.net/u/5494143/blog/5584325" target="">宣布</a>首次公共预览&nbsp;<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fwww.jetbrains.com.cn%2Ffleet%2F" target="_blank">Fleet</a>，所有人都可以使用。Fleet&nbsp;是由&nbsp;JetBrains&nbsp;打造的下一代&nbsp;IDE，于&nbsp;2021&nbsp;年首次正式<a href="https://my.oschina.net/u/5494143/blog/5332934" target="">推出</a>。它是一个新的分布式多语言编辑器和&nbsp;IDE，基于&nbsp;JetBrains&nbsp;在后端的&nbsp;IntelliJ&nbsp;平台，采用了全新的用户界面和分布式架构从头开始构建。</p><p style="text-indent: 0px; text-align: left;"><strong>下载&nbsp;Fleet：</strong><a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fwww.jetbrains.com.cn%2Ffleet%2Fdownload%2F" target="_blank">https://www.jetbrains.com.cn/fleet/download/</a></p><p style="text-indent: 0px; text-align: left;"><br></p><p style="text-indent: 0px; text-align: left;">公告表示，自从最初宣布&nbsp;Fleet&nbsp;以来，有超过&nbsp;137,000&nbsp;人报名参加私人预览；官方最初之所以决定从封闭式预览开始，是为了能够以渐进的方式处理反馈。现如今，JetBrains&nbsp;Fleet&nbsp;仍处于起步阶段，还有大量的工作要做。其向公众开放预览的原因有两个方面：“首先，我们认为让所有注册者再等下去是不对的，但单独邀请这么多人对我们来说也缺乏意义。面向公众开放预览对我们来说更容易。第二，也是最重要的，我们一直是一家以开放态度打造产品的公司。我们不希望&nbsp;Fleet&nbsp;在这方面有任何不同。”</p><p style="text-indent: 0px; text-align: left;">JetBrains&nbsp;方面提供了一个<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fjb.gg%2Ffleet-feature-matrix" target="_blank">图表</a>，以显示&nbsp;Fleet&nbsp;目前提供支持的语言和技术，以及每个技术的状态。但值得注意的是，Fleet&nbsp;仍处于早期阶段，有些事情可能无法按预期工作；所以即使有些东西被列为受支持的，也有可能存在问题。</p><p style="text-indent: 0px; text-align: left;">同时&nbsp;JetBrains&nbsp;也强调称，他们并不打算取代其现有的&nbsp;IDE。</p><blockquote style="text-indent: 0px; text-align: left;">因此，请不要期望在&nbsp;Fleet&nbsp;中看到与我们的&nbsp;IDE（如&nbsp;IntelliJ&nbsp;IDEA）完全相同的功能。尽管我们会继续开发&nbsp;Fleet，我们&nbsp;IDE&nbsp;的所有功能也不会出现在其中。Fleet&nbsp;是我们为开发者提供不同用户体验的一个机会。话虽如此，我们确实希望听到你认为&nbsp;Fleet&nbsp;还缺少什么功能的反馈，例如特定的重构选项、工具集成等。我们现有的&nbsp;IDE&nbsp;将继续发展。我们对其有很多计划，包括性能改进、新的用户界面、远程开发等等。最后，Fleet&nbsp;还在底层采用了我们现有工具的智慧，所以这些工具都不会消失。</blockquote><p style="text-indent: 0px; text-align: start;">JetBrains&nbsp;透露，在未来几个月他们将致力于稳定&nbsp;Fleet，并尽可能地解决得到的反馈。同时，将在以下领域开展工作：</p><ul style="text-indent: 0px; text-align: left;"><li><strong>为插件作者提供&nbsp;API&nbsp;支持和&nbsp;SDK</strong>–鉴于&nbsp;Fleet&nbsp;有一个<a href="https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fblog.jetbrains.com%2Fzh-hans%2Ffleet%2F2022%2F01%2Ffleet-below-deck-part-i-architecture-overview%2F" target="_blank">分布式架构</a>，我们需要努力为插件作者简化工作。&nbsp;虽然我们保证会为扩展&nbsp;Fleet&nbsp;提供一个平台，但也请求大家在这方面多一点耐心。&nbsp;</li><li><strong>性能</strong>&nbsp;–&nbsp;我们希望&nbsp;Fleet&nbsp;不仅在内存占用方面，而且在响应时间方面都能表现出色。&nbsp;有很多地方我们仍然可以提高性能，我们将在这些方面努力。&nbsp;</li><li><strong>主题和键盘地图</strong>&nbsp;–&nbsp;我们知道许多开发者已经习惯了他们现有的编辑器和&nbsp;IDE，当他们转移到新的&nbsp;IDE&nbsp;时，往往会想念他们以前的键盘绑定和主题。&nbsp;我们将致力于增加对更多主题和键盘映射的支持。&nbsp;我们当然也会致力于&nbsp;Vim&nbsp;的模拟。</li></ul><p style="text-indent: 0px; text-align: left;">更多详情可<a href="https://my.oschina.net/u/5494143/blog/5584325" target="">查看官方博客</a>。</p>', '', 0, 0, 'CSDN', '开云', NULL, false, 1, '2024-01-08 19:02:12', '2022-10-22 14:36:10');
INSERT INTO "public"."t_notice" VALUES (55, 2, '1024创新实验室 十一放假通知', true, false, '2024-01-01 20:22:23', '国庆假期即将来临，根据国务院办公厅关于国庆节的放假安排，废纸信息网安排如下：10月1日至7日放假调休，共7天。
衷心预祝
国庆快乐，阖家幸福！', '<p style="text-indent: 0px; text-align: justify;">国庆假期即将来临，根据国务院办公厅关于国庆节的放假安排，废纸信息网安排如下：<strong>10月1日至7日放假调休</strong>，共7天。</p><p style="text-indent: 0px; text-align: justify;"><strong>衷心预祝</strong></p><p style="text-indent: 0px; text-align: justify;"><strong>国庆快乐，阖家幸福！</strong></p>', '', 0, 0, '人力行政部', '卓大', '1024创新实验室发〔2022〕字第36号', false, 1, '2024-01-08 19:02:12', '2022-10-22 14:37:57');
INSERT INTO "public"."t_notice" VALUES (56, 2, '十月份技术分享会议', true, false, '2024-01-01 20:22:23', '尊敬的各位技术大佬：
1024创新实验室技术分享即将隆重举行
现将有关会议事宜通知如下：
一、会议内容
1、研究探讨SmartAdmin的技术体系
二、会议形式
大会专题小会分组讨论;
三、会议时间及地点
会议报到时间：xxx1年6月14日
会议报到地点：洛阳市', '<p style="text-indent: 0px; text-align: start;">尊敬的各位技术大佬：</p><p style="text-indent: 0px; text-align: start;">1024创新实验室技术分享即将隆重举行</p><p style="text-indent: 0px; text-align: start;">现将有关会议事宜通知如下：</p><p style="text-indent: 0px; text-align: start;"><strong>一、会议内容</strong></p><p style="text-indent: 0px; text-align: start;">1、研究探讨SmartAdmin的技术体系</p><p style="text-indent: 0px; text-align: start;"><strong>二、会议形式</strong></p><p style="text-indent: 0px; text-align: start;">大会专题小会分组讨论;</p><p style="text-indent: 0px; text-align: start;"><strong>三、会议时间及地点</strong></p><p style="text-indent: 0px; text-align: start;">会议报到时间：xxx1年6月14日</p><p style="text-indent: 0px; text-align: start;">会议报到地点：洛阳市</p>', '', 0, 0, '技术部', '开云', '1024创新实验室发〔2022〕字第33号', false, 1, '2024-01-08 19:02:12', '2022-10-22 14:40:45');
INSERT INTO "public"."t_notice" VALUES (57, 2, '关于疫情防控上班通知', true, false, '2024-01-01 20:22:23', '近期，国内部分地区疫情频发，多地疫情出现外溢，为有效降低我市疫情输入和传播风险，洛阳市疾病预防控制中心发布疫情防控公众提示：
一、所有入（返）洛阳人员均需提前3天向目的地社区（村居）、酒店宾馆、接待单位等所属网格进行报备，或通过“洛阳即时通系统”进行自主报备，配合做好健康码和行程码查验、核酸检测、隔离观察和健康监测等相关疫情防控措施。
二、倡导广大群众减少跨地市出行，避免人群大范围流动引发的疫情传播扩散风险。
三、对7天内有高风险区旅居史的人员，采取7天集中隔离医学观察；对7天内有中风险区旅居史的人员，采取7天居家隔离医学观察，如不具备居家隔离医学观察条件的，采取集中隔离医学观察。
四、对疫情发生地出现一定范围社区传播或已实施大范围社区管控措施，基于对疫情输入风险研判结果，对近7天内来自疫情发生地所在县（市、区）的流入人员，参照中风险区旅居史人员的防控要求采取相应措施。
五、对所有省外入（返）洛阳人员，须持有48小时内核酸检测阴性证明，抵达后进行“5天3检”，每次检测间隔24小时。推广“落地检”，按照“自愿免费即采即走，不限制流动”的原则，抵达我市后，立即进行1次核酸检测。
六、加强重点机构场所疫情防控，坚持非必要不举办，对确需举办的培训、会展、文艺演出等大型聚集性活动，查验48小时内核酸检测阴性证明；建筑工地等人员密集型单位，查验外省（区、市）返岗人员48小时内核酸检测阴性证明；养老机构、儿童福利机构等查验探访人员48小时内核酸检测阴性证明；对进入宾馆、酒店和旅游景区等人流密集场所时，查验48小时内核酸检测阴性证明。
七、近期有外出旅行史的人员，请密切关注疫情发生地区公布的病例和无症状感染者流调轨迹信息和中高风险区信息。有涉疫风险的人员要立即向社区（村）、住宿宾馆和单位报告，配合落实隔离医学观察。
八、发热病人、健康码“黄码”等人员要履行个人防护责任，主动配合健康监测和核酸检测，在未排除感染风险前不出行。
', '<p style="text-indent: 0px; text-align: justify;">近期，国内部分地区疫情频发，多地疫情出现外溢，为有效降低我市疫情输入和传播风险，洛阳市疾病预防控制中心发布疫情防控公众提示：</p><p style="text-indent: 0px; text-align: justify;">一、所有入（返）洛阳人员均需提前3天向目的地社区（村居）、酒店宾馆、接待单位等所属网格进行报备，或通过“洛阳即时通系统”进行自主报备，配合做好健康码和行程码查验、核酸检测、隔离观察和健康监测等相关疫情防控措施。</p><p style="text-indent: 0px; text-align: justify;">二、倡导广大群众减少跨地市出行，避免人群大范围流动引发的疫情传播扩散风险。</p><p style="text-indent: 0px; text-align: justify;">三、对7天内有高风险区旅居史的人员，采取7天集中隔离医学观察；对7天内有中风险区旅居史的人员，采取7天居家隔离医学观察，如不具备居家隔离医学观察条件的，采取集中隔离医学观察。</p><p style="text-indent: 0px; text-align: justify;">四、对疫情发生地出现一定范围社区传播或已实施大范围社区管控措施，基于对疫情输入风险研判结果，对近7天内来自疫情发生地所在县（市、区）的流入人员，参照中风险区旅居史人员的防控要求采取相应措施。</p><p style="text-indent: 0px; text-align: justify;">五、对所有省外入（返）洛阳人员，须持有48小时内核酸检测阴性证明，抵达后进行“5天3检”，每次检测间隔24小时。推广“落地检”，按照“自愿免费即采即走，不限制流动”的原则，抵达我市后，立即进行1次核酸检测。</p><p style="text-indent: 0px; text-align: justify;">六、加强重点机构场所疫情防控，坚持非必要不举办，对确需举办的培训、会展、文艺演出等大型聚集性活动，查验48小时内核酸检测阴性证明；建筑工地等人员密集型单位，查验外省（区、市）返岗人员48小时内核酸检测阴性证明；养老机构、儿童福利机构等查验探访人员48小时内核酸检测阴性证明；对进入宾馆、酒店和旅游景区等人流密集场所时，查验48小时内核酸检测阴性证明。</p><p style="text-indent: 0px; text-align: justify;">七、近期有外出旅行史的人员，请密切关注疫情发生地区公布的病例和无症状感染者流调轨迹信息和中高风险区信息。有涉疫风险的人员要立即向社区（村）、住宿宾馆和单位报告，配合落实隔离医学观察。</p><p style="text-indent: 0px; text-align: justify;">八、发热病人、健康码“黄码”等人员要履行个人防护责任，主动配合健康监测和核酸检测，在未排除感染风险前不出行。</p><p style="text-indent: 0px; text-align: justify;"><br></p>', '', 0, 0, '行政部', '卓大', '1024创新实验室发〔2022〕字第40号', false, 1, '2024-01-08 19:02:12', '2022-10-22 14:46:00');
INSERT INTO "public"."t_notice" VALUES (58, 2, '办公室消杀关键位置通知', true, false, '2024-01-01 20:22:23', '开展消毒消杀是杀灭病源、切断疫情传播的有效手段，是防控疫情的重要措施。为了切实将新型冠状病毒肺炎疫情防控工作落到实处，守护好辖区居民及工作人员的身体健康和生命安全，青山镇高度重视新型冠状病毒肺炎的消杀工作，将采购的防护服，防护面罩，一次性手套，口罩，84消毒液，酒精消毒液以及喷雾工具等消毒消杀物资，分发到镇级各站所各村（社区），全镇开展消杀工作。', '<p><span style="color: rgb(93, 93, 93); background-color: rgb(247, 247, 247);">开展消毒消杀是杀灭病源、切断疫情传播的有效手段，是防控疫情的重要措施。为了切实将新型冠状病毒肺炎疫情防控工作落到实处，守护好辖区居民及工作人员的身体健康和生命安全，青山镇高度重视新型冠状病毒肺炎的消杀工作，将采购的防护服，防护面罩，一次性手套，口罩，84消毒液，酒精消毒液以及喷雾工具等消毒消杀物资，分发到镇级各站所各村（社区），全镇开展消杀工作。</span></p>', '', 0, 0, '行政部', '卓大', '1024创新实验室发〔2022〕字第26号', false, 1, '2024-01-08 19:02:12', '2022-10-22 14:47:12');
INSERT INTO "public"."t_notice" VALUES (59, 2, '十月份人事任命通知', true, false, '2024-01-01 20:22:23', '1024创新实验室发〔2022〕字第36号
1024创新实验室发〔2022〕字第36号
1024创新实验室发〔2022〕字第36号
1024创新实验室发〔2022〕字第36号
1024创新实验室发〔2022〕字第36号
1024创新实验室发〔2022〕字第36号', '<p>1024创新实验室发〔2022〕字第36号</p><p>1024创新实验室发〔2022〕字第36号</p><p>1024创新实验室发〔2022〕字第36号</p><p>1024创新实验室发〔2022〕字第36号</p><p>1024创新实验室发〔2022〕字第36号</p><p>1024创新实验室发〔2022〕字第36号</p>', '', 0, 0, '销售部', '卓大', '1024创新实验室发〔2022〕字第30号', false, 1, '2024-01-08 19:02:12', '2022-10-22 14:50:11');
INSERT INTO "public"."t_notice" VALUES (60, 2, '1024创新实验室 春节放假通知', true, false, '2024-01-01 20:22:23', '春节假期即将来临，根据国务院办公厅关于国庆节的放假安排，废纸信息网安排如下：10月1日至7日放假调休，共7天。
衷心预祝
国庆快乐，阖家幸福！', '<p style="text-indent: 0px; text-align: justify;">国庆假期即将来临，根据国务院办公厅关于国庆节的放假安排，废纸信息网安排如下：<strong>10月1日至7日放假调休</strong>，共7天。</p><p style="text-indent: 0px; text-align: justify;"><strong>衷心预祝</strong></p><p style="text-indent: 0px; text-align: justify;"><strong>国庆快乐，阖家幸福！</strong></p>', '', 0, 0, '人力行政部', '卓大', '1024创新实验室发〔2022〕字第36号', false, 1, '2024-01-08 19:02:12', '2022-10-22 14:37:57');

-- ----------------------------
-- Table structure for t_notice_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_notice_type";
CREATE TABLE "public"."t_notice_type" (
  "notice_type_id" BIGSERIAL,
  "notice_type_name" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_notice_type"."notice_type_id" IS '通知类型';
COMMENT ON COLUMN "public"."t_notice_type"."notice_type_name" IS '类型名称';
COMMENT ON TABLE "public"."t_notice_type" IS '通知类型';

-- ----------------------------
-- Records of t_notice_type
-- ----------------------------
INSERT INTO "public"."t_notice_type" VALUES (1, '新闻', '2022-08-16 20:29:15', '2024-09-03 21:44:42');
INSERT INTO "public"."t_notice_type" VALUES (2, '通知', '2022-08-16 20:29:20', '2022-08-16 20:29:20');

-- ----------------------------
-- Table structure for t_notice_view_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_notice_view_record";
CREATE TABLE "public"."t_notice_view_record" (
  "notice_id" int8 NOT NULL,
  "employee_id" int8 NOT NULL,
  "page_view_count" int4,
  "first_ip" varchar(255) COLLATE "pg_catalog"."default",
  "first_user_agent" varchar(1000) COLLATE "pg_catalog"."default",
  "last_ip" varchar(255) COLLATE "pg_catalog"."default",
  "last_user_agent" varchar(1000) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_notice_view_record"."notice_id" IS '通知公告id';
COMMENT ON COLUMN "public"."t_notice_view_record"."employee_id" IS '员工id';
COMMENT ON COLUMN "public"."t_notice_view_record"."page_view_count" IS '查看次数';
COMMENT ON COLUMN "public"."t_notice_view_record"."first_ip" IS '首次ip';
COMMENT ON COLUMN "public"."t_notice_view_record"."first_user_agent" IS '首次用户设备等标识';
COMMENT ON COLUMN "public"."t_notice_view_record"."last_ip" IS '最后一次ip';
COMMENT ON COLUMN "public"."t_notice_view_record"."last_user_agent" IS '最后一次用户设备等标识';
COMMENT ON TABLE "public"."t_notice_view_record" IS '通知查看记录';

-- ----------------------------
-- Records of t_notice_view_record
-- ----------------------------

-- ----------------------------
-- Table structure for t_notice_visible_range
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_notice_visible_range";
CREATE TABLE "public"."t_notice_visible_range" (
  "notice_id" int8 NOT NULL,
  "data_type" int2 NOT NULL,
  "data_id" int8 NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_notice_visible_range"."notice_id" IS '资讯id';
COMMENT ON COLUMN "public"."t_notice_visible_range"."data_type" IS '数据类型1员工 2部门';
COMMENT ON COLUMN "public"."t_notice_visible_range"."data_id" IS '员工or部门id';
COMMENT ON TABLE "public"."t_notice_visible_range" IS '通知可见范围';

-- ----------------------------
-- Records of t_notice_visible_range
-- ----------------------------
INSERT INTO "public"."t_notice_visible_range" VALUES (63, 1, 63, '2024-08-09 10:40:32');

-- ----------------------------
-- Table structure for t_oa_bank
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_oa_bank";
CREATE TABLE "public"."t_oa_bank" (
  "bank_id" BIGSERIAL,
  "bank_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "account_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "account_number" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "business_flag" bool NOT NULL  DEFAULT FALSE,
  "enterprise_id" int8 NOT NULL,
  "disabled_flag" bool NOT NULL  DEFAULT FALSE,
  "deleted_flag" bool NOT NULL  DEFAULT FALSE,
  "create_user_id" int8 NOT NULL,
  "create_user_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_oa_bank"."bank_id" IS '银行信息ID';
COMMENT ON COLUMN "public"."t_oa_bank"."bank_name" IS '开户银行';
COMMENT ON COLUMN "public"."t_oa_bank"."account_name" IS '账户名称';
COMMENT ON COLUMN "public"."t_oa_bank"."account_number" IS '账号';
COMMENT ON COLUMN "public"."t_oa_bank"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_oa_bank"."business_flag" IS '是否对公';
COMMENT ON COLUMN "public"."t_oa_bank"."enterprise_id" IS '企业ID';
COMMENT ON COLUMN "public"."t_oa_bank"."disabled_flag" IS '禁用状态';
COMMENT ON COLUMN "public"."t_oa_bank"."deleted_flag" IS '删除状态';
COMMENT ON COLUMN "public"."t_oa_bank"."create_user_id" IS '创建人ID';
COMMENT ON COLUMN "public"."t_oa_bank"."create_user_name" IS '创建人';
COMMENT ON COLUMN "public"."t_oa_bank"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_oa_bank"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_oa_bank" IS 'OA银行信息
';

-- ----------------------------
-- Records of t_oa_bank
-- ----------------------------
INSERT INTO "public"."t_oa_bank" VALUES (26, '工商银行', '1024创新实验室', '1024', '基本户', true, 2, false, false, 1, '管理员', '2022-10-22 17:58:43', '2022-10-22 17:58:43');
INSERT INTO "public"."t_oa_bank" VALUES (27, '建设银行', '1024创新实验室', '10241', '其他户', false, 2, false, false, 1, '管理员', '2022-10-22 17:59:19', '2022-10-22 17:59:19');

-- ----------------------------
-- Table structure for t_oa_enterprise
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_oa_enterprise";
CREATE TABLE "public"."t_oa_enterprise" (
  "enterprise_id" BIGSERIAL,
  "enterprise_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "enterprise_logo" varchar(255) COLLATE "pg_catalog"."default",
  "type" int4 NOT NULL,
  "unified_social_credit_code" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "contact" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "contact_phone" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(100) COLLATE "pg_catalog"."default",
  "province" varchar(100) COLLATE "pg_catalog"."default",
  "province_name" varchar(100) COLLATE "pg_catalog"."default",
  "city" varchar(100) COLLATE "pg_catalog"."default",
  "city_name" varchar(100) COLLATE "pg_catalog"."default",
  "district" varchar(100) COLLATE "pg_catalog"."default",
  "district_name" varchar(100) COLLATE "pg_catalog"."default",
  "address" varchar(255) COLLATE "pg_catalog"."default",
  "business_license" varchar(255) COLLATE "pg_catalog"."default",
  "disabled_flag" bool NOT NULL  DEFAULT FALSE,
  "deleted_flag" bool NOT NULL  DEFAULT FALSE,
  "create_user_id" int8 NOT NULL,
  "create_user_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_oa_enterprise"."enterprise_id" IS '企业ID';
COMMENT ON COLUMN "public"."t_oa_enterprise"."enterprise_name" IS '企业名称';
COMMENT ON COLUMN "public"."t_oa_enterprise"."enterprise_logo" IS '企业logo';
COMMENT ON COLUMN "public"."t_oa_enterprise"."type" IS '类型（1:有限公司;2:合伙公司）';
COMMENT ON COLUMN "public"."t_oa_enterprise"."unified_social_credit_code" IS '统一社会信用代码';
COMMENT ON COLUMN "public"."t_oa_enterprise"."contact" IS '联系人';
COMMENT ON COLUMN "public"."t_oa_enterprise"."contact_phone" IS '联系人电话';
COMMENT ON COLUMN "public"."t_oa_enterprise"."email" IS '邮箱';
COMMENT ON COLUMN "public"."t_oa_enterprise"."province" IS '省份';
COMMENT ON COLUMN "public"."t_oa_enterprise"."province_name" IS '省份名称';
COMMENT ON COLUMN "public"."t_oa_enterprise"."city" IS '市';
COMMENT ON COLUMN "public"."t_oa_enterprise"."city_name" IS '城市名称';
COMMENT ON COLUMN "public"."t_oa_enterprise"."district" IS '区县';
COMMENT ON COLUMN "public"."t_oa_enterprise"."district_name" IS '区县名称';
COMMENT ON COLUMN "public"."t_oa_enterprise"."address" IS '详细地址';
COMMENT ON COLUMN "public"."t_oa_enterprise"."business_license" IS '营业执照';
COMMENT ON COLUMN "public"."t_oa_enterprise"."disabled_flag" IS '禁用状态';
COMMENT ON COLUMN "public"."t_oa_enterprise"."deleted_flag" IS '删除状态';
COMMENT ON COLUMN "public"."t_oa_enterprise"."create_user_id" IS '创建人ID';
COMMENT ON COLUMN "public"."t_oa_enterprise"."create_user_name" IS '创建人';
COMMENT ON COLUMN "public"."t_oa_enterprise"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_oa_enterprise"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_oa_enterprise" IS 'OA企业模块
';

-- ----------------------------
-- Records of t_oa_enterprise
-- ----------------------------
INSERT INTO "public"."t_oa_enterprise" VALUES (1, '1024创新区块链实验室', 'public/common/34f5ac0fc097402294aea75352c128f0_20240306112435.png', 1, '1024lab_block', '开云', '18637925892', NULL, '410000', '河南省', '410300', '洛阳市', '410311', '洛龙区', '区块链大楼', 'public/common/1d89055e5680426280446aff1e7e627c_20240306112451.jpeg', false, false, 1, '管理员', '2021-10-22 17:03:35', '2022-10-22 17:04:18');
INSERT INTO "public"."t_oa_enterprise" VALUES (2, '1024创新实验室', '', 2, '1024lab', '卓大', '18637925892', 'lab1024@163.com', '410000', '河南省', '410300', '洛阳市', '410311', '洛龙区', '1024大楼', 'public/common/59b1ca99b7fe45d78678e6295798a699_20231201200459.jpg', false, false, 44, '卓大', '2022-10-22 14:57:36', '2022-10-22 17:03:57');

-- ----------------------------
-- Table structure for t_oa_enterprise_employee
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_oa_enterprise_employee";
CREATE TABLE "public"."t_oa_enterprise_employee" (
  "enterprise_employee_id" BIGSERIAL,
  "enterprise_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "employee_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_oa_enterprise_employee"."enterprise_employee_id" IS '主键ID';
COMMENT ON COLUMN "public"."t_oa_enterprise_employee"."enterprise_id" IS '订单ID';
COMMENT ON COLUMN "public"."t_oa_enterprise_employee"."employee_id" IS '货物名称';
COMMENT ON COLUMN "public"."t_oa_enterprise_employee"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_oa_enterprise_employee"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_oa_enterprise_employee" IS '企业关联的员工';

-- ----------------------------
-- Records of t_oa_enterprise_employee
-- ----------------------------
INSERT INTO "public"."t_oa_enterprise_employee" VALUES (154, '2', '2', '2022-10-22 17:57:50', '2022-10-22 17:57:50');
INSERT INTO "public"."t_oa_enterprise_employee" VALUES (155, '2', '44', '2022-10-22 17:57:50', '2022-10-22 17:57:50');

-- ----------------------------
-- Table structure for t_oa_invoice
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_oa_invoice";
CREATE TABLE "public"."t_oa_invoice" (
  "invoice_id" BIGSERIAL,
  "invoice_heads" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "taxpayer_identification_number" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "account_number" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "bank_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "enterprise_id" int8 NOT NULL,
  "disabled_flag" bool NOT NULL  DEFAULT FALSE,
  "deleted_flag" bool NOT NULL  DEFAULT FALSE,
  "create_user_id" int8 NOT NULL,
  "create_user_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_oa_invoice"."invoice_id" IS '发票信息ID';
COMMENT ON COLUMN "public"."t_oa_invoice"."invoice_heads" IS '开票抬头';
COMMENT ON COLUMN "public"."t_oa_invoice"."taxpayer_identification_number" IS '纳税人识别号';
COMMENT ON COLUMN "public"."t_oa_invoice"."account_number" IS '银行账户';
COMMENT ON COLUMN "public"."t_oa_invoice"."bank_name" IS '开户行';
COMMENT ON COLUMN "public"."t_oa_invoice"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_oa_invoice"."enterprise_id" IS '企业ID';
COMMENT ON COLUMN "public"."t_oa_invoice"."disabled_flag" IS '禁用状态';
COMMENT ON COLUMN "public"."t_oa_invoice"."deleted_flag" IS '删除状态';
COMMENT ON COLUMN "public"."t_oa_invoice"."create_user_id" IS '创建人ID';
COMMENT ON COLUMN "public"."t_oa_invoice"."create_user_name" IS '创建人';
COMMENT ON COLUMN "public"."t_oa_invoice"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_oa_invoice"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."t_oa_invoice" IS 'OA发票信息
';

-- ----------------------------
-- Records of t_oa_invoice
-- ----------------------------
INSERT INTO "public"."t_oa_invoice" VALUES (15, '1024创新实验室', '1024lab', '1024lab', '中国银行', '123', 2, false, false, 1, '管理员', '2022-10-22 17:59:35', '2023-09-27 16:26:07');

-- ----------------------------
-- Table structure for t_operate_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_operate_log";
CREATE TABLE "public"."t_operate_log" (
  "operate_log_id" BIGSERIAL,
  "operate_user_id" int8 NOT NULL,
  "operate_user_type" int4 NOT NULL,
  "operate_user_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "module" varchar(50) COLLATE "pg_catalog"."default",
  "content" varchar(500) COLLATE "pg_catalog"."default",
  "url" varchar(100) COLLATE "pg_catalog"."default",
  "method" varchar(100) COLLATE "pg_catalog"."default",
  "param" text COLLATE "pg_catalog"."default",
  "ip" varchar(255) COLLATE "pg_catalog"."default",
  "ip_region" varchar(1000) COLLATE "pg_catalog"."default",
  "user_agent" text COLLATE "pg_catalog"."default",
  "success_flag" bool NOT NULL  DEFAULT FALSE,
  "fail_reason" text COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_operate_log"."operate_log_id" IS '主键';
COMMENT ON COLUMN "public"."t_operate_log"."operate_user_id" IS '用户id';
COMMENT ON COLUMN "public"."t_operate_log"."operate_user_type" IS '用户类型';
COMMENT ON COLUMN "public"."t_operate_log"."operate_user_name" IS '用户名称';
COMMENT ON COLUMN "public"."t_operate_log"."module" IS '操作模块';
COMMENT ON COLUMN "public"."t_operate_log"."content" IS '操作内容';
COMMENT ON COLUMN "public"."t_operate_log"."url" IS '请求路径';
COMMENT ON COLUMN "public"."t_operate_log"."method" IS '请求方法';
COMMENT ON COLUMN "public"."t_operate_log"."param" IS '请求参数';
COMMENT ON COLUMN "public"."t_operate_log"."ip" IS '请求ip';
COMMENT ON COLUMN "public"."t_operate_log"."ip_region" IS '请求ip地区';
COMMENT ON COLUMN "public"."t_operate_log"."user_agent" IS '请求user-agent';
COMMENT ON COLUMN "public"."t_operate_log"."success_flag" IS '请求结果 0失败 1成功';
COMMENT ON COLUMN "public"."t_operate_log"."fail_reason" IS '失败原因';
COMMENT ON COLUMN "public"."t_operate_log"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_operate_log"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_operate_log" IS '操作记录';

-- ----------------------------
-- Records of t_operate_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_password_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_password_log";
CREATE TABLE "public"."t_password_log" (
  "id" BIGSERIAL,
  "user_id" int8 NOT NULL,
  "user_type" int2 NOT NULL,
  "old_password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "new_password" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_password_log"."id" IS '主键';
COMMENT ON COLUMN "public"."t_password_log"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."t_password_log"."user_type" IS '用户类型';
COMMENT ON COLUMN "public"."t_password_log"."old_password" IS '旧密码';
COMMENT ON COLUMN "public"."t_password_log"."new_password" IS '新密码';
COMMENT ON COLUMN "public"."t_password_log"."update_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_password_log"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_password_log" IS '密码修改记录';

-- ----------------------------
-- Records of t_password_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_position
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_position";
CREATE TABLE "public"."t_position" (
  "position_id" BIGSERIAL,
  "position_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "level" varchar(200) COLLATE "pg_catalog"."default",
  "sort" int4,
  "remark" varchar(200) COLLATE "pg_catalog"."default",
  "deleted_flag" bool NOT NULL  DEFAULT FALSE,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_position"."position_id" IS '职务ID';
COMMENT ON COLUMN "public"."t_position"."position_name" IS '职务名称';
COMMENT ON COLUMN "public"."t_position"."level" IS '职级';
COMMENT ON COLUMN "public"."t_position"."sort" IS '排序';
COMMENT ON COLUMN "public"."t_position"."remark" IS '备注';
COMMENT ON TABLE "public"."t_position" IS '职务表';

-- ----------------------------
-- Records of t_position
-- ----------------------------
INSERT INTO "public"."t_position" VALUES (3, '技术P7', 'L1', 3, '', false, '2024-06-29 15:57:07', '2024-07-15 23:34:35');
INSERT INTO "public"."t_position" VALUES (4, '技术P8', 'L2', 1, NULL, false, '2024-07-15 23:34:14', '2024-07-15 23:34:23');
INSERT INTO "public"."t_position" VALUES (5, '管理M5', 'L1', 4, NULL, false, '2024-07-15 23:34:48', '2024-07-15 23:34:48');
INSERT INTO "public"."t_position" VALUES (6, '管理M6', 'L2', 5, NULL, false, '2024-07-15 23:35:00', '2024-07-15 23:35:00');

-- ----------------------------
-- Table structure for t_reload_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_reload_item";
CREATE TABLE "public"."t_reload_item" (
  "tag" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "args" varchar(255) COLLATE "pg_catalog"."default",
  "identification" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_reload_item"."tag" IS '项名称';
COMMENT ON COLUMN "public"."t_reload_item"."args" IS '参数 可选';
COMMENT ON COLUMN "public"."t_reload_item"."identification" IS '运行标识';
COMMENT ON TABLE "public"."t_reload_item" IS 'reload项目';

-- ----------------------------
-- Records of t_reload_item
-- ----------------------------
INSERT INTO "public"."t_reload_item" VALUES ('system_config', '4', '234', '2024-08-13 14:14:30', '2019-04-18 11:48:27');

-- ----------------------------
-- Table structure for t_reload_result
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_reload_result";
CREATE TABLE "public"."t_reload_result" (
  "tag" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "identification" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "args" varchar(255) COLLATE "pg_catalog"."default",
  "result" int2 NOT NULL,
  "exception" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_reload_result"."identification" IS '运行标识';
COMMENT ON COLUMN "public"."t_reload_result"."result" IS '是否成功 ';
COMMENT ON TABLE "public"."t_reload_result" IS 'reload结果';

-- ----------------------------
-- Records of t_reload_result
-- ----------------------------

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_role";
CREATE TABLE "public"."t_role" (
  "role_id" BIGSERIAL,
  "role_name" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "role_code" varchar(500) COLLATE "pg_catalog"."default",
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_role"."role_id" IS '主键';
COMMENT ON COLUMN "public"."t_role"."role_name" IS '角色名称';
COMMENT ON COLUMN "public"."t_role"."role_code" IS '角色编码';
COMMENT ON COLUMN "public"."t_role"."remark" IS '角色描述';
COMMENT ON COLUMN "public"."t_role"."update_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_role"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_role" IS '角色表';

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO "public"."t_role" VALUES (1, '技术总监', NULL, '', '2022-10-19 20:24:09', '2019-06-21 12:09:34');
INSERT INTO "public"."t_role" VALUES (34, '销售总监', 'cto', '', '2023-09-06 19:10:34', '2019-08-30 09:30:50');
INSERT INTO "public"."t_role" VALUES (35, '总经理', NULL, '', '2019-08-30 09:31:05', '2019-08-30 09:31:05');
INSERT INTO "public"."t_role" VALUES (36, '董事长', NULL, '', '2019-08-30 09:31:11', '2019-08-30 09:31:11');
INSERT INTO "public"."t_role" VALUES (37, '财务', NULL, '', '2019-08-30 09:31:16', '2019-08-30 09:31:16');

-- ----------------------------
-- Table structure for t_role_data_scope
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_role_data_scope";
CREATE TABLE "public"."t_role_data_scope" (
  "id" BIGSERIAL,
  "data_scope_type" int4 NOT NULL,
  "view_type" int4 NOT NULL,
  "role_id" int8 NOT NULL,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_role_data_scope"."data_scope_type" IS '数据范围类型';
COMMENT ON COLUMN "public"."t_role_data_scope"."view_type" IS '数据可见范围类型';
COMMENT ON COLUMN "public"."t_role_data_scope"."role_id" IS '角色id';
COMMENT ON COLUMN "public"."t_role_data_scope"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_role_data_scope"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_role_data_scope" IS '角色的数据范围';

-- ----------------------------
-- Records of t_role_data_scope
-- ----------------------------
INSERT INTO "public"."t_role_data_scope" VALUES (67, 1, 2, 1, '2024-03-18 20:41:00', '2024-03-18 20:41:00');

-- ----------------------------
-- Table structure for t_role_employee
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_role_employee";
CREATE TABLE "public"."t_role_employee" (
  "id" BIGSERIAL,
  "role_id" int8 NOT NULL,
  "employee_id" int8 NOT NULL,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_role_employee"."role_id" IS '角色id';
COMMENT ON COLUMN "public"."t_role_employee"."employee_id" IS '员工id';
COMMENT ON COLUMN "public"."t_role_employee"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_role_employee"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_role_employee" IS '角色员工功能表';

-- ----------------------------
-- Records of t_role_employee
-- ----------------------------
INSERT INTO "public"."t_role_employee" VALUES (325, 36, 63, '2022-10-19 20:25:26', '2022-10-19 20:25:26');
INSERT INTO "public"."t_role_employee" VALUES (329, 34, 72, '2022-11-05 10:56:54', '2022-11-05 10:56:54');
INSERT INTO "public"."t_role_employee" VALUES (330, 36, 72, '2022-11-05 10:56:54', '2022-11-05 10:56:54');
INSERT INTO "public"."t_role_employee" VALUES (333, 1, 44, '2023-10-07 18:53:29', '2023-10-07 18:53:29');
INSERT INTO "public"."t_role_employee" VALUES (334, 1, 47, '2023-10-07 18:55:00', '2023-10-07 18:55:00');
INSERT INTO "public"."t_role_employee" VALUES (341, 1, 48, '2024-09-02 23:03:28', '2024-09-02 23:03:28');

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_role_menu";
CREATE TABLE "public"."t_role_menu" (
  "role_menu_id" BIGSERIAL,
  "role_id" int8 NOT NULL,
  "menu_id" int8 NOT NULL,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_role_menu"."role_menu_id" IS '主键id';
COMMENT ON COLUMN "public"."t_role_menu"."role_id" IS '角色id';
COMMENT ON COLUMN "public"."t_role_menu"."menu_id" IS '菜单id';
COMMENT ON COLUMN "public"."t_role_menu"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_role_menu"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."t_role_menu" IS '角色-菜单
';

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO "public"."t_role_menu" VALUES (236, 1, 138, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (237, 1, 132, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (238, 1, 142, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (239, 1, 149, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (240, 1, 150, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (241, 1, 185, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (242, 1, 186, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (243, 1, 187, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (244, 1, 188, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (245, 1, 145, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (246, 1, 196, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (247, 1, 144, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (248, 1, 181, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (249, 1, 183, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (250, 1, 184, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (251, 1, 165, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (252, 1, 47, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (253, 1, 48, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (254, 1, 137, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (255, 1, 166, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (256, 1, 194, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (257, 1, 78, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (258, 1, 173, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (259, 1, 174, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (260, 1, 175, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (261, 1, 176, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (262, 1, 50, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (263, 1, 26, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (264, 1, 40, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (265, 1, 105, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (266, 1, 106, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (267, 1, 109, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (268, 1, 163, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (269, 1, 164, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (270, 1, 199, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (271, 1, 110, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (272, 1, 159, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (273, 1, 160, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (274, 1, 161, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (275, 1, 162, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (276, 1, 130, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (277, 1, 157, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (278, 1, 158, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (279, 1, 133, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (280, 1, 117, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (281, 1, 156, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (282, 1, 193, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (283, 1, 200, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (284, 1, 220, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (285, 1, 45, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (286, 1, 219, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (287, 1, 46, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (288, 1, 91, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (289, 1, 92, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (290, 1, 93, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (291, 1, 94, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (292, 1, 95, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (293, 1, 96, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (294, 1, 86, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (295, 1, 87, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (296, 1, 88, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (297, 1, 76, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (298, 1, 97, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (299, 1, 98, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (300, 1, 99, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (301, 1, 100, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (302, 1, 101, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (303, 1, 102, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (304, 1, 103, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (305, 1, 104, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (306, 1, 213, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (307, 1, 214, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (308, 1, 143, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (309, 1, 203, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (310, 1, 215, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (311, 1, 218, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (312, 1, 147, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (313, 1, 170, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (314, 1, 171, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (315, 1, 168, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (316, 1, 169, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (317, 1, 202, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (318, 1, 201, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (319, 1, 148, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (320, 1, 152, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (321, 1, 190, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (322, 1, 191, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (323, 1, 192, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (324, 1, 198, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (325, 1, 207, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (326, 1, 111, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (327, 1, 206, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (328, 1, 81, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (329, 1, 204, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (330, 1, 205, '2024-06-30 23:21:37', '2024-06-30 23:21:37');
INSERT INTO "public"."t_role_menu" VALUES (331, 1, 122, '2024-06-30 23:21:37', '2024-06-30 23:21:37');

-- ----------------------------
-- Table structure for t_serial_number
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_serial_number";
CREATE TABLE "public"."t_serial_number" (
  "serial_number_id" int4 NOT NULL,
  "business_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "format" varchar(50) COLLATE "pg_catalog"."default",
  "rule_type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "init_number" int8 NOT NULL,
  "step_random_range" int8 NOT NULL,
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "last_number" int8,
  "last_time" timestamp(6),
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_serial_number"."business_name" IS '业务名称';
COMMENT ON COLUMN "public"."t_serial_number"."format" IS '格式[yyyy]表示年,[mm]标识月,[dd]表示日,[nnn]表示三位数字';
COMMENT ON COLUMN "public"."t_serial_number"."rule_type" IS '规则格式。none没有周期, year 年周期, month月周期, day日周期';
COMMENT ON COLUMN "public"."t_serial_number"."init_number" IS '初始值';
COMMENT ON COLUMN "public"."t_serial_number"."step_random_range" IS '步长随机数';
COMMENT ON COLUMN "public"."t_serial_number"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_serial_number"."last_number" IS '上次产生的单号, 默认为空';
COMMENT ON COLUMN "public"."t_serial_number"."last_time" IS '上次产生的单号时间';
COMMENT ON TABLE "public"."t_serial_number" IS '单号生成器定义表';

-- ----------------------------
-- Records of t_serial_number
-- ----------------------------
INSERT INTO "public"."t_serial_number" VALUES (1, '订单编号', 'DK[yyyy][mm][dd]NO[nnnnn]', 'day', 1000, 10, 'DK20201101NO321', 1, '2023-12-04 09:16:42', '2024-01-08 19:24:46', '2021-02-19 14:37:50');
INSERT INTO "public"."t_serial_number" VALUES (2, '合同编号', 'HT[yyyy][mm][dd][nnnnn]-CX', 'none', 1, 1, '', 8, '2023-12-04 09:54:53', '2023-12-04 09:54:52', '2021-08-12 20:40:37');

-- ----------------------------
-- Table structure for t_serial_number_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_serial_number_record";
CREATE TABLE "public"."t_serial_number_record" (
  "serial_number_id" int4 NOT NULL,
  "record_date" date NOT NULL,
  "last_number" int8 NOT NULL,
  "last_time" timestamp(6) NOT NULL,
  "count" int8 NOT NULL,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_serial_number_record"."record_date" IS '记录日期';
COMMENT ON COLUMN "public"."t_serial_number_record"."last_number" IS '最后更新值';
COMMENT ON COLUMN "public"."t_serial_number_record"."last_time" IS '最后更新时间';
COMMENT ON COLUMN "public"."t_serial_number_record"."count" IS '更新次数';
COMMENT ON TABLE "public"."t_serial_number_record" IS 'serial_number记录表';

-- ----------------------------
-- Records of t_serial_number_record
-- ----------------------------

-- ----------------------------
-- Table structure for t_smart_job
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_smart_job";
CREATE TABLE "public"."t_smart_job" (
  "job_id" SERIAL,
  "job_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "job_class" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_type" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_value" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "enabled_flag" bool NOT NULL  DEFAULT FALSE,
  "param" varchar(1000) COLLATE "pg_catalog"."default",
  "last_execute_time" timestamp(6),
  "last_execute_log_id" int4,
  "sort" int4 NOT NULL,
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "deleted_flag" bool NOT NULL  DEFAULT FALSE,
  "update_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_smart_job"."job_id" IS '任务id';
COMMENT ON COLUMN "public"."t_smart_job"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."t_smart_job"."job_class" IS '任务执行类';
COMMENT ON COLUMN "public"."t_smart_job"."trigger_type" IS '触发类型';
COMMENT ON COLUMN "public"."t_smart_job"."trigger_value" IS '触发配置';
COMMENT ON COLUMN "public"."t_smart_job"."enabled_flag" IS '是否开启';
COMMENT ON COLUMN "public"."t_smart_job"."param" IS '参数';
COMMENT ON COLUMN "public"."t_smart_job"."last_execute_time" IS '最后一次执行时间';
COMMENT ON COLUMN "public"."t_smart_job"."last_execute_log_id" IS '最后一次执行记录id';
COMMENT ON COLUMN "public"."t_smart_job"."sort" IS '排序';
COMMENT ON COLUMN "public"."t_smart_job"."remark" IS '描述';
COMMENT ON COLUMN "public"."t_smart_job"."deleted_flag" IS '删除状态';
COMMENT ON COLUMN "public"."t_smart_job"."update_name" IS '更新人';
COMMENT ON TABLE "public"."t_smart_job" IS '定时任务配置 @listen';

-- ----------------------------
-- Records of t_smart_job
-- ----------------------------
INSERT INTO "public"."t_smart_job" VALUES (1, '示例任务1', 'net.lab1024.sa.base.module.support.job.sample.SmartJobSample1', 'cron', '10 15 0/1 * * *', true, '执行示例任务1', '2025-04-12 20:15:10.022048', 12, 1, '执行示例任务1', false, '管理员', '2024-06-17 20:00:46', '2025-04-12 20:14:42');
INSERT INTO "public"."t_smart_job" VALUES (2, '示例任务2', 'net.lab1024.sa.base.module.support.job.sample.SmartJobSample2', 'fixed_delay', '120', true, '执行示例任务2', '2025-04-12 20:20:17.34817', 15, 2, '执行示例任务2', false, '管理员', '2024-06-18 20:45:35', '2025-04-12 20:19:49');

-- ----------------------------
-- Table structure for t_smart_job_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_smart_job_log";
CREATE TABLE "public"."t_smart_job_log" (
  "log_id" SERIAL,
  "job_id" int4 NOT NULL,
  "job_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "param" varchar(2000) COLLATE "pg_catalog"."default",
  "success_flag" bool NOT NULL  DEFAULT FALSE,
  "execute_start_time" timestamp(6) NOT NULL,
  "execute_time_millis" int4,
  "execute_end_time" timestamp(6),
  "execute_result" varchar(2000) COLLATE "pg_catalog"."default",
  "ip" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "process_id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "program_path" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "create_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_smart_job_log"."job_id" IS '任务id';
COMMENT ON COLUMN "public"."t_smart_job_log"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."t_smart_job_log"."param" IS '执行参数';
COMMENT ON COLUMN "public"."t_smart_job_log"."success_flag" IS '是否成功';
COMMENT ON COLUMN "public"."t_smart_job_log"."execute_start_time" IS '执行开始时间';
COMMENT ON COLUMN "public"."t_smart_job_log"."execute_time_millis" IS '执行时长';
COMMENT ON COLUMN "public"."t_smart_job_log"."execute_end_time" IS '执行结束时间';
COMMENT ON COLUMN "public"."t_smart_job_log"."ip" IS 'ip';
COMMENT ON COLUMN "public"."t_smart_job_log"."process_id" IS '进程id';
COMMENT ON COLUMN "public"."t_smart_job_log"."program_path" IS '程序目录';
COMMENT ON COLUMN "public"."t_smart_job_log"."create_name" IS '创建人';
COMMENT ON TABLE "public"."t_smart_job_log" IS '定时任务-执行记录 @listen';

-- ----------------------------
-- Records of t_smart_job_log
-- ----------------------------
INSERT INTO "public"."t_smart_job_log" VALUES (1, 2, '示例任务2', '执行示例任务2', true, '2025-04-11 22:36:20.55288', 35, '2025-04-11 22:36:20.58788', '执行成功,本次处理数据1条', '192.168.3.5', '44044', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-11 22:35:54.068703');
INSERT INTO "public"."t_smart_job_log" VALUES (2, 2, '示例任务2', '执行示例任务2', true, '2025-04-11 22:39:37.532011', 37, '2025-04-11 22:39:37.569011', '执行成功,本次处理数据1条', '192.168.3.5', '44552', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-11 22:39:10.900031');
INSERT INTO "public"."t_smart_job_log" VALUES (3, 2, '示例任务2', '执行示例任务2', true, '2025-04-11 22:41:37.687825', 36, '2025-04-11 22:41:37.723825', '执行成功,本次处理数据1条', '192.168.3.5', '44552', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-11 22:41:11.039212');
INSERT INTO "public"."t_smart_job_log" VALUES (4, 2, '示例任务2', '执行示例任务2', true, '2025-04-11 22:43:37.807485', 35, '2025-04-11 22:43:37.842485', '执行成功,本次处理数据1条', '192.168.3.5', '44552', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-11 22:43:11.154126');
INSERT INTO "public"."t_smart_job_log" VALUES (5, 2, '示例任务2', '执行示例任务2', true, '2025-04-11 22:45:37.937063', 35, '2025-04-11 22:45:37.972063', '执行成功,本次处理数据1条', '192.168.3.5', '44552', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-11 22:45:11.279784');
INSERT INTO "public"."t_smart_job_log" VALUES (6, 2, '示例任务2', '执行示例任务2', true, '2025-04-11 22:47:38.05603', 37, '2025-04-11 22:47:38.09303', '执行成功,本次处理数据1条', '192.168.3.5', '44552', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-11 22:47:11.395234');
INSERT INTO "public"."t_smart_job_log" VALUES (7, 2, '示例任务2', '执行示例任务2', true, '2025-04-11 22:49:38.188184', 36, '2025-04-11 22:49:38.224184', '执行成功,本次处理数据1条', '192.168.3.5', '44552', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-11 22:49:11.523985');
INSERT INTO "public"."t_smart_job_log" VALUES (8, 2, '示例任务2', '执行示例任务2', true, '2025-04-12 20:08:16.340639', 52, '2025-04-12 20:08:16.392639', '执行成功,本次处理数据1条', '192.168.3.5', '21156', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-12 20:07:48.763529');
INSERT INTO "public"."t_smart_job_log" VALUES (9, 2, '示例任务2', '执行示例任务2', true, '2025-04-12 20:10:16.710247', 37, '2025-04-12 20:10:16.747247', '执行成功,本次处理数据1条', '192.168.3.5', '21156', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-12 20:09:48.957579');
INSERT INTO "public"."t_smart_job_log" VALUES (10, 2, '示例任务2', '执行示例任务2', true, '2025-04-12 20:12:16.830852', 39, '2025-04-12 20:12:16.869852', '执行成功,本次处理数据1条', '192.168.3.5', '21156', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-12 20:11:49.074233');
INSERT INTO "public"."t_smart_job_log" VALUES (11, 2, '示例任务2', '执行示例任务2', true, '2025-04-12 20:14:16.957153', 38, '2025-04-12 20:14:16.995153', '执行成功,本次处理数据1条', '192.168.3.5', '21156', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-12 20:13:49.196398');
INSERT INTO "public"."t_smart_job_log" VALUES (12, 1, '示例任务1', '执行示例任务1', true, '2025-04-12 20:15:10.022048', 0, '2025-04-12 20:15:10.022048', '执行完毕,随便说点什么吧', '192.168.3.5', '21156', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-12 20:14:42.260082');
INSERT INTO "public"."t_smart_job_log" VALUES (13, 2, '示例任务2', '执行示例任务2', true, '2025-04-12 20:16:17.087601', 37, '2025-04-12 20:16:17.124601', '执行成功,本次处理数据1条', '192.168.3.5', '21156', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-12 20:15:49.323314');
INSERT INTO "public"."t_smart_job_log" VALUES (14, 2, '示例任务2', '执行示例任务2', true, '2025-04-12 20:18:17.219784', 37, '2025-04-12 20:18:17.256784', '执行成功,本次处理数据1条', '192.168.3.5', '21156', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-12 20:17:49.451958');
INSERT INTO "public"."t_smart_job_log" VALUES (15, 2, '示例任务2', '执行示例任务2', true, '2025-04-12 20:20:17.34817', 36, '2025-04-12 20:20:17.38417', '执行成功,本次处理数据1条', '192.168.3.5', '21156', 'E:\Code\Main\smart-admin\smart-admin-api-java17-springboot3', 'system', '2025-04-12 20:19:49.576861');

-- ----------------------------
-- Table structure for t_table_column
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_table_column";
CREATE TABLE "public"."t_table_column" (
  "table_column_id" BIGSERIAL,
  "user_id" int8 NOT NULL,
  "user_type" int4 NOT NULL,
  "table_id" int4 NOT NULL,
  "columns" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."t_table_column"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."t_table_column"."user_type" IS '用户类型';
COMMENT ON COLUMN "public"."t_table_column"."table_id" IS '表格id';
COMMENT ON COLUMN "public"."t_table_column"."columns" IS '具体的表格列，存入的json';
COMMENT ON TABLE "public"."t_table_column" IS '表格的自定义列存储';

-- ----------------------------
-- Records of t_table_column
-- ----------------------------

-- ----------------------------
-- Function structure for update_t_category_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_category_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_category_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_change_log_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_change_log_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_change_log_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_code_generator_config_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_code_generator_config_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_code_generator_config_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_config_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_config_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_config_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_data_tracer_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_data_tracer_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_data_tracer_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_department_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_department_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_department_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_dict_data_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_dict_data_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_dict_data_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_dict_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_dict_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_dict_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_employee_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_employee_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_employee_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_feedback_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_feedback_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_feedback_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_file_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_file_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_file_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_goods_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_goods_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_goods_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_help_doc_catalog_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_help_doc_catalog_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_help_doc_catalog_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_help_doc_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_help_doc_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_help_doc_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_help_doc_relation_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_help_doc_relation_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_help_doc_relation_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_help_doc_view_record_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_help_doc_view_record_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_help_doc_view_record_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_login_fail_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_login_fail_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_login_fail_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_login_log_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_login_log_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_login_log_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_mail_template_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_mail_template_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_mail_template_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_menu_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_menu_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_menu_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_message_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_message_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_message_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_notice_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_notice_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_notice_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_notice_type_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_notice_type_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_notice_type_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_notice_view_record_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_notice_view_record_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_notice_view_record_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_oa_bank_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_oa_bank_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_oa_bank_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_oa_enterprise_employee_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_oa_enterprise_employee_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_oa_enterprise_employee_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_oa_enterprise_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_oa_enterprise_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_oa_enterprise_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_oa_invoice_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_oa_invoice_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_oa_invoice_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_operate_log_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_operate_log_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_operate_log_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_password_log_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_password_log_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_password_log_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_position_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_position_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_position_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_reload_item_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_reload_item_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_reload_item_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_role_data_scope_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_role_data_scope_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_role_data_scope_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_role_employee_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_role_employee_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_role_employee_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_role_menu_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_role_menu_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_role_menu_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_role_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_role_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_role_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_serial_number_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_serial_number_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_serial_number_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_serial_number_record_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_serial_number_record_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_serial_number_record_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_smart_job_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_smart_job_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_smart_job_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_t_table_column_modified
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_t_table_column_modified"();
CREATE OR REPLACE FUNCTION "public"."update_t_table_column_modified"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
                        BEGIN
                            NEW.update_time = date_trunc('second', CURRENT_TIMESTAMP);
                            RETURN NEW;
                        END;
                        $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."t_smart_job_log_log_id_seq"', 15, true);

-- ----------------------------
-- Indexes structure for table t_category
-- ----------------------------
CREATE INDEX "idx_parent_id" ON "public"."t_category" USING btree (
  "parent_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_category
-- ----------------------------
CREATE TRIGGER "trigger_update_t_category_modified" BEFORE UPDATE ON "public"."t_category"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_category_modified"();

-- ----------------------------
-- Primary Key structure for table t_category
-- ----------------------------
ALTER TABLE "public"."t_category" ADD CONSTRAINT "t_category_pkey" PRIMARY KEY ("category_id");

-- ----------------------------
-- Indexes structure for table t_change_log
-- ----------------------------
CREATE UNIQUE INDEX "version_unique" ON "public"."t_change_log" USING btree (
  "version" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_change_log
-- ----------------------------
CREATE TRIGGER "trigger_update_t_change_log_modified" BEFORE UPDATE ON "public"."t_change_log"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_change_log_modified"();

-- ----------------------------
-- Primary Key structure for table t_change_log
-- ----------------------------
ALTER TABLE "public"."t_change_log" ADD CONSTRAINT "t_change_log_pkey" PRIMARY KEY ("change_log_id");

-- ----------------------------
-- Indexes structure for table t_code_generator_config
-- ----------------------------
CREATE UNIQUE INDEX "table_unique" ON "public"."t_code_generator_config" USING btree (
  "table_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_code_generator_config
-- ----------------------------
CREATE TRIGGER "trigger_update_t_code_generator_config_modified" BEFORE UPDATE ON "public"."t_code_generator_config"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_code_generator_config_modified"();

-- ----------------------------
-- Primary Key structure for table t_code_generator_config
-- ----------------------------
ALTER TABLE "public"."t_code_generator_config" ADD CONSTRAINT "t_code_generator_config_pkey" PRIMARY KEY ("table_name");

-- ----------------------------
-- Triggers structure for table t_config
-- ----------------------------
CREATE TRIGGER "trigger_update_t_config_modified" BEFORE UPDATE ON "public"."t_config"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_config_modified"();

-- ----------------------------
-- Primary Key structure for table t_config
-- ----------------------------
ALTER TABLE "public"."t_config" ADD CONSTRAINT "t_config_pkey" PRIMARY KEY ("config_id");

-- ----------------------------
-- Indexes structure for table t_data_tracer
-- ----------------------------
CREATE INDEX "order_id_order_type" ON "public"."t_data_tracer" USING btree (
  "data_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "type" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_data_tracer
-- ----------------------------
CREATE TRIGGER "trigger_update_t_data_tracer_modified" BEFORE UPDATE ON "public"."t_data_tracer"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_data_tracer_modified"();

-- ----------------------------
-- Primary Key structure for table t_data_tracer
-- ----------------------------
ALTER TABLE "public"."t_data_tracer" ADD CONSTRAINT "t_data_tracer_pkey" PRIMARY KEY ("data_tracer_id");

-- ----------------------------
-- Indexes structure for table t_department
-- ----------------------------
CREATE INDEX "parent_id" ON "public"."t_department" USING btree (
  "parent_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_department
-- ----------------------------
CREATE TRIGGER "trigger_update_t_department_modified" BEFORE UPDATE ON "public"."t_department"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_department_modified"();

-- ----------------------------
-- Primary Key structure for table t_department
-- ----------------------------
ALTER TABLE "public"."t_department" ADD CONSTRAINT "t_department_pkey" PRIMARY KEY ("department_id");

-- ----------------------------
-- Indexes structure for table t_dict
-- ----------------------------
CREATE UNIQUE INDEX "unique_code" ON "public"."t_dict" USING btree (
  "dict_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_dict
-- ----------------------------
CREATE TRIGGER "trigger_update_t_dict_modified" BEFORE UPDATE ON "public"."t_dict"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_dict_modified"();

-- ----------------------------
-- Primary Key structure for table t_dict
-- ----------------------------
ALTER TABLE "public"."t_dict" ADD CONSTRAINT "t_dict_pkey" PRIMARY KEY ("dict_id");

-- ----------------------------
-- Triggers structure for table t_dict_data
-- ----------------------------
CREATE TRIGGER "trigger_update_t_dict_data_modified" BEFORE UPDATE ON "public"."t_dict_data"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_dict_data_modified"();

-- ----------------------------
-- Primary Key structure for table t_dict_data
-- ----------------------------
ALTER TABLE "public"."t_dict_data" ADD CONSTRAINT "t_dict_data_pkey" PRIMARY KEY ("dict_data_id");

-- ----------------------------
-- Triggers structure for table t_employee
-- ----------------------------
CREATE TRIGGER "trigger_update_t_employee_modified" BEFORE UPDATE ON "public"."t_employee"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_employee_modified"();

-- ----------------------------
-- Primary Key structure for table t_employee
-- ----------------------------
ALTER TABLE "public"."t_employee" ADD CONSTRAINT "t_employee_pkey" PRIMARY KEY ("employee_id");

-- ----------------------------
-- Triggers structure for table t_feedback
-- ----------------------------
CREATE TRIGGER "trigger_update_t_feedback_modified" BEFORE UPDATE ON "public"."t_feedback"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_feedback_modified"();

-- ----------------------------
-- Primary Key structure for table t_feedback
-- ----------------------------
ALTER TABLE "public"."t_feedback" ADD CONSTRAINT "t_feedback_pkey" PRIMARY KEY ("feedback_id");

-- ----------------------------
-- Indexes structure for table t_file
-- ----------------------------
CREATE INDEX "module_id_module_type" ON "public"."t_file" USING btree (
  "folder_type" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "module_type" ON "public"."t_file" USING btree (
  "folder_type" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uk_file_key" ON "public"."t_file" USING btree (
  "file_key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_file
-- ----------------------------
CREATE TRIGGER "trigger_update_t_file_modified" BEFORE UPDATE ON "public"."t_file"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_file_modified"();

-- ----------------------------
-- Primary Key structure for table t_file
-- ----------------------------
ALTER TABLE "public"."t_file" ADD CONSTRAINT "t_file_pkey" PRIMARY KEY ("file_id");

-- ----------------------------
-- Triggers structure for table t_goods
-- ----------------------------
CREATE TRIGGER "trigger_update_t_goods_modified" BEFORE UPDATE ON "public"."t_goods"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_goods_modified"();

-- ----------------------------
-- Primary Key structure for table t_goods
-- ----------------------------
ALTER TABLE "public"."t_goods" ADD CONSTRAINT "t_goods_pkey" PRIMARY KEY ("goods_id");

-- ----------------------------
-- Primary Key structure for table t_heart_beat_record
-- ----------------------------
ALTER TABLE "public"."t_heart_beat_record" ADD CONSTRAINT "t_heart_beat_record_pkey" PRIMARY KEY ("heart_beat_record_id");

-- ----------------------------
-- Triggers structure for table t_help_doc
-- ----------------------------
CREATE TRIGGER "trigger_update_t_help_doc_modified" BEFORE UPDATE ON "public"."t_help_doc"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_help_doc_modified"();

-- ----------------------------
-- Primary Key structure for table t_help_doc
-- ----------------------------
ALTER TABLE "public"."t_help_doc" ADD CONSTRAINT "t_help_doc_pkey" PRIMARY KEY ("help_doc_id");

-- ----------------------------
-- Triggers structure for table t_help_doc_catalog
-- ----------------------------
CREATE TRIGGER "trigger_update_t_help_doc_catalog_modified" BEFORE UPDATE ON "public"."t_help_doc_catalog"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_help_doc_catalog_modified"();

-- ----------------------------
-- Primary Key structure for table t_help_doc_catalog
-- ----------------------------
ALTER TABLE "public"."t_help_doc_catalog" ADD CONSTRAINT "t_help_doc_catalog_pkey" PRIMARY KEY ("help_doc_catalog_id");

-- ----------------------------
-- Indexes structure for table t_help_doc_relation
-- ----------------------------
CREATE UNIQUE INDEX "uni_menu_help_doc" ON "public"."t_help_doc_relation" USING btree (
  "relation_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "help_doc_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_help_doc_relation
-- ----------------------------
CREATE TRIGGER "trigger_update_t_help_doc_relation_modified" BEFORE UPDATE ON "public"."t_help_doc_relation"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_help_doc_relation_modified"();

-- ----------------------------
-- Primary Key structure for table t_help_doc_relation
-- ----------------------------
ALTER TABLE "public"."t_help_doc_relation" ADD CONSTRAINT "t_help_doc_relation_pkey" PRIMARY KEY ("relation_id", "help_doc_id");

-- ----------------------------
-- Indexes structure for table t_help_doc_view_record
-- ----------------------------
CREATE UNIQUE INDEX "uk_notice_employee" ON "public"."t_help_doc_view_record" USING btree (
  "help_doc_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
COMMENT ON INDEX "public"."uk_notice_employee" IS '资讯员工';

-- ----------------------------
-- Triggers structure for table t_help_doc_view_record
-- ----------------------------
CREATE TRIGGER "trigger_update_t_help_doc_view_record_modified" BEFORE UPDATE ON "public"."t_help_doc_view_record"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_help_doc_view_record_modified"();

-- ----------------------------
-- Primary Key structure for table t_help_doc_view_record
-- ----------------------------
ALTER TABLE "public"."t_help_doc_view_record" ADD CONSTRAINT "t_help_doc_view_record_pkey" PRIMARY KEY ("help_doc_id", "user_id");

-- ----------------------------
-- Indexes structure for table t_login_fail
-- ----------------------------
CREATE UNIQUE INDEX "uid_and_utype" ON "public"."t_login_fail" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "user_type" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_login_fail
-- ----------------------------
CREATE TRIGGER "trigger_update_t_login_fail_modified" BEFORE UPDATE ON "public"."t_login_fail"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_login_fail_modified"();

-- ----------------------------
-- Primary Key structure for table t_login_fail
-- ----------------------------
ALTER TABLE "public"."t_login_fail" ADD CONSTRAINT "t_login_fail_pkey" PRIMARY KEY ("login_fail_id");

-- ----------------------------
-- Indexes structure for table t_login_log
-- ----------------------------
CREATE INDEX "customer_id" ON "public"."t_login_log" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_login_log
-- ----------------------------
CREATE TRIGGER "trigger_update_t_login_log_modified" BEFORE UPDATE ON "public"."t_login_log"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_login_log_modified"();

-- ----------------------------
-- Primary Key structure for table t_login_log
-- ----------------------------
ALTER TABLE "public"."t_login_log" ADD CONSTRAINT "t_login_log_pkey" PRIMARY KEY ("login_log_id");

-- ----------------------------
-- Indexes structure for table t_mail_template
-- ----------------------------
CREATE UNIQUE INDEX "template_code" ON "public"."t_mail_template" USING btree (
  "template_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_mail_template
-- ----------------------------
CREATE TRIGGER "trigger_update_t_mail_template_modified" BEFORE UPDATE ON "public"."t_mail_template"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_mail_template_modified"();

-- ----------------------------
-- Primary Key structure for table t_mail_template
-- ----------------------------
ALTER TABLE "public"."t_mail_template" ADD CONSTRAINT "t_mail_template_pkey" PRIMARY KEY ("template_code");

-- ----------------------------
-- Triggers structure for table t_menu
-- ----------------------------
CREATE TRIGGER "trigger_update_t_menu_modified" BEFORE UPDATE ON "public"."t_menu"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_menu_modified"();

-- ----------------------------
-- Primary Key structure for table t_menu
-- ----------------------------
ALTER TABLE "public"."t_menu" ADD CONSTRAINT "t_menu_pkey" PRIMARY KEY ("menu_id");

-- ----------------------------
-- Indexes structure for table t_message
-- ----------------------------
CREATE INDEX "idx_msg" ON "public"."t_message" USING btree (
  "message_type" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "receiver_user_type" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "receiver_user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_message
-- ----------------------------
CREATE TRIGGER "trigger_update_t_message_modified" BEFORE UPDATE ON "public"."t_message"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_message_modified"();

-- ----------------------------
-- Primary Key structure for table t_message
-- ----------------------------
ALTER TABLE "public"."t_message" ADD CONSTRAINT "t_message_pkey" PRIMARY KEY ("message_id");

-- ----------------------------
-- Triggers structure for table t_notice
-- ----------------------------
CREATE TRIGGER "trigger_update_t_notice_modified" BEFORE UPDATE ON "public"."t_notice"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_notice_modified"();

-- ----------------------------
-- Primary Key structure for table t_notice
-- ----------------------------
ALTER TABLE "public"."t_notice" ADD CONSTRAINT "t_notice_pkey" PRIMARY KEY ("notice_id");

-- ----------------------------
-- Triggers structure for table t_notice_type
-- ----------------------------
CREATE TRIGGER "trigger_update_t_notice_type_modified" BEFORE UPDATE ON "public"."t_notice_type"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_notice_type_modified"();

-- ----------------------------
-- Primary Key structure for table t_notice_type
-- ----------------------------
ALTER TABLE "public"."t_notice_type" ADD CONSTRAINT "t_notice_type_pkey" PRIMARY KEY ("notice_type_id");

-- ----------------------------
-- Triggers structure for table t_notice_view_record
-- ----------------------------
CREATE TRIGGER "trigger_update_t_notice_view_record_modified" BEFORE UPDATE ON "public"."t_notice_view_record"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_notice_view_record_modified"();

-- ----------------------------
-- Triggers structure for table t_oa_bank
-- ----------------------------
CREATE TRIGGER "trigger_update_t_oa_bank_modified" BEFORE UPDATE ON "public"."t_oa_bank"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_oa_bank_modified"();

-- ----------------------------
-- Triggers structure for table t_oa_enterprise
-- ----------------------------
CREATE TRIGGER "trigger_update_t_oa_enterprise_modified" BEFORE UPDATE ON "public"."t_oa_enterprise"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_oa_enterprise_modified"();

-- ----------------------------
-- Triggers structure for table t_oa_enterprise_employee
-- ----------------------------
CREATE TRIGGER "trigger_update_t_oa_enterprise_employee_modified" BEFORE UPDATE ON "public"."t_oa_enterprise_employee"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_oa_enterprise_employee_modified"();

-- ----------------------------
-- Triggers structure for table t_oa_invoice
-- ----------------------------
CREATE TRIGGER "trigger_update_t_oa_invoice_modified" BEFORE UPDATE ON "public"."t_oa_invoice"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_oa_invoice_modified"();

-- ----------------------------
-- Triggers structure for table t_operate_log
-- ----------------------------
CREATE TRIGGER "trigger_update_t_operate_log_modified" BEFORE UPDATE ON "public"."t_operate_log"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_operate_log_modified"();

-- ----------------------------
-- Triggers structure for table t_password_log
-- ----------------------------
CREATE TRIGGER "trigger_update_t_password_log_modified" BEFORE UPDATE ON "public"."t_password_log"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_password_log_modified"();

-- ----------------------------
-- Triggers structure for table t_position
-- ----------------------------
CREATE TRIGGER "trigger_update_t_position_modified" BEFORE UPDATE ON "public"."t_position"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_position_modified"();

-- ----------------------------
-- Triggers structure for table t_reload_item
-- ----------------------------
CREATE TRIGGER "trigger_update_t_reload_item_modified" BEFORE UPDATE ON "public"."t_reload_item"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_reload_item_modified"();

-- ----------------------------
-- Triggers structure for table t_role
-- ----------------------------
CREATE TRIGGER "trigger_update_t_role_modified" BEFORE UPDATE ON "public"."t_role"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_role_modified"();

-- ----------------------------
-- Triggers structure for table t_role_data_scope
-- ----------------------------
CREATE TRIGGER "trigger_update_t_role_data_scope_modified" BEFORE UPDATE ON "public"."t_role_data_scope"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_role_data_scope_modified"();

-- ----------------------------
-- Triggers structure for table t_role_employee
-- ----------------------------
CREATE TRIGGER "trigger_update_t_role_employee_modified" BEFORE UPDATE ON "public"."t_role_employee"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_role_employee_modified"();

-- ----------------------------
-- Triggers structure for table t_role_menu
-- ----------------------------
CREATE TRIGGER "trigger_update_t_role_menu_modified" BEFORE UPDATE ON "public"."t_role_menu"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_role_menu_modified"();

-- ----------------------------
-- Triggers structure for table t_serial_number
-- ----------------------------
CREATE TRIGGER "trigger_update_t_serial_number_modified" BEFORE UPDATE ON "public"."t_serial_number"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_serial_number_modified"();

-- ----------------------------
-- Triggers structure for table t_serial_number_record
-- ----------------------------
CREATE TRIGGER "trigger_update_t_serial_number_record_modified" BEFORE UPDATE ON "public"."t_serial_number_record"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_serial_number_record_modified"();

-- ----------------------------
-- Triggers structure for table t_smart_job
-- ----------------------------
CREATE TRIGGER "trigger_update_t_smart_job_modified" BEFORE UPDATE ON "public"."t_smart_job"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_smart_job_modified"();

-- ----------------------------
-- Triggers structure for table t_table_column
-- ----------------------------
CREATE TRIGGER "trigger_update_t_table_column_modified" BEFORE UPDATE ON "public"."t_table_column"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_t_table_column_modified"();
