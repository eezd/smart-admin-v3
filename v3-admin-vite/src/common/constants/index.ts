/*
 * 所有常量入口
 *
 * @Author:    1024创新实验室-主任：卓大
 * @Date:      2022-09-06 19:58:28
 * @Wechat:    zhuda1024
 * @Email:     lab1024@163.com
 * @Copyright  1024创新实验室 （ https://1024lab.net ），Since 2012
 */
import category from "./business/erp/category-const"
import goods from "./business/erp/goods-const"
import message from "./business/message/message-const"
import enterprise from "./business/oa/enterprise-const"
import notice from "./business/oa/notice-const"
import { FLAG_NUMBER_ENUM, GENDER_ENUM, USER_TYPE_ENUM } from "./common-const"
import { LAYOUT_ENUM } from "./layout-const"
import changeLogConst from "./support/change-log-const"
import codeGeneratorConst from "./support/code-generator-const"
import file from "./support/file-const"
import jobConst from "./support/job-const"
import loginLog from "./support/login-log-const"
import { LOGIN_DEVICE_ENUM } from "./system/login-device-const"
import menu from "./system/menu-const"

export default {
  FLAG_NUMBER_ENUM,
  LOGIN_DEVICE_ENUM,
  GENDER_ENUM,
  USER_TYPE_ENUM,
  LAYOUT_ENUM,
  ...loginLog,
  ...menu,
  ...goods,
  ...category,
  ...file,
  ...notice,
  ...enterprise,
  ...message,
  ...codeGeneratorConst,
  ...changeLogConst,
  ...jobConst
}
