import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 定时任务
 */
export const jobApi = {
  queryPage: (data: JobQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<JobItem>>>({
      url: "support/job/query",
      method: "POST",
      data
    })
  },
  queryPageLog: (data: JobLogQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<JobLogItem>>>({
      url: "support/job/log/query",
      method: "POST",
      data
    })
  },
  queryInfo: (jobId: number) => {
    return request<ApiResponseData<PageResultModel<JobItem>>>({
      url: `support/job/${jobId}`,
      method: "GET"
    })
  },
  execute: (data: JobExexuteRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/job/execute",
      method: "POST",
      data
    })
  },
  create: (data: JobCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/job/add",
      method: "POST",
      data
    })
  },
  update: (data: JobUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/job/update",
      method: "POST",
      data
    })
  },
  updateEnabled: (data: JobUpdateEnabledRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/job/update/enabled",
      method: "POST",
      data
    })
  },
  delete: (jobId: number) => {
    return request<ApiResponseData<any>>({
      url: `support/job/delete?jobId=${jobId}`,
      method: "GET"
    })
  }
}

export interface JobQueryPageRequest {
  /**
   * 是否删除|可选
   */
  deletedFlag?: boolean
  /**
   * 是否启用|可选
   */
  enabledFlag?: boolean
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
   * 搜索词|可选
   */
  searchWord?: string
  /**
   * 排序字段集合
   */
  sortItemList?: SortItemModel[]
  /**
   * 触发类型  <br>  export const SMART_JOB_TRIGGER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;CRON:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'cron',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'cron表达式'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FIXED_DELAY:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'fixed_delay',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'固定间隔'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  triggerType?: string
  [property: string]: any
}

export interface JobItem {
  createTime?: Date
  /**
   * 是否启用
   */
  enabledFlag?: boolean
  /**
   * 执行类
   */
  jobClass?: string
  /**
   * 任务id
   */
  jobId?: number
  /**
   * 任务名称
   */
  jobName?: string
  /**
   * 最后一次执行记录id
   */
  lastExecuteLogId?: number
  /**
   * 最后一执行时间
   */
  lastExecuteTime?: Date
  lastJobLog?: SmartJobLogVO
  /**
   * 未来N次任务执行时间
   */
  nextJobExecuteTimeList?: Date[]
  /**
   * 定时任务参数|可选
   */
  param?: string
  /**
   * 备注
   */
  remark?: string
  /**
   * 排序
   */
  sort?: number
  /**
   * 触发类型  <br>  export const SMART_JOB_TRIGGER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;CRON:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'cron',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'cron表达式'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FIXED_DELAY:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'fixed_delay',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'固定间隔'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  triggerType?: string
  /**
   * 触发配置
   */
  triggerValue?: string
  updateName?: string
  updateTime?: Date
  [property: string]: any
}

/**
 * SmartJobLogVO，上次执行记录
 */
export interface SmartJobLogVO {
  createName?: string
  createTime?: Date
  /**
   * 执行结束时间
   */
  executeEndTime?: Date
  /**
   * 执行结果描述
   */
  executeResult?: string
  /**
   * 开始执行时间
   */
  executeStartTime?: Date
  /**
   * 执行时长-毫秒
   */
  executeTimeMillis?: number
  /**
   * ip
   */
  ip?: string
  /**
   * 任务id
   */
  jobId?: number
  /**
   * 任务名称
   */
  jobName?: string
  /**
   * logId
   */
  logId?: number
  /**
   * 定时任务参数|可选
   */
  param?: string
  /**
   * 进程id
   */
  processId?: string
  /**
   * 程序目录
   */
  programPath?: string
  /**
   * 执行结果是否成功
   */
  successFlag?: boolean
  [property: string]: any
}

export interface JobLogQueryPageRequest {
  /**
   * 截止时间|可选
   */
  endTime?: Date
  /**
   * 任务id|可选
   */
  jobId?: number
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
   * 搜索词|可选
   */
  searchWord?: string
  /**
   * 排序字段集合
   */
  sortItemList?: SortItemModel[]
  /**
   * 开始时间|可选
   */
  startTime?: Date
  /**
   * 是否成功|可选
   */
  successFlag?: boolean
  [property: string]: any
}

export interface JobLogItem {
  /**
   * 是否为空
   */
  emptyFlag?: boolean
  /**
   * 结果集
   */
  list?: SmartJobLogVO[]
  /**
   * 当前页
   */
  pageNum?: number
  /**
   * 总页数
   */
  pages?: number
  /**
   * 每页的数量
   */
  pageSize?: number
  /**
   * 总记录数
   */
  total?: number
  [property: string]: any
}

export interface JobExexuteRequest {
  /**
   * 任务id
   */
  jobId: number
  /**
   * 定时任务参数|可选
   */
  param?: string
  [property: string]: any
}

export interface JobCreateRequest {
  /**
   * 是否开启
   */
  enabledFlag: boolean
  /**
   * 任务执行类
   */
  jobClass: string
  /**
   * 任务名称
   */
  jobName: string
  /**
   * 定时任务参数|可选
   */
  param?: string
  /**
   * 备注
   */
  remark?: string
  /**
   * 排序
   */
  sort: number
  /**
   * <font style="color: red;">【必填】</font>触发类型  <br>  export const SMART_JOB_TRIGGER_TYPE_ENUM
   * = <BR>
   * {<br>&nbsp;&nbsp;CRON:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'cron',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'cron表达式'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FIXED_DELAY:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'fixed_delay',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'固定间隔'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  triggerType?: string
  /**
   * 触发配置
   */
  triggerValue: string
  [property: string]: any
}

export interface JobUpdateRequest {
  /**
   * 是否开启
   */
  enabledFlag: boolean
  /**
   * 任务执行类
   */
  jobClass: string
  /**
   * 任务id
   */
  jobId: number
  /**
   * 任务名称
   */
  jobName: string
  /**
   * 定时任务参数|可选
   */
  param?: string
  /**
   * 备注
   */
  remark?: string
  /**
   * 排序
   */
  sort: number
  /**
   * <font style="color: red;">【必填】</font>触发类型  <br>  export const SMART_JOB_TRIGGER_TYPE_ENUM
   * = <BR>
   * {<br>&nbsp;&nbsp;CRON:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'cron',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'cron表达式'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FIXED_DELAY:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'fixed_delay',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'固定间隔'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  triggerType?: string
  /**
   * 触发配置
   */
  triggerValue: string
  [property: string]: any
}

export interface JobUpdateEnabledRequest {
  /**
   * 是否启用
   */
  enabledFlag: boolean
  /**
   * 任务id
   */
  jobId: number
  [property: string]: any
}
