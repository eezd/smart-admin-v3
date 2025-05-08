import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 数据变动记录
 */
export const dataTracerApi = {
  queryPage: (data: DataTraceQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<DataTracerItem>>>({
      url: "support/dataTracer/query",
      method: "POST",
      data
    })
  }
}

export interface DataTraceQueryPageRequest {
  /**
   * 业务id
   */
  dataId: number
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
   * <br>  export const DATA_TRACER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;GOODS:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'商品'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;OA_NOTICE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'OA-通知公告'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;OA_ENTERPRISE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'OA-企业信息'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  type?: number
  [property: string]: any
}

export interface DataTracerItem {
  /**
   * 操作内容
   */
  content?: string
  /**
   * 操作时间
   */
  createTime?: Date
  /**
   * 单据id
   */
  dataId?: number
  /**
   * 日志id
   */
  dataTracerId?: number
  /**
   * 差异：新的数据
   */
  diffNew?: string
  /**
   * diff 差异：旧的数据
   */
  diffOld?: string
  /**
   * 扩展字段
   */
  extraData?: string
  /**
   * ip
   */
  ip?: string
  /**
   * ip地区
   */
  ipRegion?: string
  /**
   * 业务类型  <br>  export const DATA_TRACER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;GOODS:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'商品'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;OA_NOTICE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'OA-通知公告'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;OA_ENTERPRISE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'OA-企业信息'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  type?: number
  /**
   * userAgent
   */
  userAgent?: string
  /**
   * 操作人
   */
  userId?: number
  /**
   * 操作人名称
   */
  userName?: string
  /**
   * 用户类型  <br>  export const USER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;ADMIN_EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  userType?: number
  [property: string]: any
}
