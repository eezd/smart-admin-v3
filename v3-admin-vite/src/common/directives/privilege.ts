/*
 * 权限
 *
 * @Author:    1024创新实验室-主任：卓大
 * @Date:      2022-09-06 20:00:40
 * @Wechat:    zhuda1024
 * @Email:     lab1024@163.com
 * @Copyright  1024创新实验室 （ https://1024lab.net ），Since 2012
 */

import { useUserStore } from "@/pinia/stores/user"
import { some } from "lodash-es"

export function privilegeDirective(el: { parentNode: { removeChild: (arg0: any) => void } }, binding: DirectiveBinding<any>) {
  // 超级管理员
  if (useUserStore().administratorFlag) {
    return true
  }
  // 获取功能点权限
  const userPointsList = useUserStore().pointsList
  if (!userPointsList) {
    return false
  }
  // 如果没有权限，删除节点
  if (!some(userPointsList, ["webPerms", binding.value])) {
    el.parentNode.removeChild(el)
  }
  return true
}
