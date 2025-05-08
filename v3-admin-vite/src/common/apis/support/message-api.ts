import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 通知消息
 */
export const messageApi = {
  queryPageMy: (data: MessageMyQueryPageRequest) => {
    return request <ApiResponseData<PageResultModel<MessageItem>>>({
      url: "support/message/queryMyMessage",
      method: "POST",
      data
    })
  },
  /**
   * 查询未读消息数
   */
  queryUnreadCount: () => {
    return request<ApiResponseData<number>>({
      url: "support/message/getUnreadCount",
      method: "GET"
    })
  },
  /**
   * 标记已读
   */
  updateReadFlag: (messageId: number[]) => {
    return request<ApiResponseData<any>>({
      url: `support/message/read/${messageId}`,
      method: "GET"
    })
  },

  queryPageAdmin: (data: MessageAdminQueryPageRequest) => {
    return request <ApiResponseData<PageResultModel<MessageItem>>>({
      url: "message/query",
      method: "POST",
      data
    })
  },
  create: (data: MessageCreateRequest) => {
    return request <ApiResponseData<any>>({
      url: "message/sendMessages",
      method: "POST",
      data
    })
  },
  delete: (messageId: number) => {
    return request<ApiResponseData<any>>({
      url: `message/delete/${messageId}`,
      method: "GET"
    })
  }
}

export interface MessageMyQueryPageRequest {
  /**
   * 查询结束时间
   */
  endDate?: Date
  /**
   * <br>  export const MESSAGE_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;MAIL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'站内信'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;ORDER:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'订单'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  messageType?: number
  /**
   * 页码(不能为空)
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   */
  pageSize: number
  /**
   * 是否已读
   */
  readFlag?: boolean
  /**
   * 接收人
   */
  receiverUserId?: number
  /**
   * 接收人类型
   */
  receiverUserType?: number
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
   * 查询开始时间
   */
  startDate?: Date
  [property: string]: any
}

export interface MessageItem {
  /**
   * 消息内容
   */
  content?: string
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 相关业务id
   */
  dataId?: string
  messageId?: number
  /**
   * <br>  export const MESSAGE_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;MAIL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'站内信'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;ORDER:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'订单'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  messageType?: number
  /**
   * 是否已读
   */
  readFlag?: boolean
  /**
   * 已读时间
   */
  readTime?: Date
  /**
   * 接收者id
   */
  receiverUserId?: number
  /**
   * <br>  export const USER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;ADMIN_EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  receiverUserType?: number
  /**
   * 消息标题
   */
  title?: string
  [property: string]: any
}

export interface MessageAdminQueryPageRequest {
  /**
   * 查询结束时间
   */
  endDate?: Date
  /**
   * <br>  export const MESSAGE_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;MAIL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'站内信'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;ORDER:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'订单'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  messageType?: number
  /**
   * 页码(不能为空)
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   */
  pageSize: number
  /**
   * 是否已读
   */
  readFlag?: boolean
  /**
   * 接收人
   */
  receiverUserId?: number
  /**
   * 接收人类型
   */
  receiverUserType?: number
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
   * 查询开始时间
   */
  startDate?: Date
  [property: string]: any
}

export interface MessageCreateRequest {
  /**
   * 内容
   */
  content: string
  dataId?: { [key: string]: any }
  /**
   * 消息类型  <br>  export const MESSAGE_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;MAIL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'站内信'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;ORDER:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'订单'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  messageType: number
  /**
   * 接收者id
   */
  receiverUserId: number
  /**
   * 接收者类型  <br>  export const USER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;ADMIN_EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  receiverUserType: number
  /**
   * 标题
   */
  title: string
  [property: string]: any
}
