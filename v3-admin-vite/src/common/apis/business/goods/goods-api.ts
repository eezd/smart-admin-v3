import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { handleDownloadData, handleDownloadError, request } from "@/http/axios"

/*
 * 商品管理
 */
export const goodsApi = {
  /*
   * 添加商品
   */
  create: (param: GoodsCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "goods/add",
      method: "POST",
      data: param
    })
  },

  /*
   * 删除商品
   */
  delete: (goodsId: number) => {
    return request<ApiResponseData<any>>({
      url: `goods/delete/${goodsId}`,
      method: "GET"
    })
  },

  /*
   * 批量删除商品
   */
  batchDelete: (goodsIdList: number[]) => {
    return request<ApiResponseData<any>>({
      url: "goods/batchDelete",
      method: "POST",
      data: goodsIdList
    })
  },

  /*
   * 更新商品
   */
  update: (param: GoodsUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "goods/update",
      method: "POST",
      data: param
    })
  },

  /*
   * 分页查询商品
   */
  queryPage: (param: GoodsQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<GoodsItem>>>({
      url: "goods/query",
      method: "POST",
      data: param
    })
  },

  /*
   * 导入商品
   */
  import: (file: FormData) => {
    return request<ApiResponseData<any>>({
      url: "goods/importGoods",
      method: "POST",
      data: file,
      headers: {
        "Content-Type": "multipart/form-data"
      }
    })
  },

  /*
   * 导出商品
   */
  export: () => {
    return request<any>({
      url: "goods/exportGoods",
      method: "GET",
      responseType: "blob"
    }).then((data) => {
      handleDownloadData(data)
    }).catch((error) => {
      handleDownloadError(error)
    })
  }

}

export interface GoodsCreateRequest {
  /**
   * 商品分类
   */
  categoryId: number
  /**
   * 商品名称
   */
  goodsName: string
  /**
   * <font style="color: red;">【必填】</font>  <br>  export const GOODS_STATUS_ENUM = <BR>
   * {<br>&nbsp;&nbsp;APPOINTMENT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'预约中'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;SELL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'售卖中'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;SELL_OUT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'售罄'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  goodsStatus?: number
  /**
   * 产地
   */
  place: string
  /**
   * 商品价格
   */
  price: number
  /**
   * 备注|可选
   */
  remark?: string
  /**
   * 上架状态
   */
  shelvesFlag: boolean
  [property: string]: any
}

export interface GoodsUpdateRequest {
  /**
   * 商品分类
   */
  categoryId: number
  /**
   * 商品id
   */
  goodsId: number
  /**
   * 商品名称
   */
  goodsName: string
  /**
   * <font style="color: red;">【必填】</font>  <br>  export const GOODS_STATUS_ENUM = <BR>
   * {<br>&nbsp;&nbsp;APPOINTMENT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'预约中'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;SELL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'售卖中'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;SELL_OUT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'售罄'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  goodsStatus?: number
  /**
   * 产地
   */
  place: string
  /**
   * 商品价格
   */
  price: number
  /**
   * 备注|可选
   */
  remark?: string
  /**
   * 上架状态
   */
  shelvesFlag: boolean
  [property: string]: any
}

export interface GoodsQueryPageRequest {
  /**
   * 商品分类
   */
  categoryId?: number
  /**
   * <br>  export const GOODS_STATUS_ENUM = <BR>
   * {<br>&nbsp;&nbsp;APPOINTMENT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'预约中'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;SELL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'售卖中'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;SELL_OUT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'售罄'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  goodsStatus?: number
  /**
   * 页码(不能为空)
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   */
  pageSize: number
  /**
   * 产地
   */
  place?: string
  /**
   * 是否查询总条数
   */
  searchCount?: boolean
  /**
   * 搜索词
   */
  searchWord?: string
  /**
   * 上架状态
   */
  shelvesFlag?: boolean
  /**
   * 排序字段集合
   */
  sortItemList?: SortItemModel[]
  [property: string]: any
}

export interface GoodsItem {
  /**
   * 商品分类
   */
  categoryId?: number
  /**
   * 商品分类
   */
  categoryName?: string
  createTime?: Date
  /**
   * 商品id
   */
  goodsId?: number
  /**
   * 商品名称
   */
  goodsName?: string
  /**
   * <br>  export const GOODS_STATUS_ENUM = <BR>
   * {<br>&nbsp;&nbsp;APPOINTMENT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'预约中'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;SELL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'售卖中'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;SELL_OUT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'售罄'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  goodsStatus?: number
  /**
   * 产地
   */
  place?: string
  /**
   * 商品价格
   */
  price?: number
  /**
   * 备注|可选
   */
  remark?: string
  /**
   * 上架状态
   */
  shelvesFlag?: boolean
  updateTime?: Date
  [property: string]: any
}
