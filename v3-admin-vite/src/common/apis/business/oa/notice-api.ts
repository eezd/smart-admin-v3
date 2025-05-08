import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 通知公告管理
 */
export const noticeApi = {
  queryPage: (data: NoticeQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<NoticeItem>>>({
      url: "oa/notice/query",
      method: "POST",
      data
    })
  },

  create: (data: NoticeCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "oa/notice/add",
      method: "POST",
      data
    })
  },

  update: (data: NoticeUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "oa/notice/update",
      method: "POST",
      data
    })
  },

  delete: (noticeId: number) => {
    return request<ApiResponseData<any>>({
      url: `oa/notice/delete/${noticeId}`,
      method: "GET"
    })
  },

  /**
   * 更新详情
   */
  getUpdateNoticeInfo: (noticeId: number) => {
    return request<ApiResponseData<NoticeUpdateVO>>({
      url: `oa/notice/getUpdateVO/${noticeId}`,
      method: "GET"
    })
  }
}

/*
 * 通知公告类型
 */
export const noticTypeApi = {
  create: (name: string) => {
    return request<ApiResponseData<number>>({
      url: `oa/noticeType/add/${encodeURIComponent(name)}`,
      method: "GET"
    })
  },

  delete: (noticeTypeId: number) => {
    return request<ApiResponseData<void>>({
      url: `oa/noticeType/delete/${noticeTypeId}`,
      method: "GET"
    })
  },

  update: (noticeTypeId: number, name: string) => {
    return request<ApiResponseData<void>>({
      url: `oa/noticeType/update/${noticeTypeId}/${encodeURIComponent(name)}`,
      method: "GET"
    })
  },

  queryList: () => {
    return request<ApiResponseData<NoticeTypeItem[]>>({
      url: "oa/noticeType/getAll",
      method: "GET"
    })
  }
}

/**
 * 【员工】查看 通知公告
 */
export const noticeEmployeeApi = {
  /**
   * 查看详情
   */
  view: (noticeId: number) => {
    return request<ApiResponseData<NoticeDetailVO>>({
      url: `oa/notice/employee/view/${noticeId}`,
      method: "GET"
    })
  },

  /**
   * 查询所有
   */
  queryPage: (data: EmployeeNoticeQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<NoticeEmployeeItem>>>({
      url: "oa/notice/employee/query",
      method: "POST",
      data
    })
  },

  /**
   * 查询查看记录
   */
  queryViewRecord: (data: ViewRecordQueryRequest) => {
    return request<ApiResponseData<PageResultModel<ViewRecordItem>>>({
      url: "oa/notice/employee/queryViewRecord",
      method: "POST",
      data
    })
  }
}

export interface NoticeQueryPageRequest {
  /**
   * 创建-开始时间
   */
  createTimeBegin?: Date
  /**
   * 创建-截止时间
   */
  createTimeEnd?: Date
  /**
   * 创建人
   */
  createUserName?: string
  /**
   * 删除标识
   */
  deletedFlag?: boolean
  /**
   * 文号
   */
  documentNumber?: string
  /**
   * 标题、作者、来源
   */
  keywords?: string
  /**
   * 分类
   */
  noticeTypeId?: number
  /**
   * 页码(不能为空)
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   */
  pageSize: number
  /**
   * 发布-开始时间
   */
  publishTimeBegin?: Date
  /**
   * 发布-截止时间
   */
  publishTimeEnd?: Date
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

export interface NoticeItem {
  /**
   * 是否全部可见
   */
  allVisibleFlag?: boolean
  /**
   * 作者
   */
  author?: string
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 创建人名称
   */
  createUserName?: string
  /**
   * 删除标识
   */
  deletedFlag?: boolean
  /**
   * 文号
   */
  documentNumber?: string
  /**
   * id
   */
  noticeId?: number
  /**
   * 分类
   */
  noticeTypeId?: number
  /**
   * 分类名称
   */
  noticeTypeName?: string
  /**
   * 页面浏览量
   */
  pageViewCount?: number
  /**
   * 发布状态
   */
  publishFlag?: boolean
  /**
   * 发布时间
   */
  publishTime?: Date
  /**
   * 是否定时发布
   */
  scheduledPublishFlag?: boolean
  /**
   * 来源
   */
  source?: string
  /**
   * 标题
   */
  title?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  /**
   * 用户浏览量
   */
  userViewCount?: number
  [property: string]: any
}

export interface NoticeCreateRequest {
  /**
   * 是否全部可见
   */
  allVisibleFlag: boolean
  /**
   * 附件,多个英文逗号分隔|可选
   */
  attachment?: string
  /**
   * 作者
   */
  author: string
  /**
   * html内容
   */
  contentHtml: string
  /**
   * 纯文本内容
   */
  contentText: string
  /**
   * 文号
   */
  documentNumber?: string
  /**
   * 分类
   */
  noticeTypeId: number
  /**
   * 发布时间
   */
  publishTime: Date
  /**
   * 是否定时发布
   */
  scheduledPublishFlag: boolean
  /**
   * 来源
   */
  source: string
  /**
   * 标题
   */
  title: string
  /**
   * 可见范围设置|可选
   */
  visibleRangeList?: NoticeVisibleRangeForm[]
  [property: string]: any
}

/**
 * NoticeVisibleRangeForm，可见范围设置|可选
 */
export interface NoticeVisibleRangeForm {
  /**
   * 员工/部门id
   */
  dataId: number
  /**
   * <font style="color: red;">【必填】</font>  <br>  export const
   * NOTICE_VISIBLE_RANGE_DATA_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;DEPARTMENT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'部门'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  dataType?: number
  [property: string]: any
}

export interface NoticeUpdateRequest {
  /**
   * 是否全部可见
   */
  allVisibleFlag: boolean
  /**
   * 附件,多个英文逗号分隔|可选
   */
  attachment?: string
  /**
   * 作者
   */
  author: string
  /**
   * html内容
   */
  contentHtml: string
  /**
   * 纯文本内容
   */
  contentText: string
  /**
   * 文号
   */
  documentNumber?: string
  /**
   * id
   */
  noticeId: number
  /**
   * 分类
   */
  noticeTypeId: number
  /**
   * 发布时间
   */
  publishTime: Date
  /**
   * 是否定时发布
   */
  scheduledPublishFlag: boolean
  /**
   * 来源
   */
  source: string
  /**
   * 标题
   */
  title: string
  /**
   * 可见范围设置|可选
   */
  visibleRangeList?: NoticeVisibleRangeForm[]
  [property: string]: any
}

export interface NoticeUpdateVO {
  /**
   * 是否全部可见
   */
  allVisibleFlag?: boolean
  /**
   * 附件
   */
  attachment?: string
  /**
   * 作者
   */
  author?: string
  /**
   * html内容
   */
  contentHtml?: string
  /**
   * 纯文本内容
   */
  contentText?: string
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 创建人名称
   */
  createUserName?: string
  /**
   * 删除标识
   */
  deletedFlag?: boolean
  /**
   * 文号
   */
  documentNumber?: string
  /**
   * id
   */
  noticeId?: number
  /**
   * 分类
   */
  noticeTypeId?: number
  /**
   * 分类名称
   */
  noticeTypeName?: string
  /**
   * 页面浏览量
   */
  pageViewCount?: number
  /**
   * 发布状态
   */
  publishFlag?: boolean
  /**
   * 发布时间
   */
  publishTime?: Date
  /**
   * 是否定时发布
   */
  scheduledPublishFlag?: boolean
  /**
   * 来源
   */
  source?: string
  /**
   * 标题
   */
  title?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  /**
   * 用户浏览量
   */
  userViewCount?: number
  /**
   * 可见范围
   */
  visibleRangeList?: NoticeVisibleRangeVO[]
  [property: string]: any
}

/**
 * NoticeVisibleRangeVO，可见范围
 */
export interface NoticeVisibleRangeVO {
  /**
   * 员工/部门id
   */
  dataId?: number
  /**
   * 员工/部门 名称
   */
  dataName?: string
  /**
   * <br>  export const NOTICE_VISIBLE_RANGE_DATA_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;DEPARTMENT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'部门'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  dataType?: number
  [property: string]: any
}

export interface NoticeTypeItem {
  /**
   * 通知类型id
   */
  noticeTypeId?: number
  /**
   * 通知类型-名称
   */
  noticeTypeName?: string
  [property: string]: any
}

export interface NoticeDetailVO {
  /**
   * 是否全部可见
   */
  allVisibleFlag: boolean
  /**
   * 附件
   */
  attachment?: string
  /**
   * 作者
   */
  author: string
  /**
   * html内容
   */
  contentHtml?: string
  /**
   * 纯文本内容
   */
  contentText?: string
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 创建人名称
   */
  createUserName?: number
  /**
   * 文号
   */
  documentNumber?: string
  /**
   * id
   */
  noticeId?: number
  /**
   * 分类
   */
  noticeTypeId?: number
  /**
   * 分类名称
   */
  noticeTypeName?: number
  /**
   * 页面浏览量
   */
  pageViewCount?: number
  /**
   * 发布时间
   */
  publishTime: Date
  /**
   * 是否定时发布
   */
  scheduledPublishFlag: boolean
  /**
   * 来源
   */
  source: string
  /**
   * 标题
   */
  title?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  /**
   * 用户浏览量
   */
  userViewCount?: number
  [property: string]: any
}

export interface EmployeeNoticeQueryPageRequest {
  /**
   * 标题、作者、来源、文号
   */
  keywords?: string
  /**
   * 分类
   */
  noticeTypeId?: number
  /**
   * 未读标识
   */
  notViewFlag?: boolean
  /**
   * 页码(不能为空)
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   */
  pageSize: number
  /**
   * 发布-开始时间
   */
  publishTimeBegin?: Date
  /**
   * 发布-截止时间
   */
  publishTimeEnd?: Date
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

export interface NoticeEmployeeItem {
  /**
   * 标题、作者、来源、文号
   */
  keywords?: string
  /**
   * 分类
   */
  noticeTypeId?: number
  /**
   * 未读标识
   */
  notViewFlag?: boolean
  /**
   * 页码(不能为空)
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   */
  pageSize: number
  /**
   * 发布-开始时间
   */
  publishTimeBegin?: Date
  /**
   * 发布-截止时间
   */
  publishTimeEnd?: Date
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

export interface ViewRecordQueryRequest {
  /**
   * 部门id
   */
  departmentId?: number
  /**
   * 关键字
   */
  keywords?: string
  /**
   * 通知公告id
   */
  noticeId: number
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

export interface ViewRecordItem {
  /**
   * 首次查看时间
   */
  createTime?: Date
  /**
   * 员工部门名称
   */
  departmentName?: string
  /**
   * 员工ID
   */
  employeeId?: number
  /**
   * 员工姓名
   */
  employeeName?: string
  /**
   * 首次ip
   */
  firstIp?: string
  /**
   * 首次用户设备等标识
   */
  firstUserAgent?: string
  /**
   * 最后一次 ip
   */
  lastIp?: string
  /**
   * 最后一次 用户设备等标识
   */
  lastUserAgent?: string
  /**
   * 查看次数
   */
  pageViewCount?: number
  /**
   * 最后一次查看时间
   */
  updateTime?: Date
  [property: string]: any
}
