import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 意见反馈
 */
export const feedbackApi = {
  queryPage: (data: FeedbackQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<FeedbackItem>>>({
      url: "support/feedback/query",
      method: "POST",
      data
    })
  },
  create: (data: FeedbackCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/feedback/add",
      method: "POST",
      data
    })
  }
}

export interface FeedbackQueryPageRequest {
  /**
   * 截止时间
   */
  endDate?: Date
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
   * 搜索词
   */
  searchWord?: string
  /**
   * 排序字段集合
   */
  sortItemList?: SortItemModel[]
  /**
   * 开始时间
   */
  startDate?: Date
  [property: string]: any
}

export interface FeedbackItem {
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 反馈图片
   */
  feedbackAttachment?: string
  /**
   * 反馈内容
   */
  feedbackContent?: string
  /**
   * 主键
   */
  feedbackId?: number
  /**
   * 更新时间
   */
  updateTime?: Date
  /**
   * 创建人id
   */
  userId?: number
  /**
   * 创建人姓名
   */
  userName?: string
  /**
   * 创建人类型  <br>  export const USER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;ADMIN_EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  userType?: number
  [property: string]: any
}

export interface FeedbackCreateRequest {
  /**
   * 反馈图片
   */
  feedbackAttachment?: string
  /**
   * 反馈内容
   */
  feedbackContent: string
  [property: string]: any
}
