import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 员工
 */
export const employeeApi = {
  queryPage: (data: EmployeeQueryPageRequest) => {
    return request<ApiResponseData<PageResultModel<EmployeeItem>>>({
      url: "employee/query",
      method: "POST",
      data
    })
  },
  queryList: () => {
    return request<ApiResponseData<EmployeeItem[]>>({
      url: "employee/queryAll",
      method: "GET"
    })
  },
  /** 添加员工 */
  create: (data: EmployeeCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "employee/add",
      method: "POST",
      data
    })
  },
  /** 更新员工信息 */
  update: (data: EmployeeUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "employee/update",
      method: "POST",
      data
    })
  },
  /** 更新员工个人中心信息 */
  updateCenter: (data: EmployeeUpdateCenterRequest) => {
    return request<ApiResponseData<any>>({
      url: "employee/update/center",
      method: "POST",
      data
    })
  },
  /** 更新登录人头像 */
  updateAvatar: (data: EmployeeUpdateAvatarRequest) => {
    return request<ApiResponseData<any>>({
      url: "employee/update/avatar",
      method: "POST",
      data
    })
  },
  /** 删除员工 */
  delete: (employeeId: number) => {
    return request<ApiResponseData<any>>({
      url: `/employee/update/password/reset/${employeeId}`,
      method: "GET"
    })
  },
  /** 批量删除员工 */
  batchDelete: (data: number[]) => {
    return request<ApiResponseData<any>>({
      url: "employee/update/batch/delete",
      method: "POST",
      data
    })
  },
  /** 批量调整员工部门 */
  batchUpdateDepartmentEmployee: (data: EmployeeBatchUpdateDepartmentRequest) => {
    return request<ApiResponseData<any>>({
      url: "employee/update/batch/department",
      method: "POST",
      data
    })
  },
  /** 重置员工密码 */
  resetPassword: (employeeId: number) => {
    return request<ApiResponseData<any>>({
      url: `employee/resetPassword/${employeeId}`,
      method: "GET"
    })
  },
  /** 修改密码 */
  updatePassword: (data: EmployeeUpdatePasswordRequest) => {
    return request<ApiResponseData<any>>({
      url: "employee/update/password",
      method: "POST",
      data
    })
  },
  /** 获取密码复杂度 */
  getPasswordComplexityEnabled: () => {
    return request<ApiResponseData<boolean>>({
      url: "employee/getPasswordComplexityEnabled",
      method: "GET"
    })
  },
  /** 更新员工禁用状态 */
  updateDisabled: (employeeId: number) => {
    return request<ApiResponseData<any>>({
      url: `employee/update/disabled/${employeeId}`,
      method: "GET"
    })
  },
  /** 查询员工-根据部门id */
  queryEmployeeByDeptId: (departmentId: number) => {
    return request<ApiResponseData<EmployeeItem[]>>({
      url: `employee/getAllEmployeeByDepartmentId/${departmentId}`,
      method: "GET"
    })
  }
}

export interface EmployeeQueryPageRequest {
  /**
   * 部门id
   */
  departmentId?: number
  /**
   * 是否禁用
   */
  disabledFlag?: boolean
  /**
   * 员工id集合
   */
  employeeIdList?: number[]
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

export interface EmployeeItem {
  /**
   * 员工名称
   */
  actualName?: string
  /**
   * 是否 超级管理员
   */
  administratorFlag?: boolean
  /**
   * 创建时间
   */
  createTime?: Date
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
   * 邮箱
   */
  email?: string
  /**
   * 主键id
   */
  employeeId?: number
  /**
   * <br>  export const GENDER_ENUM = <BR>
   * {<br>&nbsp;&nbsp;UNKNOWN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:0,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'未知'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;MAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'男'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;WOMAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'女'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  gender?: number
  /**
   * 登录账号
   */
  loginName?: string
  /**
   * 手机号码
   */
  phone?: string
  /**
   * 职务ID
   */
  positionId?: number
  /**
   * 职务名称
   */
  positionName?: string
  /**
   * 角色列表
   */
  roleIdList?: number[]
  /**
   * 角色名称列表
   */
  roleNameList?: string[]
  [property: string]: any
}

export interface EmployeeCreateRequest {
  /**
   * 姓名
   */
  actualName: string
  /**
   * 部门id
   */
  departmentId: number
  /**
   * 是否启用
   */
  disabledFlag: boolean
  /**
   * 邮箱账号
   */
  email: string
  /**
   * <br>  export const GENDER_ENUM = <BR>
   * {<br>&nbsp;&nbsp;UNKNOWN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:0,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'未知'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;MAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'男'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;WOMAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'女'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  gender?: number
  /**
   * 登录账号
   */
  loginName: string
  /**
   * 手机号
   */
  phone: string
  /**
   * 职务级别ID
   */
  positionId?: number
  /**
   * 备注
   */
  remark?: string
  /**
   * 角色列表
   */
  roleIdList?: number[]
  [property: string]: any
}

export interface EmployeeUpdateRequest {
  /**
   * 姓名
   */
  actualName: string
  /**
   * 部门id
   */
  departmentId: number
  /**
   * 是否启用
   */
  disabledFlag: boolean
  /**
   * 邮箱账号
   */
  email: string
  /**
   * 员工id
   */
  employeeId: number
  /**
   * <br>  export const GENDER_ENUM = <BR>
   * {<br>&nbsp;&nbsp;UNKNOWN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:0,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'未知'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;MAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'男'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;WOMAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'女'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  gender?: number
  /**
   * 登录账号
   */
  loginName: string
  /**
   * 手机号
   */
  phone: string
  /**
   * 职务级别ID
   */
  positionId?: number
  /**
   * 备注
   */
  remark?: string
  /**
   * 角色列表
   */
  roleIdList?: number[]
  [property: string]: any
}

export interface EmployeeUpdateCenterRequest {
  /**
   * 姓名
   */
  actualName: string
  /**
   * 头像
   */
  avatar?: string
  /**
   * 邮箱账号
   */
  email: string
  /**
   * <br>  export const GENDER_ENUM = <BR>
   * {<br>&nbsp;&nbsp;UNKNOWN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:0,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'未知'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;MAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'男'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;WOMAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'女'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  gender?: number
  /**
   * 手机号
   */
  phone: string
  /**
   * 职务级别ID
   */
  positionId?: number
  /**
   * 备注
   */
  remark?: string
  [property: string]: any
}

export interface EmployeeUpdateAvatarRequest {
  /**
   * 头像
   */
  avatar: string
  [property: string]: any
}

export interface EmployeeBatchUpdateDepartmentRequest {
  /**
   * 部门ID
   */
  departmentId: number
  /**
   * 员工id
   */
  employeeIdList: number[]
  [property: string]: any
}

export interface EmployeeUpdatePasswordRequest {
  /**
   * 新密码
   */
  newPassword: string
  /**
   * 原密码
   */
  oldPassword: string
  [property: string]: any
}
