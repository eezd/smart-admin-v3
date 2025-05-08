import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 职务表
 */
export const positionApi = {
  queryPage: (data: PostionQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<PositionItem>>>({
      url: "position/queryPage",
      method: "POST",
      data
    })
  },
  queryList: () => {
    return request<ApiResponseData<PositionItem[]>>({
      url: "position/queryList",
      method: "GET"
    })
  },
  create: (data: PositionCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "position/add",
      method: "POST",
      data
    })
  },
  update: (data: PositionUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "position/update",
      method: "POST",
      data
    })
  },
  delete: (id: number) => {
    return request<ApiResponseData<any>>({
      url: `position/delete/${id}`,
      method: "GET"
    })
  },
  batchDelete: (idList: number[]) => {
    return request<ApiResponseData<any>>({
      url: "position/batchDelete",
      method: "POST",
      data: idList
    })
  }
}

export interface PostionQueryPageRequest {
  /**
   * 关键字查询
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

export interface PositionItem {
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 职级
   */
  level?: string
  /**
   * 职务ID
   */
  positionId?: number
  /**
   * 职务名称
   */
  positionName?: string
  /**
   * 备注
   */
  remark?: string
  /**
   * 排序
   */
  sort?: number
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface PositionCreateRequest {
  /**
   * 职级
   */
  level?: string
  /**
   * 职务名称
   */
  positionName: string
  /**
   * 备注
   */
  remark?: string
  /**
   * 排序
   */
  sort: number
  [property: string]: any
}

export interface PositionUpdateRequest {
  /**
   * 职级
   */
  level?: string
  /**
   * 职务ID
   */
  positionId: number
  /**
   * 职务名称
   */
  positionName: string
  /**
   * 备注
   */
  remark?: string
  /**
   * 排序
   */
  sort: number
  [property: string]: any
}
