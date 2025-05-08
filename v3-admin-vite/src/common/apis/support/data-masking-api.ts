import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/**
 *  数据脱敏
 */
export const dataMaskingApi = {
  query: () => {
    return request<ApiResponseData<{
      address?: string
      bankCard?: string
      carLicense?: string
      email?: string
      idCard?: string
      other?: string
      password?: string
      phone?: string
      userId?: number
      [property: string]: any
    }>>({
      url: "support/dataMasking/demo/query",
      method: "GET"
    })
  }
}
