/*
 * 菜单类型
 *
 * @Author:    1024创新实验室-主任：卓大
 * @Date:      2022-09-06 19:57:04
 * @Wechat:    zhuda1024
 * @Email:     lab1024@163.com
 * @Copyright  1024创新实验室 （ https://1024lab.net ），Since 2012
 */

import type { SmartEnum } from "types/smart-enum"

export const MENU_TYPE_ENUM: SmartEnum<number> = {
  CATALOG: {
    value: 1,
    desc: "目录"
  },
  MENU: {
    value: 2,
    desc: "菜单"
  },
  POINTS: {
    value: 3,
    desc: "功能点"
  }
}

/**
 * 权限类型
 */
export const MENU_PERMS_TYPE_ENUM: SmartEnum<number> = {
  SA_TOKEN: {
    value: 1,
    desc: "Sa-Token模式"
  }
}

/**
 * 默认的顶级菜单id为0
 */
export const MENU_DEFAULT_PARENT_ID = 0

export default {
  MENU_TYPE_ENUM,
  MENU_PERMS_TYPE_ENUM
}
