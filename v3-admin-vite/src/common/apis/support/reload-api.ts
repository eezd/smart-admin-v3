import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"
import tag from "element-plus/es/components/tag/index.mjs"

/*
 * reload (内存热加载、钩子等)
 */
export const reloadApi = {
  queryList: () => {
    return request <ApiResponseData<ReloadItem[]>>({
      url: "support/reload/query",
      method: "GET"
    })
  },
  queryResult: (tag: string) => {
    return request <ApiResponseData<ReloadItem[]>>({
      url: `support/reload/result/${tag}`,
      method: "GET"
    })
  },
  /**
   * 执行reload
   */
  execute: (data: ReloadExecuteRequest) => {
    return request <ApiResponseData<any>>({
      url: `support/reload/${tag}`,
      method: "POST",
      data
    })
  }
}

export interface ReloadItem {
  /**
   * 参数
   */
  args?: string
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 运行标识
   */
  identification?: string
  /**
   * 加载项标签
   */
  tag?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface ReloadExecuteRequest {
  /**
   * 参数
   */
  args?: string
  /**
   * 状态标识
   */
  identification: string
  /**
   * 标签
   */
  tag: string
  [property: string]: any
}
