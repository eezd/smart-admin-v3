import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/*
 * 三级等保
 */
export const level3ProtectApi = {
  query: () => {
    return request <ApiResponseData<any>>({
      url: "support/protect/level3protect/getConfig",
      method: "GET"
    })
  },
  update: (data: Level3ProtectUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/protect/level3protect/updateConfig",
      method: "POST",
      data
    })
  }
}

export interface Level3ProtectUpdateRequest {
  /**
   * 文件检测，默认：不开启
   */
  fileDetectFlag: boolean
  /**
   * 最低活跃时间（单位：分钟）
   */
  loginActiveTimeoutMinutes: number
  /**
   * 连续登录失败锁定时间（单位：分钟）
   */
  loginFailLockMinutes: number
  /**
   * 连续登录失败次数则锁定
   */
  loginFailMaxTimes: number
  /**
   * 文件大小限制，单位 mb ，(默认：50 mb)
   */
  maxUploadFileSizeMb: number
  /**
   * 密码复杂度 是否开启，默认：开启
   */
  passwordComplexityEnabled: boolean
  /**
   * 定期修改密码时间间隔（默认：月）
   */
  regularChangePasswordMonths: number
  /**
   * 定期修改密码不允许重复次数，默认：3次以内密码不能相同（默认：次）
   */
  regularChangePasswordNotAllowRepeatTimes: number
  /**
   * 开启双因子登录
   */
  twoFactorLoginEnabled: boolean
  [property: string]: any
}
