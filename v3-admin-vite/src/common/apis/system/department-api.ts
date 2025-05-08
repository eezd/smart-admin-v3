import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/*
 * 部门
 */
export const departmentApi = {
  queryList: () => {
    return request<ApiResponseData<DepartmentItem[]>>({
      url: "department/listAll",
      method: "GET"
    })
  },
  queryTree: () => {
    return request<ApiResponseData<DepartmentTreeItem[]>>({
      url: "department/treeList",
      method: "GET"
    })
  },
  create: (data: DepartmentCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "department/add",
      method: "POST",
      data
    })
  },
  update: (data: DepartmentUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "department/update",
      method: "POST",
      data
    })
  },
  delete: (departmentId: number) => {
    return request<ApiResponseData<any>>({
      url: `department/delete/${departmentId}`,
      method: "GET"
    })
  }
}

export interface DepartmentItem {
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 部门id
   */
  departmentId?: number
  /**
   * 部门负责人id
   */
  managerId?: number
  /**
   * 部门负责人姓名
   */
  managerName?: string
  /**
   * 部门名称
   */
  name?: string
  /**
   * 父级部门id
   */
  parentId?: number
  /**
   * 排序
   */
  sort?: number
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface DepartmentTreeItem {
  /**
   * 子部门
   */
  children?: DepartmentTreeItem[]
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 部门id
   */
  departmentId?: number
  /**
   * 部门负责人id
   */
  managerId?: number
  /**
   * 部门负责人姓名
   */
  managerName?: string
  /**
   * 部门名称
   */
  name?: string
  /**
   * 同级下一个元素id
   */
  nextId?: number
  /**
   * 父级部门id
   */
  parentId?: number
  /**
   * 同级上一个元素id
   */
  preId?: number
  /**
   * 自己和所有递归子部门的id集合
   */
  selfAndAllChildrenIdList?: number[]
  /**
   * 排序
   */
  sort?: number
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface DepartmentCreateRequest {
  /**
   * 部门负责人id
   */
  managerId?: number
  /**
   * 部门名称
   */
  name: string
  /**
   * 上级部门id (可选)
   */
  parentId?: number
  /**
   * 排序
   */
  sort: number
  [property: string]: any
}

export interface DepartmentUpdateRequest {
  /**
   * 部门id
   */
  departmentId: number
  /**
   * 部门负责人id
   */
  managerId?: number
  /**
   * 部门名称
   */
  name: string
  /**
   * 上级部门id (可选)
   */
  parentId?: number
  /**
   * 排序
   */
  sort: number
  [property: string]: any
}
