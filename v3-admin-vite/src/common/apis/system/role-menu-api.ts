import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/*
 * 角色菜单
 */
export const roleMenuApi = {
  /*
   * 获取角色关联菜单权限
   */
  getRoleSelectedMenu: (roleId: number) => {
    return request<ApiResponseData<RoleMenuTree>>({
      url: `role/menu/getRoleSelectedMenu/${roleId}`,
      method: "GET"
    })
  },

  /*
   * 更新角色权限
   */
  updateRoleMenu: (data: RoleMenuUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "role/menu/updateRoleMenu",
      method: "POST",
      data
    })
  }
}

export interface RoleMenuTree {
  /**
   * 菜单列表
   */
  menuTreeList?: MenuSimpleTreeVO[]
  /**
   * 角色ID
   */
  roleId?: number
  /**
   * 选中的菜单ID
   */
  selectedMenuId?: number[]
  [property: string]: any
}

/**
 * MenuSimpleTreeVO，菜单列表
 */
export interface MenuSimpleTreeVO {
  /**
   * 子菜单
   */
  children?: MenuSimpleTreeVO[]
  /**
   * 功能点关联菜单ID
   */
  contextMenuId?: number
  /**
   * 菜单ID
   */
  menuId?: number
  /**
   * 菜单名称
   */
  menuName?: string
  /**
   * 菜单类型
   */
  menuType?: number
  /**
   * 父级菜单ID
   */
  parentId?: number
  [property: string]: any
}

export interface RoleMenuUpdateRequest {
  /**
   * 菜单ID集合
   */
  menuIdList: number[]
  /**
   * 角色id
   */
  roleId: number
  [property: string]: any
}
