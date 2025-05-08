import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { handleDownloadData, handleDownloadError, request } from "@/http/axios"

/*
 * 企业管理
 */
export const enterpriseApi = {
  /*
   * 新建企业
   */
  create: (data: EnterpriseCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "oa/enterprise/create",
      method: "POST",
      data
    })
  },

  /*
   * 删除企业
   */
  delete: (enterpriseId: number) => {
    return request<ApiResponseData<any>>({
      url: `oa/enterprise/delete/${enterpriseId}`,
      method: "GET"
    })
  },

  /*
   * 编辑企业
   */
  update: (data: EnterpriseUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "oa/enterprise/update",
      method: "POST",
      data
    })
  },

  /*
   * 查询企业详情
   */
  detail: (enterpriseId: number) => {
    return request<ApiResponseData<EnterpriseItem>>({
      url: `oa/enterprise/get/${enterpriseId}`,
      method: "GET"
    })
  },

  /*
   * 分页查询企业模块
   */
  queryPage: (data: EnterpriseQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<EnterpriseItem>>>({
      url: "oa/enterprise/page/query",
      method: "POST",
      data
    })
  },

  /*
   * 导出企业数据excel
   */
  exportExcel: (data: EnterpriseExportRequest) => {
    return request<any>({
      url: "oa/enterprise/exportExcel",
      method: "POST",
      data,
      responseType: "blob"
    }).then((data) => {
      handleDownloadData(data)
    }).catch((error) => {
      handleDownloadError(error)
    })
  },

  /*
   * 企业列表查询(含数据范围)
   */
  queryList: (type?: string) => {
    return request<ApiResponseData<{
      /**
       * 企业ID
       */
      enterpriseId?: number
      /**
       * 企业名称
       */
      enterpriseName?: string
      [property: string]: any
    }>>({
      url: type ? `oa/enterprise/query/list?type=${type}` : "oa/enterprise/query/list",
      method: "GET"
    })
  },

  /*
   * 企业全部员工List
   */
  queryListEmployee: (data?: number[]) => {
    return request<ApiResponseData<EnterpriseEmployeeItem[]>>({
      url: "oa/enterprise/employee/list",
      method: "POST",
      data
    })
  },

  /*
   * 分页查询企业员工List
   */
  queryPageEmployee: (data: EnterpriseEmployeeQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<EnterpriseEmployeeItem>>>({
      url: "oa/enterprise/employee/queryPage",
      method: "POST",
      data
    })
  },

  /*
   * 添加员工
   */
  createEmployee: (data: EmployeeCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "oa/enterprise/employee/add",
      method: "POST",
      data
    })
  },

  /*
   * 删除员工
   */
  deleteEmployee: (data: EmployeeDeleteRequest) => {
    return request<ApiResponseData<any>>({
      url: "oa/enterprise/employee/delete",
      method: "POST",
      data
    })
  }
}

export interface EnterpriseCreateRequest {
  /**
   * 详细地址
   */
  address?: string
  /**
   * 营业执照
   */
  businessLicense?: string
  /**
   * 城市
   */
  city?: number
  /**
   * 城市名称
   */
  cityName?: string
  /**
   * 联系人
   */
  contact: string
  /**
   * 联系人电话
   */
  contactPhone: string
  /**
   * 禁用状态
   */
  disabledFlag: boolean
  /**
   * 区县
   */
  district?: number
  /**
   * 区县名称
   */
  districtName?: string
  /**
   * 邮箱
   */
  email?: string
  /**
   * 企业logo
   */
  enterpriseLogo?: string
  /**
   * 企业名称
   */
  enterpriseName: string
  /**
   * 省份
   */
  province?: number
  /**
   * 省份名称
   */
  provinceName?: string
  /**
   * 类型  <br>  export const ENTERPRISE_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;NORMAL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'有限企业'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FOREIGN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'外资企业'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  type?: number
  /**
   * 统一社会信用代码
   */
  unifiedSocialCreditCode: string
  [property: string]: any
}

export interface EnterpriseUpdateRequest {
  /**
   * 详细地址
   */
  address?: string
  /**
   * 营业执照
   */
  businessLicense?: string
  /**
   * 城市
   */
  city?: number
  /**
   * 城市名称
   */
  cityName?: string
  /**
   * 联系人
   */
  contact: string
  /**
   * 联系人电话
   */
  contactPhone: string
  /**
   * 禁用状态
   */
  disabledFlag: boolean
  /**
   * 区县
   */
  district?: number
  /**
   * 区县名称
   */
  districtName?: string
  /**
   * 邮箱
   */
  email?: string
  /**
   * 企业ID
   */
  enterpriseId: number
  /**
   * 企业logo
   */
  enterpriseLogo?: string
  /**
   * 企业名称
   */
  enterpriseName: string
  /**
   * 省份
   */
  province?: number
  /**
   * 省份名称
   */
  provinceName?: string
  /**
   * 类型  <br>  export const ENTERPRISE_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;NORMAL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'有限企业'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FOREIGN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'外资企业'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  type?: number
  /**
   * 统一社会信用代码
   */
  unifiedSocialCreditCode: string
  [property: string]: any
}

export interface EnterpriseItem {
  /**
   * 是否为空
   */
  emptyFlag?: boolean
  /**
   * 结果集
   */
  list?: EnterpriseVO[]
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

/**
 * EnterpriseVO，结果集
 */
export interface EnterpriseVO {
  /**
   * 详细地址
   */
  address?: string
  /**
   * 营业执照
   */
  businessLicense?: string
  /**
   * 城市
   */
  city?: number
  /**
   * 城市名称
   */
  cityName?: string
  /**
   * 联系人
   */
  contact?: string
  /**
   * 联系人电话
   */
  contactPhone?: string
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
   * 区县
   */
  district?: number
  /**
   * 区县名称
   */
  districtName?: string
  /**
   * 邮箱
   */
  email?: string
  /**
   * 企业ID
   */
  enterpriseId?: number
  /**
   * 企业logo
   */
  enterpriseLogo?: string
  /**
   * 企业名称
   */
  enterpriseName?: string
  /**
   * 省份
   */
  province?: number
  /**
   * 省份名称
   */
  provinceName?: string
  /**
   * 类型  <br>  export const ENTERPRISE_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;NORMAL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'有限企业'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FOREIGN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'外资企业'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  type?: number
  /**
   * 统一社会信用代码
   */
  unifiedSocialCreditCode?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface EnterpriseQueryPageRequest {
/**
 * 禁用状态
 */
  disabledFlag?: boolean
  /**
   * 结束时间
   */
  endTime?: Date
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

export interface EnterpriseExportRequest {
  /**
   * 禁用状态
   */
  disabledFlag?: boolean
  /**
   * 结束时间
   */
  endTime?: Date
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

export interface EnterpriseEmployeeItem {
  /**
   * 员工名称
   */
  actualName?: string
  /**
   * 部门id
   */
  departmentId?: number
  /**
   * 部门名称
   */
  departmentName?: string
  /**
   * 是否被禁用
   */
  disabledFlag?: boolean
  /**
   * 员工
   */
  employeeId?: number
  enterpriseEmployeeId?: number
  /**
   * 企业ID
   */
  enterpriseId?: number
  /**
   * 企业名称
   */
  enterpriseName?: string
  /**
   * 登录账号
   */
  loginName?: string
  /**
   * 手机号码
   */
  phone?: string
  [property: string]: any
}

export interface EnterpriseEmployeeQueryPageRequest {
  /**
   * 公司Id
   */
  enterpriseId: number
  /**
   * 搜索词
   */
  keyword?: string
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

export interface EmployeeCreateRequest {
  /**
   * 员工信息id
   */
  employeeIdList: number[]
  /**
   * 企业id
   */
  enterpriseId: number
  [property: string]: any
}

export interface EmployeeDeleteRequest {
  /**
   * 员工信息id
   */
  employeeIdList: number[]
  /**
   * 企业id
   */
  enterpriseId: number
  [property: string]: any
}
