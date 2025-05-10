/*
 * 字典插件
 * 此插件为 1024创新实验室 自创的插件
 *
 * @Author:    1024创新实验室-主任：卓大
 * @Date:      2024-09-06 20:51:03
 * @Wechat:    zhuda1024
 * @Email:     lab1024@163.com
 * @Copyright  1024创新实验室 （ https://1024lab.net ），Since 2012
 */

import type { App } from "vue"
import { useDictStore } from "@/pinia/stores/dict"

export function installDictPlugin(app: App): void {
  const dictPlugin = {} as any

  /**
   * 根据枚举值获取描述
   * @param {*} dictCode   字典编码
   * @param {*} value     值
   */
  dictPlugin.getDataLabels = function (dictCode: string, value: string) {
    return useDictStore().getDataLabels(dictCode, value)
  }

  app.config.globalProperties.$dictPlugin = dictPlugin
  app.provide("dictPlugin", dictPlugin)
}
