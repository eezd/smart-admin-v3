import type { DictDataItem } from "@/common/apis/support/dict-api"
import { DICT_SPLIT } from "@/common/constants/support/dict-const"
import { pinia } from "@/pinia"
import { groupBy } from "lodash-es"

export const useDictStore = defineStore("dict", () => {
  // 使用更明确的泛型类型
  const dictMap = ref<Map<string, DictDataItem[]>>(new Map())

  // 获取字典数据
  const getDictData = (dictCode: string): DictDataItem[] => {
    if (!dictCode) return []
    return dictMap.value.get(dictCode) || []
  }

  // 获取字典值标签
  const getDataLabels = (dictCode: string, dataValue: string): string => {
    if (!dataValue) return ""
    const dict = getDictData(dictCode)
    if (dict.length === 0) return ""

    return dataValue.split(DICT_SPLIT)
      .map(item => dict.find(d => d.dataValue === item)?.dataLabel || "")
      .join(DICT_SPLIT)
  }

  // 初始化字典数据
  const initData = (dictDataList: DictDataItem[]) => {
    dictMap.value.clear()
    const grouped = groupBy(dictDataList, "dictCode")

    Object.entries(grouped).forEach(([code, items]) => {
      dictMap.value.set(code, items)
    })
  }

  return {
    dictMap,
    getDictData,
    getDataLabels,
    initData
  }
})

/**
 * @description 在 SPA 应用中可用于在 pinia 实例被激活前使用 store
 * @description 在 SSR 应用中可用于在 setup 外使用 store
 */
export function useDictStoreOutside() {
  return useDictStore(pinia)
}
