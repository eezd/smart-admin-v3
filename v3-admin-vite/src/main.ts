/* eslint-disable perfectionist/sort-imports */

// core
import { pinia } from "@/pinia"
import { buildRoutes, router } from "@/router"
import { installPlugins } from "@/plugins"
import App from "@/App.vue"
// css
import "normalize.css"
import "nprogress/nprogress.css"
import "element-plus/theme-chalk/dark/css-vars.css"
import "vxe-table/lib/style.css"
import "@@/assets/styles/index.scss"
import "virtual:uno.css"
import message from "element-plus/es/components/message/index.mjs"
import { dictApi } from "./common/apis/support/dict-api"
import { loginApi } from "./common/apis/system/login-api"
import { smartSentry } from "./lib/smart-sentry"
import { useDictStore } from "./pinia/stores/dict"
import { useUserStore } from "./pinia/stores/user"
import { privilegeDirective } from "./common/directives/privilege"
import { getToken } from "./common/utils/cache/cookies"

/*
 * -------------------- ※ 着重 解释说明下main.js的初始化逻辑 begin ※ --------------------
 *
 * 1、在main.js里很多框架都是 直接调用初始化的vue方法，创建vue实例，然后挂载路由router、状态管理store等等，但是关于router这块是有问题的；
 * 2、因为现在大部分路由都是从后端接口返回的，如若直接初始化挂载路由，这时前端还没有从后端请求路由的数据，所以只能写到路由拦截器里，这样很绕很不清晰；
 *    正确的做法流程应该是：
 *      2.1）如果存在登录信息，则先ajax请求用户的所有路由，然后加载，再去创建vue实例和挂载路由
 *      2.2）如果不存在路由信息，则创建vue实例和挂载路由（此时的路由应该只有login页面，因为用户拥有哪些路由是登录之后才知道的）
 * 3、以上，在main.js里两个方法，一个是 获取登录信息getLoginInfo，另一个初始化vue: initVue，在最下的if操作里
 *
 * -------------------- ※ 着重 解释说明下main.js的初始化逻辑 end ※ --------------------
 */

/**
 * 初始化 Vue 应用程序
 */
function initVue() {
  const app = createApp(App)
  // 安装插件
  installPlugins(app)

  // 重要：确保 Pinia 在其他需要 store 的功能之前初始化
  app.use(pinia)
  app.use(router)

  // 注入权限
  app.directive("privilege", {
    mounted(el, binding) {
      privilegeDirective(el, binding)
    }
  })

  // 返回初始化好的 app 实例
  return app
}

/**
 * 获取用户信息和用户权限对应的路由，构建动态路由
 */
async function getLoginInfo(app: any) {
  try {
    // 获取登录用户信息
    const res: any = await loginApi.getLoginInfo()
    const dictRes = await dictApi.getAllData()

    // 构建系统的路由
    const menuRouterList = res.data.menuList.filter((e: { path: any, frameUrl: any }) => e.path || e.frameUrl)
    buildRoutes(menuRouterList)

    // 初始化数据字典
    useDictStore().initData(dictRes.data)

    // 更新用户信息到pinia
    useUserStore().setUserLoginInfo(res.data)

    // 挂载应用
    app.mount("#app")
  } catch (e: any) {
    message.error(e.data ? e.data.msg : e.message)
    smartSentry.captureError(e)

    // 错误情况下仍然挂载应用
    app.mount("#app")
  }
}

// 程序入口点
async function bootstrap() {
  // 初始化 Vue 应用，但不立即挂载
  const app = initVue()

  if (!getToken()) {
    // 用户未登录，直接挂载应用
    app.mount("#app")
  } else {
    // 用户已登录，获取用户信息并构建路由后再挂载
    await getLoginInfo(app)
  }
}

// 启动应用
bootstrap()
