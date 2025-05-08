import type { ApiResponseData } from "types/api"
import { encryptData } from "@/common/utils/encrypt"
import { request } from "@/http/axios"

/**
 * 接口：加密、解密
 */
export const encryptApi = {
  testRequestEncrypt: (data: any) => {
    return request<ApiResponseData<string[]>>({
      url: "support/apiEncrypt/testRequestEncrypt",
      method: "post",
      data: { encryptData: encryptData(data) }
    })
  },

  /**
   * 测试 返回加密
   */
  testResponseEncrypt: (data: any) => {
    return request<ApiResponseData<string[]>>({
      url: "support/apiEncrypt/testResponseEncrypt",
      method: "post",
      data
    })
  },

  /**
   * 测试 请求参数加密和解密、返回数据加密和解密
   */
  testDecryptAndEncrypt: (data: any) => {
    return request<ApiResponseData<string[]>>({
      url: "support/apiEncrypt/testDecryptAndEncrypt",
      method: "post",
      data
    })
  },

  /**
   * 测试 数组加解密
   */
  testArray: (data: any) => {
    return request<ApiResponseData<string[]>>({
      url: "support/apiEncrypt/testArray",
      method: "post",
      data
    })
  }

}
