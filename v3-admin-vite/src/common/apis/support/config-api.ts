import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 系统参数
 */
export const configApi = {
  queryPage: (data: ConfigQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<ConfigItem>>>({
      url: "support/config/query",
      method: "POST",
      data
    })
  },
  create: (data: ConfigCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/config/add",
      method: "POST",
      data
    })
  },
  update: (data: ConfigUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/config/update",
      method: "POST",
      data
    })
  },
  queryByKey: (param: string) => {
    return request<ApiResponseData<ConfigItem>>({
      url: `support/config/queryByKey?configKey=${param}`,
      method: "GET"
    })
  }
}

export interface ConfigQueryPageRequest {
  /**
   * 参数KEY
   */
  configKey?: string
  /**
   * 页码(不能为空)
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   */
  pageSize: number
  /**
   * 是否查询总条数
   */
  searchCount?: boolean
  /**
   * 排序字段集合
   */
  sortItemList?: SortItemModel[]
  [property: string]: any
}

export interface ConfigItem {
  /**
   * 主键
   */
  configId?: number
  /**
   * 参数key
   */
  configKey?: string
  /**
   * 参数名称
   */
  configName?: string
  /**
   * 参数的值
   */
  configValue?: string
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 备注
   */
  remark?: string
  /**
   * 上次修改时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface ConfigCreateRequest {
  /**
   * 参数key
   */
  configKey: string
  /**
   * 参数名称
   */
  configName: string
  /**
   * 参数的值
   */
  configValue: string
  /**
   * 备注
   */
  remark?: string
  [property: string]: any
}

export interface ConfigUpdateRequest {
  /**
   * configId
   */
  configId: number
  /**
   * 参数key
   */
  configKey: string
  /**
   * 参数名称
   */
  configName: string
  /**
   * 参数的值
   */
  configValue: string
  /**
   * 备注
   */
  remark?: string
  [property: string]: any
}
