import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { handleDownloadData, handleDownloadError, request } from "@/http/axios"

/*
 * 文件服务
 */
export const fileApi = {
  /** 文件上传 */
  uploadFile: (data: { file: File }, folder: string) => {
    return request<ApiResponseData<FileUploadItem>>({
      url: `support/file/upload?folder=${folder}`,
      method: "POST",
      data
    })
  },
  queryPage: (data: FileQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<FileItem>>>({
      url: "support/file/queryPage",
      method: "POST",
      data
    })
  },
  /** 获取文件URL：根据fileKey */
  getUrl: (fileKey: string) => {
    return request<ApiResponseData<any>>({
      url: `support/file/getFileUrl?fileKey=${fileKey}`,
      method: "GET"
    })
  },
  /** 下载文件流（根据fileKey） */
  downLoadFile: (params: { fileKey: string }) => {
    return request<any>({
      url: "support/file/queryPage",
      method: "GET",
      responseType: "blob",
      params
    }).then((data) => {
      handleDownloadData(data)
    }).catch((error) => {
      handleDownloadError(error)
    })
  }
}

export interface FileUploadItem {
  /**
   * 文件id
   */
  fileId?: number
  /**
   * fileKey
   */
  fileKey?: string
  /**
   * 文件名称
   */
  fileName?: string
  /**
   * 文件大小
   */
  fileSize?: number
  /**
   * 文件类型
   */
  fileType?: string
  /**
   * fileUrl
   */
  fileUrl?: string
  [property: string]: any
}

export interface FileQueryPageRequest {
  /**
   * 创建时间
   */
  createTimeBegin?: Date
  /**
   * 创建时间
   */
  createTimeEnd?: Date
  /**
   * 创建人
   */
  creatorName?: string
  /**
   * 文件Key
   */
  fileKey?: string
  /**
   * 文件名词
   */
  fileName?: string
  /**
   * 文件类型
   */
  fileType?: string
  /**
   * 文件夹类型  <br>  export const FILE_FOLDER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;COMMON:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'通用'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;NOTICE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'公告'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;HELP_DOC:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'帮助中心'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FEEDBACK:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'意见反馈'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  folderType?: number
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

export interface FileItem {
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 上传人
   */
  creatorId?: number
  /**
   * 上传人
   */
  creatorName?: string
  /**
   * 创建人类型  <br>  export const USER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;ADMIN_EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  creatorUserType?: number
  /**
   * 主键
   */
  fileId?: number
  /**
   * 文件路径
   */
  fileKey?: string
  /**
   * 文件名称
   */
  fileName?: string
  /**
   * 文件大小
   */
  fileSize?: number
  /**
   * 文件类型
   */
  fileType?: string
  /**
   * 文件展示url
   */
  fileUrl?: string
  /**
   * <br>  export const FILE_FOLDER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;COMMON:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'通用'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;NOTICE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'公告'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;HELP_DOC:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'帮助中心'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FEEDBACK:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'意见反馈'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  folderType?: number
  [property: string]: any
}
