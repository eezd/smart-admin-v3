import type { ApiResponseData } from "types/api"
import { request } from "@/http/axios"

/*
 * 登录
 */
export const loginApi = {
  login: (data: LoginRequest) => {
    return request<ApiResponseData<LoginResponse>>({
      url: "login",
      method: "POST",
      data
    })
  },
  logout: () => {
    return request<ApiResponseData<any>>({
      url: "login",
      method: "GET"
    })
  },
  getCaptcha: () => {
    return request<ApiResponseData<CaptchaData>>({
      url: "login/getCaptcha",
      method: "GET"
    })
  },
  getLoginInfo: () => {
    return request<ApiResponseData<LoginInfoData>>({
      url: "login/getLoginInfo",
      method: "GET"
    })
  },
  /** 获取邮箱登录验证码 */
  sendLoginEmailCode: (loginName: string) => {
    return request<ApiResponseData<any>>({
      url: `login/sendEmailCode/${loginName}`,
      method: "GET"
    })
  },
  getTwoFactorLoginFlag: () => {
    return request<ApiResponseData<any>>({
      url: "login/getTwoFactorLoginFlag",
      method: "GET"
    })
  }
}

export interface LoginRequest {
  /**
   * 验证码
   */
  captchaCode: string
  /**
   * 验证码uuid标识
   */
  captchaUuid: string
  /**
   * 邮箱验证码
   */
  emailCode?: string
  /**
   * <font style="color: red;">【必填】</font>登录终端  <br>  export const LOGIN_DEVICE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;PC:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'电脑端'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;ANDROID:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'安卓'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;APPLE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:3,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'苹果'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;H5:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:4,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'H5'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;WEIXIN_MP:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:5,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'微信小程序'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  loginDevice?: number
  /**
   * 登录账号
   */
  loginName: string
  /**
   * 密码
   */
  password: string
  [property: string]: any
}

export interface LoginResponse {
/**
 * 员工名称
 */
  actualName?: string
  /**
   * 是否为超管
   */
  administratorFlag?: boolean
  /**
   * 头像
   */
  avatar?: string
  /**
   * 部门id
   */
  departmentId?: number
  /**
   * 部门名称
   */
  departmentName?: string
  /**
   * 是否禁用
   */
  disabledFlag?: boolean
  /**
   * 邮箱
   */
  email?: string
  /**
   * 员工id
   */
  employeeId?: number
  /**
   * <br>  export const GENDER_ENUM = <BR>
   * {<br>&nbsp;&nbsp;UNKNOWN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:0,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'未知'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;MAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'男'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;WOMAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'女'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  gender?: number
  /**
   * 请求ip
   */
  ip?: string
  /**
   * 上次登录ip
   */
  lastLoginIp?: string
  /**
   * 上次登录ip地区
   */
  lastLoginIpRegion?: string
  /**
   * 上次登录时间
   */
  lastLoginTime?: Date
  /**
   * 上次登录user-agent
   */
  lastLoginUserAgent?: string
  /**
   * 登录账号
   */
  loginName?: string
  /**
   * 菜单列表
   */
  menuList?: MenuVO[]
  /**
   * 是否需要修改密码
   */
  needUpdatePwdFlag?: boolean
  /**
   * 手机号码
   */
  phone?: string
  /**
   * 职务级别ID
   */
  positionId?: number
  /**
   * 备注
   */
  remark?: string
  /**
   * token
   */
  token?: string
  /**
   * 请求user-agent
   */
  userAgent?: string
  userId?: number
  userName?: string
  /**
   * <br>  export const USER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;ADMIN_EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  userType?: UserType
  [property: string]: any
}

/**
 * MenuVO，菜单列表
 */
export interface MenuVO {
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

export enum UserType {
  AdminEmployee = "ADMIN_EMPLOYEE"
}

export interface CaptchaData {
  /**
   * 验证码Base64图片
   */
  captchaBase64Image?: string
  /**
   * 验证码图片内容-生产环境无效
   */
  captchaText?: string
  /**
   * 验证码唯一标识
   */
  captchaUuid?: string
  /**
   * 过期时间（秒）
   */
  expireSeconds?: number
  [property: string]: any
}

export interface LoginInfoData {
  /**
   * 员工名称
   */
  actualName?: string
  /**
   * 是否为超管
   */
  administratorFlag?: boolean
  /**
   * 头像
   */
  avatar?: string
  /**
   * 部门id
   */
  departmentId?: number
  /**
   * 部门名称
   */
  departmentName?: string
  /**
   * 是否禁用
   */
  disabledFlag?: boolean
  /**
   * 邮箱
   */
  email?: string
  /**
   * 员工id
   */
  employeeId?: number
  /**
   * <br>  export const GENDER_ENUM = <BR>
   * {<br>&nbsp;&nbsp;UNKNOWN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:0,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'未知'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;MAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'男'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;WOMAN:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:2,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'女'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  gender?: number
  /**
   * 请求ip
   */
  ip?: string
  /**
   * 上次登录ip
   */
  lastLoginIp?: string
  /**
   * 上次登录ip地区
   */
  lastLoginIpRegion?: string
  /**
   * 上次登录时间
   */
  lastLoginTime?: Date
  /**
   * 上次登录user-agent
   */
  lastLoginUserAgent?: string
  /**
   * 登录账号
   */
  loginName?: string
  /**
   * 菜单列表
   */
  menuList?: MenuVO[]
  /**
   * 是否需要修改密码
   */
  needUpdatePwdFlag?: boolean
  /**
   * 手机号码
   */
  phone?: string
  /**
   * 职务级别ID
   */
  positionId?: number
  /**
   * 备注
   */
  remark?: string
  /**
   * token
   */
  token?: string
  /**
   * 请求user-agent
   */
  userAgent?: string
  userId?: number
  userName?: string
  /**
   * <br>  export const USER_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;ADMIN_EMPLOYEE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:1,<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'员工'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  userType?: UserType
  [property: string]: any
}

/**
 * MenuVO，菜单列表
 */
export interface MenuVO {
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
}
