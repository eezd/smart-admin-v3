import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 银行信息管理
 */
export const bankApi = {
  /*
   * 新建银行信息
   */
  create: (param: BankCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "oa/bank/create",
      method: "POST",
      data: param
    })
  },

  /*
   * 删除银行信息
   */
  delete: (bankId: number) => {
    return request<ApiResponseData<any>>({
      url: `oa/bank/delete/${bankId}`,
      method: "GET"
    })
  },

  /*
   * 编辑银行信息
   */
  update: (param: BankUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "oa/bank/update",
      method: "POST",
      data: param
    })
  },

  /*
   * 查询银行信息详情
   */
  detail: (bankId: number) => {
    return request<ApiResponseData<BankDetail>>({
      url: `oa/bank/get/${bankId}`,
      method: "GET"
    })
  },

  /*
   * 分页查询银行信息
   */
  queryPage: (param: BankQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<BankItem>>>({
      url: "oa/bank/page/query",
      method: "POST",
      data: param
    })
  },

  /*
   * 根据企业ID查询不分页的银行列表
   */
  queryList: (enterpriseId: number) => {
    return request<ApiResponseData<BankItem[]>>({
      url: `oa/bank/query/list/${enterpriseId}`,
      method: "GET"
    })
  }
}

export interface BankCreateRequest {
  /**
   * 账户名称
   */
  accountName: string
  /**
   * 账号
   */
  accountNumber: string
  /**
   * 开户银行
   */
  bankName: string
  /**
   * 是否对公
   */
  businessFlag: boolean
  /**
   * 禁用状态
   */
  disabledFlag: boolean
  /**
   * 企业
   */
  enterpriseId: number
  /**
   * 备注
   */
  remark?: string
  [property: string]: any
}

export interface BankDetail {
  /**
   * 账户名称
   */
  accountName?: string
  /**
   * 账号
   */
  accountNumber?: string
  /**
   * 银行信息ID
   */
  bankId?: number
  /**
   * 开户银行
   */
  bankName?: string
  /**
   * 是否对公
   */
  businessFlag?: boolean
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 创建人ID
   */
  createUserId?: number
  /**
   * 创建人名称
   */
  createUserName?: string
  /**
   * 禁用状态
   */
  disabledFlag?: boolean
  /**
   * 企业ID
   */
  enterpriseId?: number
  /**
   * 企业名称
   */
  enterpriseName?: string
  /**
   * 备注
   */
  remark?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface BankQueryPageRequest {
  /**
   * 禁用状态
   */
  disabledFlag?: boolean
  /**
   * 结束时间
   */
  endTime?: Date
  /**
   * 企业ID
   */
  enterpriseId?: number
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
   * 开始时间
   */
  startTime?: Date
  [property: string]: any
}

export interface BankItem {
  /**
   * 账户名称
   */
  accountName?: string
  /**
   * 账号
   */
  accountNumber?: string
  /**
   * 银行信息ID
   */
  bankId?: number
  /**
   * 开户银行
   */
  bankName?: string
  /**
   * 是否对公
   */
  businessFlag?: boolean
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 创建人ID
   */
  createUserId?: number
  /**
   * 创建人名称
   */
  createUserName?: string
  /**
   * 禁用状态
   */
  disabledFlag?: boolean
  /**
   * 企业ID
   */
  enterpriseId?: number
  /**
   * 企业名称
   */
  enterpriseName?: string
  /**
   * 备注
   */
  remark?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface BankUpdateRequest {
  /**
   * 账户名称
   */
  accountName: string
  /**
   * 账号
   */
  accountNumber: string
  /**
   * 银行信息ID
   */
  bankId: number
  /**
   * 开户银行
   */
  bankName: string
  /**
   * 是否对公
   */
  businessFlag: boolean
  /**
   * 禁用状态
   */
  disabledFlag: boolean
  /**
   * 企业
   */
  enterpriseId: number
  /**
   * 备注
   */
  remark?: string
  [property: string]: any
}
