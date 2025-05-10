/*
 *  权限插件
 *
 * @Author:    1024创新实验室-主任：卓大
 * @Date:      2022-09-06 20:50:46
 * @Wechat:    zhuda1024
 * @Email:     lab1024@163.com
 * @Copyright  1024创新实验室 （ https://1024lab.net ），Since 2012
 */

import type { App } from "vue"
import { useUserStore } from "@/pinia/stores/user"
import { some } from "lodash-es"

function privilege(value: string) {
  // 超级管理员
  if (useUserStore().administratorFlag) {
    return true
  }
  // 获取功能点权限
  const userPointsList = useUserStore().pointsList
  if (!userPointsList) {
    return false
  }
  return some(userPointsList, ["webPerms", value])
}

export function installPrivilege(app: App): void {
  app.config.globalProperties.$privilege = privilege
}
