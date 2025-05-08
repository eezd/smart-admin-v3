import type { ApiResponseData, PageResultModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 单据序列号
 */
export const serialNumberApi = {
  queryList: () => {
    return request <ApiResponseData<SerialNumberItem[]>>({
      url: "support/serialNumber/all",
      method: "GET"
    })
  },
  queryPage: (data: SerialNumberQueryPageRequest) => {
    return request <ApiResponseData<PageResultModel<SerialNumberItem>>>({
      url: "support/serialNumber/all",
      method: "POST",
      data
    })
  },
  generate: (data: SerialNumberGenerateRequest) => {
    return request <ApiResponseData<string[]>>({
      url: "support/serialNumber/generate",
      method: "POST",
      data
    })
  }
}

export interface SerialNumberItem {
  businessName?: string
  createTime?: Date
  format?: string
  initNumber?: number
  lastNumber?: number
  lastTime?: Date
  remark?: string
  ruleType?: string
  serialNumberId?: number
  stepRandomRange?: number
  updateTime?: Date
  [property: string]: any
}

export interface SerialNumberQueryPageRequest {
  count?: number
  createTime?: Date
  lastNumber?: number
  lastTime?: Date
  recordDate?: Date
  serialNumberId?: number
  updateTime?: Date
  [property: string]: any
}

export interface SerialNumberGenerateRequest {
  /**
   * 生成的数量
   */
  count: number
  /**
   * 单号id
   */
  serialNumberId: number
  [property: string]: any
}
