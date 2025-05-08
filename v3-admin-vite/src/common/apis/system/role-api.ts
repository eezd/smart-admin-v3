import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/*
 * 角色管理
 */
export const roleApi = {
  /*
   * 获取所有角色
   */
  queryAll: () => {
    return request<ApiResponseData<RoleItem[]>>({
      url: "role/getAll",
      method: "GET"
    })
  },

  /*
   * 添加角色
   */
  addRole: (data: RoleCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "role/add",
      method: "POST",
      data
    })
  },

  /*
   * 更新角色
   */
  updateRole: (data: RoleUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "role/update",
      method: "POST",
      data
    })
  },

  /*
   * 删除角色
   */
  deleteRole: (roleId: number) => {
    return request<ApiResponseData<any>>({
      url: `role/delete/${roleId}`,
      method: "GET"
    })
  },

  /*
   * 批量设置数据范围
   */
  updateDataScope: (data: DataScopeUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "role/dataScope/updateRoleDataScopeList",
      method: "POST",
      data
    })
  },

  /*
   * 获取所有数据范围配置
   */
  getDataScopeList: () => {
    return request<ApiResponseData<DataScopeItem[]>>({
      url: "dataScope/list",
      method: "GET"
    })
  },

  /*
   * 获取角色数据范围
   */
  getDataScopeByRoleId: (roleId: number) => {
    return request<ApiResponseData<DataScopeItem[]>>({
      url: `role/dataScope/getRoleDataScopeList/${roleId}`,
      method: "GET"
    })
  },

  /*
   * 查询角色成员（分页）
   */
  queryRoleEmployee: (params: RoleEmployeeQueryRequest) => {
    return request<ApiResponseData<PageResultModel<EmployeeItem>>>({
      url: "role/employee/queryEmployee",
      method: "POST",
      data: params
    })
  },

  /*
   * 移除角色成员
   */
  deleteEmployeeRole: (employeeId: number, roleId: number) => {
    return request<ApiResponseData<any>>({
      url: `role/employee/removeEmployee?employeeId=${employeeId}&roleId=${roleId}`,
      method: "GET"
    })
  },

  /*
   * 批量移除角色成员
   */
  batchRemoveRoleEmployee: (data: RoleEmployeeBatchRemoveRequest) => {
    return request<ApiResponseData<any>>({
      url: "role/employee/batchRemoveRoleEmployee",
      method: "POST",
      data
    })
  },

  /*
   * 获取角色全部成员
   */
  getRoleAllEmployee: (roleId: number) => {
    return request<ApiResponseData<EmployeeItem[]>>({
      url: `role/employee/getAllEmployeeByRoleId/${roleId}`,
      method: "GET"
    })
  },

  /*
   * 批量添加角色成员
   */
  batchAddRoleEmployee: (data: RoleEmployeBatchAddRequest) => {
    return request<ApiResponseData<any>>({
      url: "role/employee/batchAddRoleEmployee",
      method: "POST",
      data
    })
  }
}

export interface RoleItem {
  /**
   * 角色备注
   */
  remark?: string
  /**
   * 角色编码
   */
  roleCode?: string
  /**
   * 角色ID
   */
  roleId?: number
  /**
   * 角色名称
   */
  roleName?: string
  [property: string]: any
}

export interface RoleCreateRequest {
  /**
   * 角色描述
   */
  remark?: string
  /**
   * 角色编码
   */
  roleCode: string
  /**
   * 角色名称
   */
  roleName: string
  [property: string]: any
}

export interface RoleUpdateRequest {
  /**
   * 角色描述
   */
  remark?: string
  /**
   * 角色编码
   */
  roleCode: string
  /**
   * 角色id
   */
  roleId: number
  /**
   * 角色名称
   */
  roleName: string
  [property: string]: any
}

export interface DataScopeUpdateRequest {
  /**
   * 设置信息
   */
  dataScopeItemList?: DataScopeItem[]
  /**
   * 角色id
   */
  roleId: number
  [property: string]: any
}

export interface DataScopeItem {
  /**
   * 数据范围类型
   */
  dataScopeType: number
  /**
   * 可见范围
   */
  viewType: number
  [property: string]: any
}

export interface RoleEmployeeQueryRequest {
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
   * 角色id
   */
  roleId?: string
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

export interface RoleEmployeeBatchRemoveRequest {
  /**
   * 员工id集合
   */
  employeeIdList: number[]
  /**
   * 角色id
   */
  roleId: number
  [property: string]: any
}

export interface RoleEmployeBatchAddRequest {
  /**
   * 员工id集合
   */
  employeeIdList: number[]
  /**
   * 角色id
   */
  roleId: number
  [property: string]: any
}
