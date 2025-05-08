import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/*
 * 类目管理
 */
export const categoryApi = {
  /*
   * 添加类目
   */
  create: (data: CategoryCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "category/add",
      method: "POST",
      data
    })
  },

  /*
   * 删除类目
   */
  delete: (categoryId: number) => {
    return request<ApiResponseData<any>>({
      url: `category/delete/${categoryId}`,
      method: "GET"
    })
  },

  /*
   * 更新类目
   */
  update: (data: CategoryUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "category/update",
      method: "POST",
      data
    })
  },

  /*
   * 查询类目层级树
   */
  queryTree: (data: CategoryQueryTreeRequest) => {
    return request<ApiResponseData<CategoryTreeItem[]>>({
      url: "category/tree",
      method: "POST",
      data
    })
  }

}

export interface CategoryCreateRequest {
  /**
   * 类目名称
   */
  categoryName: string
  /**
   * <font style="color: red;">【必填】</font>分类类型  <br>  export const CATEGORY_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;GOODS:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'商品'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;CUSTOM:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'自定义'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  categoryType?: number
  /**
   * 禁用状态
   */
  disabledFlag: boolean
  /**
   * 父级类目id|可选
   */
  parentId?: number
  /**
   * 备注|可选
   */
  remark?: string
  /**
   * 排序|可选
   */
  sort?: number
  [property: string]: any
}

export interface CategoryUpdateRequest {
  /**
   * 类目id
   */
  categoryId: number
  /**
   * 类目名称
   */
  categoryName: string
  /**
   * <font style="color: red;">【必填】</font>分类类型  <br>  export const CATEGORY_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;GOODS:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'商品'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;CUSTOM:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'自定义'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  categoryType?: number
  /**
   * 禁用状态
   */
  disabledFlag: boolean
  /**
   * 父级类目id|可选
   */
  parentId?: number
  /**
   * 备注|可选
   */
  remark?: string
  /**
   * 排序|可选
   */
  sort?: number
  [property: string]: any
}

export interface CategoryQueryTreeRequest {
  /**
   * 分类类型|可选  <br>  export const CATEGORY_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;GOODS:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'商品'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;CUSTOM:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'自定义'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  categoryType?: number
  /**
   * 父级类目id|可选
   */
  parentId?: number
  [property: string]: any
}

export interface CategoryTreeItem {
  /**
   * 类目层级全称
   */
  categoryFullName?: string
  /**
   * 类目id
   */
  categoryId?: number
  /**
   * 类目名称
   */
  categoryName?: string
  /**
   * 子类
   */
  children?: CategoryTreeItem[]
  /**
   * 类目名称
   */
  label?: string
  /**
   * 父级id
   */
  parentId?: number
  /**
   * 类目id
   */
  value?: number
  [property: string]: any
}
