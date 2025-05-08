import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 登录日志
 */
export const loginLogApi = {
  queryPage: (data: LoginLogQueryPageRequest) => {
    return request <ApiResponseData<PageResultModel<LoginLogItem>>>({
      url: "support/loginLog/page/query",
      method: "POST",
      data
    })
  },
  queryPageMy: (data: LoginLogQueryPageRequest) => {
    return request <ApiResponseData<PageResultModel<LoginLogItem>>>({
      url: "support/loginLog/page/query/login",
      method: "POST",
      data
    })
  }
}

export interface LoginLogQueryPageRequest {
  /**
   * 结束日期
   */
  endDate?: string
  /**
   * ip
   */
  ip?: string
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
  /**
   * 开始日期
   */
  startDate?: string
  /**
   * 用户ID
   */
  userId?: number
  /**
   * 用户名称
   */
  userName?: string
  /**
   * 用户类型
   */
  userType?: number
  [property: string]: any
}

export interface LoginLogItem {
  /**
   * 是否为空
   */
  emptyFlag?: boolean
  /**
   * 结果集
   */
  list?: LoginLogVO[]
  /**
   * 当前页
   */
  pageNum?: number
  /**
   * 总页数
   */
  pages?: number
  /**
   * 每页的数量
   */
  pageSize?: number
  /**
   * 总记录数
   */
  total?: number
  [property: string]: any
}

/**
 * LoginLogVO，结果集
 */
export interface LoginLogVO {
  createTime?: Date
  loginDevice?: string
  /**
   * 登录ip
   */
  loginIp?: string
  /**
   * 登录ip地区
   */
  loginIpRegion?: string
  loginLogId?: number
  /**
   * <br>  export const LOGIN_LOG_RESULT_ENUM = <BR>
   * {<br>&nbsp;&nbsp;LOGIN_SUCCESS:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:0,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'登录成功'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;LOGIN_FAIL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'登录失败'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;LOGIN_OUT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'退出登录'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  loginResult?: number
  /**
   * remark
   */
  remark?: string
  /**
   * user-agent
   */
  userAgent?: string
  /**
   * 用户id
   */
  userId?: number
  /**
   * 用户名
   */
  userName?: string
  /**
   * 用户类型  <br>  export const USER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;ADMIN_EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  userType?: number
  [property: string]: any
}
