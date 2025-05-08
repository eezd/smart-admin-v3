import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 登录锁定
 */
export const loginFailApi = {
  queryPage: (data: LoginFailQueryPageRequest) => {
    return request <ApiResponseData<PageResultModel<LoginFailItem>>>({
      url: "support/protect/loginFail/queryPage",
      method: "POST",
      data
    })
  },
  batchDelete: (data: number[]) => {
    return request<ApiResponseData<any>>({
      url: "support/protect/loginFail/batchDelete",
      method: "POST",
      data
    })
  }
}

export interface LoginFailQueryPageRequest {
  /**
   * 锁定状态
   */
  lockFlag?: boolean
  /**
   * 登录失败锁定时间
   */
  loginLockBeginTimeBegin?: Date
  /**
   * 登录失败锁定时间
   */
  loginLockBeginTimeEnd?: Date
  /**
   * 登录名
   */
  loginName?: string
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

export interface LoginFailItem {
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 锁定状态:1锁定，0未锁定
   */
  lockFlag?: number
  /**
   * 连续登录失败次数
   */
  loginFailCount?: number
  loginFailId?: number
  /**
   * 连续登录失败锁定开始时间
   */
  loginLockBeginTime?: Date
  /**
   * 登录名
   */
  loginName?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  /**
   * 用户id
   */
  userId?: number
  /**
   * 用户类型
   */
  userType?: number
  [property: string]: any
}
