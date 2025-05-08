import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/*
 * 首页
 */
export const departmentApi = {
  queryAmountStatistics: () => {
    return request<ApiResponseData<any>>({
      url: "home/amount/statistics",
      method: "GET"
    })
  },
  queryWaitHandle: () => {
    return request<ApiResponseData<any>>({
      url: "home/wait/handle",
      method: "GET"
    })
  }
}
