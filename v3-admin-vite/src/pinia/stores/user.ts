import { messageApi } from "@/common/apis/support/message-api"
import { CacheKey } from "@/common/constants/cache-key"
import { MENU_TYPE_ENUM } from "@/common/constants/system/menu-const"
import { smartSentry } from "@/lib/smart-sentry"
import { pinia } from "@/pinia"
import { resetRouter } from "@/router"
import { getCurrentUserApi } from "@@/apis/users"
import { setToken as _setToken, getToken, removeToken } from "@@/utils/cache/cookies"
import { cloneDeep, isEmpty } from "lodash-es"
import { useSettingsStore } from "./settings"
import { useTagsViewStore } from "./tags-view"

export const useUserStore = defineStore("user", () => {
  const token = ref<string>(getToken() || "")
  const roles = ref<string[]>(["686"])
  const username = ref<string>("")

  const employeeId = ref<string>("")
  const avatar = ref<string>("")
  const loginName = ref<string>("")
  const actualName = ref<string>("")
  const phone = ref<string>("")
  const departmentId = ref<string>("")
  const departmentName = ref<string>("")
  const needUpdatePwdFlag = ref<boolean>(false)
  const administratorFlag = ref<boolean>(true)
  const lastLoginIp = ref<string>("")
  const lastLoginIpRegion = ref<string>("")
  const lastLoginUserAgent = ref<string>("")
  const lastLoginTime = ref<string>("")
  const menuTree = ref<any[]>([])
  const menuRouterList = ref<any[]>([])
  const menuRouterInitFlag = ref<boolean>(false)
  const menuParentIdListMap = ref<Map<any, any>>(new Map())
  const pointsList = ref<any[]>([])
  const tagNav = ref<any>(null)
  const keepAliveIncludes = ref<string[]>([])
  const unreadMessageCount = ref<number>(0)
  const toBeDoneCount = ref<number>(0)

  const tagsViewStore = useTagsViewStore()
  const settingsStore = useSettingsStore()

  // 功能点
  const getPointList = () => {
    if (isEmpty(pointsList.value)) {
      const localUserPoints = localStorage.getItem(CacheKey.USER_POINTS) || ""
      pointsList.value = localUserPoints ? JSON.parse(localUserPoints) : []
    }
    return pointsList.value
  }

  // 登出
  const logout = () => {
    // loginApi.logout()
    removeToken()
    token.value = ""
    roles.value = []
    resetRouter()
    resetTagsView()

    menuTree.value = []
    tagNav.value = []
    unreadMessageCount.value = 0
    localStorage.removeItem(CacheKey.USER_POINTS)
    localStorage.removeItem(CacheKey.USER_TAG_NAV)
    localStorage.removeItem(CacheKey.APP_CONFIG)
    localStorage.removeItem(CacheKey.HOME_QUICK_ENTRY)
    localStorage.removeItem(CacheKey.NOTICE_READ)
    localStorage.removeItem(CacheKey.TO_BE_DONE)
  }

  // 设置 Token
  const setToken = (value: string) => {
    _setToken(value)
    token.value = value
  }

  // 获取用户详情
  const getInfo = async () => {
    const { data } = await getCurrentUserApi()
    username.value = data.username
    // 验证返回的 roles 是否为一个非空数组，否则塞入一个没有任何作用的默认角色，防止路由守卫逻辑进入无限循环
    // roles.value = data.roles?.length > 0 ? data.roles : routerConfig.defaultRoles
  }

  const setUserLoginInfo = async (data: any) => {
    // User basic info
    token.value = data.token
    employeeId.value = data.employeeId
    avatar.value = data.avatar
    loginName.value = data.loginName
    actualName.value = data.actualName
    phone.value = data.phone
    departmentId.value = data.departmentId
    departmentName.value = data.departmentName
    needUpdatePwdFlag.value = data.needUpdatePwdFlag
    administratorFlag.value = data.administratorFlag
    lastLoginIp.value = data.lastLoginIp
    lastLoginIpRegion.value = data.lastLoginIpRegion
    lastLoginUserAgent.value = data.lastLoginUserAgent
    lastLoginTime.value = data.lastLoginTime

    // Menu permissions
    menuTree.value = buildMenuTree(data.menuList)

    // Menus with routes
    menuRouterList.value = data.menuList.filter((e: any) => e.path || e.frameUrl)

    // Parent menu collection
    menuParentIdListMap.value = buildMenuParentIdListMap(menuTree.value)

    // Function points
    pointsList.value = data.menuList.filter(
      (menu: any) => menu.menuType === MENU_TYPE_ENUM.POINTS.value && menu.visibleFlag && !menu.disabledFlag
    )

    // 查询未读消息数量
    queryUnreadMessageCount()
    // 获取待办工作数
    queryToBeDoneList()
  }

  // 重置 Visited Views 和 Cached Views
  const resetTagsView = () => {
    if (!settingsStore.cacheTagsView) {
      tagsViewStore.delAllVisitedViews()
      tagsViewStore.delAllCachedViews()
    }
  }

  // 查询未读消息数量
  async function queryUnreadMessageCount() {
    try {
      const result = await messageApi.queryUnreadCount()
      unreadMessageCount.value = result.data
    } catch (e) {
      smartSentry.captureError(e)
    }
  }

  // 获取待办工作数
  async function queryToBeDoneList() {
    try {
      const localToBeDoneList = localStorage.getItem(CacheKey.TO_BE_DONE)
      if (localToBeDoneList) {
        toBeDoneCount.value = JSON.parse(localToBeDoneList).filter((e: any) => !e.doneFlag).length
      }
    } catch (err) {
      smartSentry.captureError(err)
    }
  }

  return {
    // State
    employeeId,
    avatar,
    loginName,
    actualName,
    phone,
    departmentId,
    departmentName,
    needUpdatePwdFlag,
    administratorFlag,
    lastLoginIp,
    lastLoginIpRegion,
    lastLoginUserAgent,
    lastLoginTime,
    menuTree,
    menuRouterList,
    menuRouterInitFlag,
    menuParentIdListMap,
    pointsList,
    tagNav,
    keepAliveIncludes,
    unreadMessageCount,
    toBeDoneCount,

    token,
    roles,
    username,

    getPointList,
    logout,
    setToken,
    getInfo,

    setUserLoginInfo,
    resetTagsView,
    queryUnreadMessageCount,
    queryToBeDoneList
  }
})

/**
 * @description 在 SPA 应用中可用于在 pinia 实例被激活前使用 store
 * @description 在 SSR 应用中可用于在 setup 外使用 store
 */
export function useUserStoreOutside() {
  return useUserStore(pinia)
}

/**
 * @description 构建菜单父级集合
 */
function buildMenuParentIdListMap(menuTree: any) {
  const menuParentIdListMap = new Map()
  recursiveBuildMenuParentIdListMap(menuTree, [], menuParentIdListMap)
  return menuParentIdListMap
}

function recursiveBuildMenuParentIdListMap(menuList: any, parentMenuList: any, menuParentIdListMap: Map<any, any>) {
  for (const e of menuList) {
    // 顶级parentMenuList清空
    if (e.parentId === 0) {
      parentMenuList = []
    }
    const menuIdStr = e.menuId.toString()
    const cloneParentMenuList = cloneDeep(parentMenuList)
    if (!isEmpty(e.children) && e.menuName) {
      // 递归
      cloneParentMenuList.push({ name: menuIdStr, title: e.menuName })
      recursiveBuildMenuParentIdListMap(e.children, cloneParentMenuList, menuParentIdListMap)
    } else {
      menuParentIdListMap.set(menuIdStr, cloneParentMenuList)
    }
  }
}

/**
 * @description 构建菜单树
 */
function buildMenuTree(menuList: any[]) {
  // 1 获取所有 有效的 目录和菜单
  const catalogAndMenuList = menuList.filter(menu => menu.menuType !== MENU_TYPE_ENUM.POINTS.value && menu.visibleFlag && !menu.disabledFlag)

  // 2 获取顶级目录
  const topCatalogList = catalogAndMenuList.filter(menu => menu.parentId === 0)
  for (const topCatalog of topCatalogList) {
    buildMenuChildren(topCatalog, catalogAndMenuList)
  }
  return topCatalogList
}

function buildMenuChildren(menu: { menuId: any, children: any }, allMenuList: any[]) {
  const children = allMenuList.filter(e => e.parentId === menu.menuId)
  if (children.length === 0) {
    return
  }
  menu.children = children
  for (const item of children) {
    buildMenuChildren(item, allMenuList)
  }
}
