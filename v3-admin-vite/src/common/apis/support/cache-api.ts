import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/**
 * 缓存
 */
export const cacheApi = {
  /** 获取所有缓存 */
  queryNames: () => {
    return request<ApiResponseData<string[]>>({
      url: "support/cache/names",
      method: "GET"
    })
  },
  /** 获取某个缓存的所有key */
  queryKeys: (cacheName: string) => {
    return request<ApiResponseData<string[]>>({
      url: `support/cache/keys/${cacheName}`,
      method: "GET"
    })
  },
  /** 移除某个缓存 */
  remove: (cacheName: string) => {
    return request<ApiResponseData<any>>({
      url: `support/cache/remove/${cacheName}`,
      method: "GET"
    })
  }
}
