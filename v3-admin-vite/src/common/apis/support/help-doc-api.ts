import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 帮助文档
 */
export const helpDocApi = {
  /**
   * 【管理】帮助文档-分页查询
   */
  queryPage: (data: HelpDocQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<HelpDocItem>>>({
      url: "support/helpDoc/query",
      method: "POST",
      data
    })
  },
  /**
   * 【管理】帮助文档-添加
   */
  create: (data: HelpDocCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/helpDoc/add",
      method: "POST",
      data
    })
  },
  /**
   * 【管理】帮助文档-更新
   */
  update: (data: HelpDocUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/helpDoc/update",
      method: "POST",
      data
    })
  },
  /**
   * 【管理】帮助文档-删除
   */
  delete: (helpDocId: number) => {
    return request<ApiResponseData<any>>({
      url: `support/helpDoc/delete/${helpDocId}`,
      method: "GET"
    })
  },
  /**
   * 【管理】帮助文档-获取详情
   */
  getDetail: (helpDocId: number) => {
    return request<ApiResponseData<HelpDocDetailItem>>({
      url: `support/helpDoc/getDetail/${helpDocId}`,
      method: "GET"
    })
  },
  /**
   * 【管理】帮助文档-根据关联id查询
   */
  queryHelpDocByRelationId: (relationId: number) => {
    return request<ApiResponseData<HelpDocItem[]>>({
      url: `support/helpDoc/queryHelpDocByRelationId/${relationId}`,
      method: "GET"
    })
  },
  // ----------------------- 用户相关 --------------------------------
  /**
   * 【用户】帮助文档-查询全部
   */
  getAllHelpDocList: () => {
    return request<ApiResponseData<HelpDocItem[]>>({
      url: "support/helpDoc/user/queryAllHelpDocList",
      method: "GET"
    })
  },
  /**
   * 【用户】帮助文档-查看详情
   */
  view: (helpDocId: number) => {
    return request<ApiResponseData<HelpDocDetailItem>>({
      url: `/support/helpDoc/user/view/${helpDocId}`,
      method: "GET"
    })
  },

  /**
   * 【用户】帮助文档-查询 查看记录
   */
  queryViewRecord: (data: HelpDocViewQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<HelpDocViewItem>>>({
      url: "support/helpDoc/user/queryViewRecord",
      method: "POST",
      data
    })
  }
}

export interface HelpDocQueryPageRequest {
  /**
   * 创建-开始时间
   */
  createTimeBegin?: Date
  /**
   * 创建-截止时间
   */
  createTimeEnd?: Date
  /**
   * 分类
   */
  helpDocCatalogId?: number
  /**
   * 标题
   */
  keywords?: string
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

export interface HelpDocItem {
  /**
   * 作者
   */
  author?: string
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 分类
   */
  helpDocCatalogId?: number
  /**
   * 分类名称
   */
  helpDocCatalogName?: string
  /**
   * id
   */
  helpDocId?: number
  /**
   * 页面浏览量
   */
  pageViewCount?: number
  /**
   * 排序
   */
  sort?: number
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

export interface HelpDocCreateRequest {
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
   * 分类
   */
  helpDocCatalogId: number
  /**
   * 关联的集合
   */
  relationList?: HelpDocRelationForm[]
  /**
   * 排序
   */
  sort: number
  /**
   * 标题
   */
  title: string
  [property: string]: any
}

/**
 * HelpDocRelationForm，关联的集合
 */
export interface HelpDocRelationForm {
  /**
   * 关联id
   */
  relationId: number
  /**
   * 关联名称
   */
  relationName: string
  [property: string]: any
}

export interface HelpDocUpdateRequest {
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
   * 分类
   */
  helpDocCatalogId: number
  /**
   * id
   */
  helpDocId: number
  /**
   * 关联的集合
   */
  relationList?: HelpDocRelationForm[]
  /**
   * 排序
   */
  sort: number
  /**
   * 标题
   */
  title: string
  [property: string]: any
}

export interface HelpDocDetailItem {
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
   * 分类
   */
  helpDocCatalogId?: number
  /**
   * 分类名称
   */
  helpDocCatalogName?: number
  /**
   * id
   */
  helpDocId?: number
  /**
   * 页面浏览量
   */
  pageViewCount?: number
  /**
   * 关联项目
   */
  relationList?: HelpDocRelationForm[]
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

export interface HelpDocViewQueryPageRequest {
  /**
   * 帮助文档id
   */
  helpDocId: number
  /**
   * 关键字
   */
  keywords?: string
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
   * 用户id
   */
  userId?: number
  [property: string]: any
}

export interface HelpDocViewItem {
  /**
   * 首次查看时间
   */
  createTime?: Date
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
  /**
   * ID
   */
  userId?: number
  /**
   * 姓名
   */
  userName?: string
  [property: string]: any
}
