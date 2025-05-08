import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/**
 * 系统更新日志
 */
export const changeLogApi = {
  queryPage: (data: ChangeLogQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<ChangeLogItem>>>({
      url: "support/changeLog/queryPage",
      method: "POST",
      data
    })
  },
  create: (data: ChangeLogCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/changeLog/add",
      method: "POST",
      data
    })
  },
  update: (data: ChangeLogUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/changeLog/update",
      method: "POST",
      data
    })
  },
  delete: (id: number) => {
    return request<ApiResponseData<any>>({
      url: `support/changeLog/delete/${id}`,
      method: "GET"
    })
  },
  batchDelete: (idList: number[]) => {
    return request<ApiResponseData<any>>({
      url: "support/changeLog/batchDelete",
      method: "POST",
      data: idList
    })
  }
}

export interface ChangeLogQueryPageRequest {
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 关键字
   */
  keyword?: string
  /**
   * 跳转链接
   */
  link?: string
  /**
   * 页码(不能为空)
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   */
  pageSize: number
  /**
   * 发布日期
   */
  publicDateBegin?: Date
  /**
   * 发布日期
   */
  publicDateEnd?: Date
  /**
   * 是否查询总条数
   */
  searchCount?: boolean
  /**
   * 排序字段集合
   */
  sortItemList?: SortItemModel[]
  /**
   * 更新类型:[1:特大版本功能更新;2:功能更新;3:bug修复]  <br>  export const CHANGE_LOG_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;MAJOR_UPDATE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'重大更新'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FUNCTION_UPDATE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'功能更新'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;BUG_FIX:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'Bug修复'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  type?: number
  [property: string]: any
}

export interface ChangeLogItem {
  changeLogId?: number
  /**
   * 更新内容
   */
  content?: string
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 跳转链接
   */
  link?: string
  /**
   * 发布日期
   */
  publicDate?: Date
  /**
   * 发布人
   */
  publishAuthor?: string
  /**
   * 更新类型:[1:特大版本功能更新;2:功能更新;3:bug修复]  <br>  export const CHANGE_LOG_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;MAJOR_UPDATE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'重大更新'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FUNCTION_UPDATE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'功能更新'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;BUG_FIX:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'Bug修复'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  type?: number
  /**
   * 更新时间
   */
  updateTime?: Date
  /**
   * 版本
   */
  version?: string
  [property: string]: any
}

export interface ChangeLogCreateRequest {
  /**
   * 更新内容
   */
  content: string
  /**
   * 跳转链接
   */
  link?: string
  /**
   * 发布日期
   */
  publicDate: Date
  /**
   * 发布人
   */
  publishAuthor: string
  /**
   * <font style="color: red;">【必填】</font>更新类型:[1:特大版本功能更新;2:功能更新;3:bug修复]  <br>  export const
   * CHANGE_LOG_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;MAJOR_UPDATE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'重大更新'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FUNCTION_UPDATE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'功能更新'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;BUG_FIX:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'Bug修复'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  type?: number
  /**
   * 版本
   */
  version: string
  [property: string]: any
}

export interface ChangeLogUpdateRequest {
  /**
   * 更新日志id
   */
  changeLogId: number
  /**
   * 更新内容
   */
  content: string
  /**
   * 跳转链接
   */
  link?: string
  /**
   * 发布日期
   */
  publicDate: Date
  /**
   * 发布人
   */
  publishAuthor: string
  /**
   * <font style="color: red;">【必填】</font>更新类型:[1:特大版本功能更新;2:功能更新;3:bug修复]  <br>  export const
   * CHANGE_LOG_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;MAJOR_UPDATE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'重大更新'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FUNCTION_UPDATE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'功能更新'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;BUG_FIX:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'Bug修复'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  type?: number
  /**
   * 版本
   */
  version: string
  [property: string]: any
}
