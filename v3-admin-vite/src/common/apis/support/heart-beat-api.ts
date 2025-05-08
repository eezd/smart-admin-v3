import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 服务心跳
 */
export const heartBeatApi = {
  queryPage: (data: HeartBeatQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<HeartBeatItem>>>({
      url: "support/heartBeat/query",
      method: "POST",
      data
    })
  }
}

export interface HeartBeatQueryPageRequest {
  /**
   * 结束日期
   */
  endDate?: Date
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
   * 开始日期
   */
  startDate?: Date
  [property: string]: any
}

export interface HeartBeatItem {
  heartBeatRecordId?: number
  /**
   * 心跳当前时间
   */
  heartBeatTime?: Date
  /**
   * 进程号
   */
  processNo?: number
  /**
   * 进程开启时间
   */
  processStartTime?: Date
  /**
   * 项目路径
   */
  projectPath?: string
  /**
   * 服务器ip
   */
  serverIp?: string
  [property: string]: any
}
