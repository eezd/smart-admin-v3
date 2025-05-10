import type { SmartEnum, SmartEnumItem, SmartEnumPlugin, SmartEnumWrapper } from "types/smart-enum"
import type { App } from "vue"
import { FLAG_NUMBER_ENUM } from "@/common/constants/common-const"
import { isUndefined } from "lodash-es"

/*
 * 枚举插件
 * 此插件为 1024创新实验室 自创的插件
 *
 * @Author:    1024创新实验室-主任：卓大
 * @Date:      2022-09-06 20:51:03
 * @Wechat:    zhuda1024
 * @Email:     lab1024@163.com
 * @Copyright  1024创新实验室 （ https://1024lab.net ），Since 2012
 */
export function installSmartEnum<T>(app: App, smartEnumWrapper: SmartEnumWrapper<T>): void {
  const smartEnumPlugin = {} as SmartEnumPlugin

  /**
   * 根据枚举值获取描述
   * @param {*} constantName 枚举名
   * @param {*} value          枚举值
   */
  smartEnumPlugin.getDescByValue = function (constantName: string, value: any): string {
    if (!smartEnumWrapper || !Object.prototype.hasOwnProperty.call(smartEnumWrapper, constantName)) {
      console.error(`无法找到变量名称：${constantName}，请检查 /constants/index.js 文件中是否引入此变量！`)
      return ""
    }
    // boolean类型需要做特殊处理
    if (constantName === "FLAG_NUMBER_ENUM" && !isUndefined(value) && typeof value === "boolean") {
      value = value ? FLAG_NUMBER_ENUM.TRUE.value : FLAG_NUMBER_ENUM.FALSE.value
    }

    const smartEnum: SmartEnum<string> | SmartEnum<number> = smartEnumWrapper[constantName]
    for (const item in smartEnum) {
      if (smartEnum[item].value === value) {
        return smartEnum[item].desc
      }
    }
    return ""
  }

  /**
   * 根据枚举名获取对应的描述键值对[{value:desc}]
   * @param {*} constantName 枚举名
   */
  smartEnumPlugin.getValueDescList = function<T>(constantName: string): SmartEnumItem<T>[] {
    if (!Object.prototype.hasOwnProperty.call(smartEnumWrapper, constantName)) {
      console.error(`无法找到变量名称：${constantName}，请检查 /constants/index.js 文件中是否引入此变量！`)
      return []
    }
    const result: SmartEnumItem<T>[] = []
    const targetSmartEnum = smartEnumWrapper[constantName]
    for (const item in targetSmartEnum) {
      result.push(targetSmartEnum[item] as any)
    }
    return result
  }

  /**
   * 根据枚举名获取对应的value描述键值对{value:desc}
   * @param {*} constantName 枚举名
   */
  smartEnumPlugin.getValueDesc = function (constantName: string): { [key: string]: string } {
    if (!Object.prototype.hasOwnProperty.call(smartEnumWrapper, constantName)) {
      console.error(`无法找到变量名称：${constantName}，请检查 /constants/index.js 文件中是否引入此变量！`)
      return {}
    }
    const smartEnum = smartEnumWrapper[constantName]
    const result = {} as { [key: string]: string }
    for (const item in smartEnum) {
      const key: string = `${smartEnum[item].value}`
      result[key] = smartEnum[item].desc
    }
    return result
  }

  app.config.globalProperties.$smartEnumPlugin = smartEnumPlugin
  app.provide("smartEnumPlugin", smartEnumPlugin)
}
