import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/*
 * 菜单
 */
export const menuApi = {
  create: (data: MenuCreateRequest) => {
    return request<ApiResponseData<any>>({
      url: "menu/add",
      method: "POST",
      data
    })
  },
  batchDelete: (menuIdList: number[]) => {
    return request<ApiResponseData<any>>({
      url: `menu/batchDelete?menuIdList=${menuIdList}`,
      method: "GET"
    })
  },
  update: (data: MenuUpdateRequest) => {
    return request<ApiResponseData<any>>({
      url: "menu/update",
      method: "POST",
      data
    })
  },
  /** 查询菜单列表 */
  queryList: () => {
    return request<ApiResponseData<MenuItem[]>>({
      url: "menu/query",
      method: "GET"
    })
  },
  /** 查询菜单树 */
  queryTree: (onlyMenu: boolean) => {
    return request<ApiResponseData<MenuTreeItem[]>>({
      url: `menu/tree?onlyMenu=${onlyMenu}`,
      method: "GET"
    })
  },
  /** 获取所有请求路径 */
  getAuthUrl: () => {
    return request<ApiResponseData<MenuAuthUrlItem[]>>({
      url: "menu/auth/url",
      method: "GET"
    })
  }
}

export interface MenuCreateRequest {
  /**
   * 后端端权限字符串
   */
  apiPerms?: string
  /**
   * 是否缓存
   */
  cacheFlag: boolean
  /**
   * 组件路径
   */
  component?: string
  /**
   * 功能点关联菜单ID
   */
  contextMenuId?: number
  /**
   * 禁用状态
   */
  disabledFlag: boolean
  /**
   * 是否为外链
   */
  frameFlag: boolean
  /**
   * 外链地址
   */
  frameUrl?: string
  /**
   * 菜单图标
   */
  icon?: string
  /**
   * 菜单名称
   */
  menuName: string
  /**
   * 类型  <br>  export const MENU_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;CATALOG:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'目录'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;MENU:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'菜单'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;POINTS:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'功能点'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  menuType?: number
  /**
   * 父菜单ID 无上级可传0
   */
  parentId: number
  /**
   * 路由地址
   */
  path?: string
  /**
   * 权限类型   <br>  export const MENU_PERMS_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;SA_TOKEN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'Sa-Token模式'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  permsType?: number
  /**
   * 显示顺序
   */
  sort?: number
  /**
   * 显示状态
   */
  visibleFlag: boolean
  /**
   * 前端权限字符串
   */
  webPerms?: string
  [property: string]: any
}

export interface MenuUpdateRequest {
  /**
   * 后端端权限字符串
   */
  apiPerms?: string
  /**
   * 是否缓存
   */
  cacheFlag: boolean
  /**
   * 组件路径
   */
  component?: string
  /**
   * 功能点关联菜单ID
   */
  contextMenuId?: number
  /**
   * 禁用状态
   */
  disabledFlag: boolean
  /**
   * 是否为外链
   */
  frameFlag: boolean
  /**
   * 外链地址
   */
  frameUrl?: string
  /**
   * 菜单图标
   */
  icon?: string
  /**
   * 菜单ID
   */
  menuId: number
  /**
   * 菜单名称
   */
  menuName: string
  /**
   * 类型  <br>  export const MENU_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;CATALOG:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'目录'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;MENU:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'菜单'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;POINTS:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'功能点'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  menuType?: number
  /**
   * 父菜单ID 无上级可传0
   */
  parentId: number
  /**
   * 路由地址
   */
  path?: string
  /**
   * 权限类型   <br>  export const MENU_PERMS_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;SA_TOKEN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'Sa-Token模式'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  permsType?: number
  /**
   * 显示顺序
   */
  sort?: number
  /**
   * 显示状态
   */
  visibleFlag: boolean
  /**
   * 前端权限字符串
   */
  webPerms?: string
  [property: string]: any
}

export interface MenuItem {
  /**
   * 后端端权限字符串
   */
  apiPerms?: string
  /**
   * 是否缓存
   */
  cacheFlag: boolean
  /**
   * 组件路径
   */
  component?: string
  /**
   * 功能点关联菜单ID
   */
  contextMenuId?: number
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 创建人
   */
  createUserId?: number
  /**
   * 禁用状态
   */
  disabledFlag: boolean
  /**
   * 是否为外链
   */
  frameFlag: boolean
  /**
   * 外链地址
   */
  frameUrl?: string
  /**
   * 菜单图标
   */
  icon?: string
  /**
   * 菜单ID
   */
  menuId?: number
  /**
   * 菜单名称
   */
  menuName: string
  /**
   * 类型  <br>  export const MENU_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;CATALOG:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'目录'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;MENU:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'菜单'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;POINTS:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'功能点'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  menuType?: number
  /**
   * 父菜单ID 无上级可传0
   */
  parentId: number
  /**
   * 路由地址
   */
  path?: string
  /**
   * 权限类型   <br>  export const MENU_PERMS_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;SA_TOKEN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'Sa-Token模式'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  permsType?: number
  /**
   * 显示顺序
   */
  sort?: number
  /**
   * 更新时间
   */
  updateTime?: Date
  /**
   * 更新人
   */
  updateUserId?: number
  /**
   * 显示状态
   */
  visibleFlag: boolean
  /**
   * 前端权限字符串
   */
  webPerms?: string
  [property: string]: any
}

export interface MenuTreeItem extends MenuItem {
  /**
   * 菜单子集
   */
  children?: MenuItem[]
}

export interface MenuAuthUrlItem {
  /**
   * 注释说明
   */
  comment?: string
  /**
   * controller.method
   */
  name?: string
  /**
   * url
   */
  url?: string
  [property: string]: any
}
