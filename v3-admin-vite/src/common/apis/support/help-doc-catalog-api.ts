import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/*
 * 帮助文档 目录
 */
export const helpDocCatalogApi = {
  query: () => {
    return request<ApiResponseData<HelpDocCatalogItem>>({
      url: "support/helpDoc/helpDocCatalog/getAll",
      method: "GET"
    })
  },
  create: (data: HelpDocCatalogCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/helpDoc/helpDocCatalog/add",
      method: "POST",
      data
    })
  },
  update: (data: HelpDocCatalogUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/helpDoc/helpDocCatalog/update",
      method: "POST",
      data
    })
  },
  delete: (helpDocCatalogId: number) => {
    return request<ApiResponseData<any>>({
      url: `support/helpDoc/helpDocCatalog/delete/${helpDocCatalogId}`,
      method: "GET"
    })
  }
}

export interface HelpDocCatalogItem {
  /**
   * 帮助文档目录id
   */
  helpDocCatalogId?: number
  /**
   * 帮助文档目录-名称
   */
  name?: string
  /**
   * 帮助文档目录-父级id
   */
  parentId?: number
  /**
   * 帮助文档目录-排序
   */
  sort?: number
  [property: string]: any
}

export interface HelpDocCatalogCreateRequest {
  /**
   * 名称
   */
  name: string
  /**
   * 父级
   */
  parentId?: number
  /**
   * 排序
   */
  sort?: number
  [property: string]: any
}

export interface HelpDocCatalogUpdateRequest {
  /**
   * id
   */
  helpDocCatalogId: number
  /**
   * 名称
   */
  name: string
  /**
   * 父级
   */
  parentId?: number
  /**
   * 排序
   */
  sort?: number
  [property: string]: any
}
