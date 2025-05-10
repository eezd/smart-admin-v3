import type { RouteRecordRaw } from "vue-router"
import { setRouteChange } from "@/common/composables/useRouteListener"
import { useTitle } from "@/common/composables/useTitle"
import { HOME_PAGE_PATH, PAGE_PATH_404, PAGE_PATH_LOGIN } from "@/common/constants/common-const"
import { HOME_PAGE_NAME } from "@/common/constants/system/home-const"
import { getToken } from "@/common/utils/cache/cookies"
import { useUserStore } from "@/pinia/stores/user"
import { routerConfig } from "@/router/config"
// import { registerNavigationGuard } from "@/router/guard"
import { isFunction } from "lodash-es"
import nProgress from "nprogress"
import { createRouter } from "vue-router"
import { flatMultiLevelRoutes } from "./helper"

const Layouts = () => import("@/layouts/index.vue")

/**
 * @name 常驻路由
 * @description 除了 redirect/403/404/login 等隐藏页面，其他页面建议设置唯一的 Name 属性
 */
export const constantRoutes: RouteRecordRaw[] = [
  {
    path: "/redirect",
    component: Layouts,
    meta: {
      hidden: true
    },
    children: [
      {
        path: ":path(.*)",
        component: () => import("@/pages/redirect/index.vue")
      }
    ]
  },
  {
    path: "/403",
    component: () => import("@/pages/error/403.vue"),
    meta: {
      hidden: true
    }
  },
  {
    path: "/404",
    component: () => import("@/pages/error/404.vue"),
    meta: {
      hidden: true
    },
    alias: "/:pathMatch(.*)*"
  },
  {
    path: "/login",
    component: () => import("@/pages/login/index.vue"),
    meta: {
      hidden: true
    }
  },
  {
    path: "/",
    component: Layouts,
    redirect: "/dashboard",
    children: [
      {
        path: "dashboard",
        component: () => import("@/pages/dashboard/index.vue"),
        name: "Dashboard",
        meta: {
          title: "首页",
          svgIcon: "dashboard",
          keepAlive: true,
          affix: true
        }
      }
    ]
  }
]

/**
 * @name 动态路由
 * @description 用来放置有权限 (Roles 属性) 的路由
 * @description 必须带有唯一的 Name 属性
 */
export const dynamicRoutes: RouteRecordRaw[] = [

]

/** 路由实例 */
export const router = createRouter({
  history: routerConfig.history,
  routes: routerConfig.thirdLevelRouteCache ? flatMultiLevelRoutes(constantRoutes) : constantRoutes
})

/** 重置路由 */
export function resetRouter() {
  try {
    // 注意：所有动态路由路由必须带有 Name 属性，否则可能会不能完全重置干净
    router.getRoutes().forEach((route) => {
      const { name, meta } = route
      if (name && meta.roles?.length) {
        router.hasRoute(name) && router.removeRoute(name)
      }
    })
  } catch {
    // 强制刷新浏览器也行，只是交互体验不是很好
    location.reload()
  }
}

const routerMap = new Map()

router.beforeEach(async (to, from, next) => {
  // 进度条开启
  nProgress.start()

  // 公共页面，任何时候都可以跳转
  if (to.path === PAGE_PATH_404) {
    next()
    return true
  }

  // 验证登录
  if (!getToken()) {
    useUserStore().logout()
    if (to.path === PAGE_PATH_LOGIN) {
      next()
    } else {
      next({ path: PAGE_PATH_LOGIN })
    }
    return true
  }

  // 登录页，则跳转到首页
  if (to.path === PAGE_PATH_LOGIN) {
    next({ path: HOME_PAGE_PATH })
    return true
  }

  // 首页（ 需要登录 ，但不需要验证权限）
  if (to.path === HOME_PAGE_NAME) {
    next()
    return true
  }

  // 下载路由对应的 页面组件，并修改组件的Name，如果修改过，则不需要修改
  const toRouterInfo = routerMap.get(to.name)
  if (toRouterInfo && isFunction(toRouterInfo.component) && toRouterInfo.meta.renameComponentFlag === false) {
    // 因为组件component 为 lazy load是个方法，所以可以直接执行 component()方法
    toRouterInfo.component().then((val: any) => {
      // 修改组件的name
      val.default.name = to.meta.componentName
      // 记录已经修改过 组件的name
      toRouterInfo.meta.renameComponentFlag = true
      console.log(to.meta.componentName)
    })
  }

  // useUserStore().setTagNav(to, from)

  // 设置keepAlive
  // if (to.meta.keepAlive) {
  //   nextTick(() => {
  //     useUserStore().pushKeepAliveIncludes(to.meta.componentName)
  //   })
  // }

  console.log(to.meta)

  next()
})

// router.afterEach(() => {
//   nProgress.done()
// })

const { setTitle } = useTitle()
// 全局后置钩子
router.afterEach((to) => {
  setRouteChange(to)
  setTitle(to.meta.title)
  nProgress.done()
})

export function buildRoutes(menuRouterList?: any) {
  const menuList = menuRouterList || useUserStore().menuRouterList || []
  /**
   * 1、构建整个路由信息
   * 2、添加到路由里
   */
  const routerList = []
  // 获取所有vue组件引用地址 用于构建路由
  const modules = import.meta.glob("../pages/**/**.vue")
  // 获取所有vue组件 用于注入name属性 name属性用于keep-alive
  console.log(modules)

  console.log("路由构建开始")

  // 1、构建整个路由信息
  for (const e of menuList) {
    if (!e.menuId) {
      continue
    }
    if (!e.path) {
      continue
    }
    if (e.deletedFlag && e.deletedFlag === true) {
      continue
    }
    const route = {
      path: e.path.startsWith("/") ? e.path : `/${e.path}`,
      // 使用【menuId】作为name唯一标识
      name: e.menuId.toString(),
      meta: {
        // 数据库菜单(页面)id
        id: e.menuId.toString(),
        // 组件名称
        componentName: e.menuId.toString(),
        // 菜单展示
        title: e.menuName,
        // 菜单图标展示
        icon: e.icon,
        // 是否在菜单隐藏
        hideInMenu: !e.visibleFlag,
        // 页面是否keep-alive缓存
        keepAlive: e.cacheFlag,
        // 是否为外链
        frameFlag: e.frameFlag,
        // 外链地址
        frameUrl: e.frameUrl,
        // 是否 rename了组件的名字
        renameComponentFlag: false
      }
    } as any

    if (e.frameFlag) {
      route.component = () => import("@@/components/Framework/Iframe/iframe-index.vue")
    } else {
      const componentPath = e.component && e.component.startsWith("/") ? e.component : `/${e.component}`
      const relativePath = `../pages${componentPath}`
      // // eslint-disable-next-line no-prototype-builtins
      route.component = modules[relativePath]
    }
    routerList.push(route)
    routerMap.set(e.menuId.toString(), route)
  }

  // 2、添加到路由里
  router.addRoute({
    path: "/",
    meta: {},
    component: Layouts,
    children: routerList
  })
  console.log("路由构建完成")
  console.log(router)
}
