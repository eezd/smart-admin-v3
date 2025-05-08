import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 发票信息管理
 */
export const invoiceApi = {
  /*
   * 新建发票信息
   */
  create: (data: InvoiceCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "oa/invoice/create",
      method: "POST",
      data
    })
  },

  /*
   * 删除发票信息
   */
  delete: (invoiceId: number) => {
    return request<ApiResponseData<any>>({
      url: `oa/invoice/delete/${invoiceId}`,
      method: "GET"
    })
  },

  /*
   * 编辑发票信息
   */
  update: (data: InvoiceUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "oa/invoice/update",
      method: "POST",
      data
    })
  },

  /*
   * 查询发票信息详情
   */
  detail: (invoiceId: number) => {
    return request<ApiResponseData<InvoiceItem>>({
      url: `oa/invoice/get/${invoiceId}`,
      method: "GET"
    })
  },

  /*
   * 分页查询发票信息
   */
  queryPage: (data: InvoiceQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<InvoiceItem>>>({
      url: "oa/invoice/page/query",
      method: "POST",
      data
    })
  },

  /*
   * 查询发票列表
   */
  queryList: (enterpriseId: number) => {
    return request<ApiResponseData<InvoiceItem[]>>({
      url: `oa/invoice/query/list/${enterpriseId}`,
      method: "GET"
    })
  }
}

export interface InvoiceCreateRequest {
  /**
   * 银行账户
   */
  accountNumber: string
  /**
   * 开户行
   */
  bankName: string
  /**
   * 启用状态
   */
  disabledFlag: boolean
  /**
   * 企业
   */
  enterpriseId: number
  /**
   * 开票抬头
   */
  invoiceHeads: string
  /**
   * 备注
   */
  remark?: string
  /**
   * 纳税人识别号
   */
  taxpayerIdentificationNumber: string
  [property: string]: any
}

export interface InvoiceUpdateRequest {
  /**
   * 银行账户
   */
  accountNumber: string
  /**
   * 开户行
   */
  bankName: string
  /**
   * 启用状态
   */
  disabledFlag: boolean
  /**
   * 企业
   */
  enterpriseId: number
  /**
   * 开票抬头
   */
  invoiceHeads: string
  /**
   * 发票信息ID
   */
  invoiceId: number
  /**
   * 备注
   */
  remark?: string
  /**
   * 纳税人识别号
   */
  taxpayerIdentificationNumber: string
  [property: string]: any
}

export interface InvoiceItem {
  /**
   * 银行账户
   */
  accountNumber?: string
  /**
   * 开户行
   */
  bankName?: string
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
   * 企业
   */
  enterpriseId?: number
  /**
   * 企业名称
   */
  enterpriseName?: string
  /**
   * 开票抬头
   */
  invoiceHeads?: string
  /**
   * 发票信息ID
   */
  invoiceId?: number
  /**
   * 备注
   */
  remark?: string
  /**
   * 纳税人识别号
   */
  taxpayerIdentificationNumber?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface InvoiceQueryPageRequest {
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
