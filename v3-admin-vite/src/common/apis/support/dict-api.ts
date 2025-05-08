import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 字典
 */
export const dictApi = {
  /** 获取所有字典code */
  getAll: () => {
    return request<ApiResponseData<DictDataItem[]>>({
      url: "support/dict/getAllDict",
      method: "GET"
    })
  },

  /** 获取全部字典数据（前端缓存） */
  getAllData: () => {
    return request<ApiResponseData<DictDataItem[]>>({
      url: "support/dict/getAllDictData",
      method: "GET"
    })
  },

  queryPage: (data: DictQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<DictItem>>>({
      url: "support/dict/queryPage",
      method: "POST",
      data
    })
  },

  create: (data: DictCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/dict/add",
      method: "POST",
      data
    })
  },

  update: (data: DictUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/dict/update",
      method: "POST",
      data
    })
  },

  batchDelete: (idList: number[]) => {
    return request<ApiResponseData<any>>({
      url: "support/dict/batchDelete",
      method: "POST",
      data: idList
    })
  },

  updateDisabled: (id: number) => {
    return request<ApiResponseData<any>>({
      url: `support/dict/updateDisabled/${id}`,
      method: "GET"
    })
  },

  /** 字典数据操作 */
  dictData: {
    queryPage: (dictId: number) => {
      return request<ApiResponseData<PageResultModel<DictDataItem[]>>>({
        url: `support/dict/dictData/queryDictData/${dictId}`,
        method: "GET"
      })
    },

    create: (data: DictDataCreateRequest) => {
      return request<ApiResponseData<any>>({
        url: "support/dict/dictData/add",
        method: "POST",
        data
      })
    },

    update: (data: DictDataUpdateRequest) => {
      return request<ApiResponseData<any>>({
        url: "support/dict/dictData/update",
        method: "POST",
        data
      })
    },

    batchDelete: (idList: number[]) => {
      return request<ApiResponseData<any>>({
        url: "support/dict/dictData/batchDelete",
        method: "POST",
        data: idList
      })
    },

    updateDisabled: (id: number) => {
      return request<ApiResponseData<any>>({
        url: `support/dict/dictData/updateDisabled/${id}`,
        method: "GET"
      })
    }
  }
}

export interface DictItem {
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 字典编码
   */
  dictCode?: string
  /**
   * 字典id
   */
  dictId?: number
  /**
   * 字典名字
   */
  dictName?: string
  /**
   * 禁用状态
   */
  disabledFlag?: number
  /**
   * 字典备注
   */
  remark?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface DictDataItem {
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 字典项显示名称
   */
  dataLabel?: string
  /**
   * 字典项值
   */
  dataValue?: string
  /**
   * 字典编码
   */
  dictCode?: string
  /**
   * 字典数据id
   */
  dictDataId?: number
  /**
   * 字典id
   */
  dictId?: number
  /**
   * 禁用状态
   */
  disabledFlag?: boolean
  /**
   * 备注
   */
  remark?: string
  /**
   * 排序（越大越靠前）
   */
  sortOrder?: number
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface DictQueryPageRequest {
  /**
   * 禁用状态
   */
  disabledFlag?: boolean
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
  [property: string]: any
}

export interface DictCreateRequest {
  /**
   * 字典编码
   */
  dictCode: string
  /**
   * 字典名字
   */
  dictName: string
  /**
   * 字典备注
   */
  remark?: string
  [property: string]: any
}

export interface DictUpdateRequest {
  /**
   * 字典项显示名称
   */
  dataLabel: string
  /**
   * 字典项值
   */
  dataValue: string
  /**
   * 字典数据编码
   */
  dictCode: string
  /**
   * 字典数据id
   */
  dictDataId: number
  /**
   * 字典id
   */
  dictId: number
  /**
   * 备注
   */
  remark?: string
  /**
   * 排序（越大越靠前）
   */
  sortOrder: number
  [property: string]: any
}

export interface DictDataCreateRequest {
  /**
   * 字典项显示名称
   */
  dataLabel: string
  /**
   * 字典项值
   */
  dataValue: string
  /**
   * 字典id
   */
  dictId: number
  /**
   * 备注
   */
  remark?: string
  /**
   * 排序（越大越靠前）
   */
  sortOrder: number
  [property: string]: any
}

export interface DictDataUpdateRequest {
  /**
   * 字典项显示名称
   */
  dataLabel: string
  /**
   * 字典项值
   */
  dataValue: string
  /**
   * 字典数据编码
   */
  dictCode: string
  /**
   * 字典数据id
   */
  dictDataId: number
  /**
   * 字典id
   */
  dictId: number
  /**
   * 备注
   */
  remark?: string
  /**
   * 排序（越大越靠前）
   */
  sortOrder: number
  [property: string]: any
}
