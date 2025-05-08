import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/*
 * 表格自定义列
 */
export const tableColumnApi = {
  getColumns: (tableId: number) => {
    return request <ApiResponseData<any>>({
      url: `support/tableColumn/getColumns/${tableId}`,
      method: "GET"
    })
  },
  update: (data: TableColumnUpdateRequest) => {
    return request <ApiResponseData<any>>({
      url: "support/tableColumn/update",
      method: "POST",
      data
    })
  },
  delete: (tableId: number) => {
    return request <ApiResponseData<any>>({
      url: `support/tableColumn/delete/${tableId}`,
      method: "GET"
    })
  }
}

export interface TableColumnUpdateRequest {
  columnList: TableColumnItemForm[]
  tableId: number
  [property: string]: any
}

export interface TableColumnItemForm {
  /**
   * 字段
   */
  columnKey: string
  /**
   * 是否显示
   */
  showFlag: boolean
  /**
   * 排序
   */
  sort: number
  /**
   * 宽度
   */
  width?: number
  [property: string]: any
}
