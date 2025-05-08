import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 操作日志
 */
export const operateLogApi = {
  queryPage: (data: OperateLogQueryPageRequest) => {
    return request <ApiResponseData<PageResultModel<OperateLogItem>>>({
      url: "support/operateLog/page/query",
      method: "POST",
      data
    })
  },
  queryDetail: (id: number) => {
    return request <ApiResponseData<OperateLogItem>>({
      url: `support/operateLog/detail/${id}`,
      method: "GET"
    })
  },
  /**
   * 分页查询当前登录人信息
   */
  queryPageMy: (data: OperateLogQueryPageRequest) => {
    return request <ApiResponseData<PageResultModel<OperateLogItem>>>({
      url: "support/operateLog/page/query/login",
      method: "POST",
      data
    })
  }
}

export interface OperateLogQueryPageRequest {
  /**
   * 结束日期
   */
  endDate?: string
  /**
   * 关键字：模块、操作内容
   */
  keywords?: string
  /**
   * 用户ID
   */
  operateUserId?: number
  /**
   * 用户类型
   */
  operateUserType?: number
  /**
   * 页码(不能为空)
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   */
  pageSize: number
  /**
   * 请求关键字：请求地址、请求方法、请求参数
   */
  requestKeywords?: string
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
   * 请求结果 false失败 true成功
   */
  successFlag?: boolean
  /**
   * 用户名称
   */
  userName?: string
  [property: string]: any
}

export interface OperateLogItem {
  /**
   * 操作内容
   */
  content?: string
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 失败原因
   */
  failReason?: string
  /**
   * 客户ip
   */
  ip?: string
  /**
   * 客户ip地区
   */
  ipRegion?: string
  /**
   * 请求方法
   */
  method?: string
  /**
   * 操作模块
   */
  module?: string
  /**
   * 主键
   */
  operateLogId?: number
  /**
   * 用户id
   */
  operateUserId?: number
  /**
   * 用户名称
   */
  operateUserName?: string
  /**
   * 用户类型  <br>  export const USER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;ADMIN_EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  operateUserType?: number
  /**
   * 请求参数
   */
  param?: string
  /**
   * 请求结果 0失败 1成功
   */
  successFlag?: boolean
  /**
   * 更新时间
   */
  updateTime?: Date
  /**
   * 请求路径
   */
  url?: string
  /**
   * user-agent
   */
  userAgent?: string
  [property: string]: any
}
