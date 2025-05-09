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
 * 获取用户信息和用户权限对应的路由，构建动态路由
 */
async function getLoginInfo() {
  try {
    // 获取登录用户信息
    const res: any = await loginApi.getLoginInfo()
    const dictRes = await dictApi.getAllData()
    // 构建系统的路由
    const menuRouterList = res.data.menuList.filter((e: { path: any, frameUrl: any }) => e.path || e.frameUrl)
    buildRoutes(menuRouterList)
    initVue()
    // 初始化数据字典
    useDictStore().initData(dictRes.data)
    // 更新用户信息到pinia
    useUserStore().setUserLoginInfo(res.data)
  } catch (e: any) {
    message.error(e.data ? e.data.msg : e.message)
    smartSentry.captureError(e)
    initVue()
  }
}

async function initVue() {
  const app = createApp(App)
  // let vueApp = createApp(App);
  // let app = vueApp
  //   .use(router)
  //   .use(store)
  //   .use(i18n)
  //   .use(Antd)
  //   .use(smartEnumPlugin, constantsInfo)
  //   .use(privilegePlugin)
  //   .use(dictPlugin)
  //   .use(JsonViewer);
  installPlugins(app)
  app.use(pinia).use(router)
  // 注入权限
  app.directive("privilege", {
    mounted(el, binding) {
      privilegeDirective(el, binding)
    }
  })
  // 注册图标组件
  // Object.keys(antIcons).forEach((key) => {
  //   app.component(key, antIcons[key]);
  // });
  // 全局
  // app.config.globalProperties.$antIcons = antIcons;
  // app.config.globalProperties.$lodash = lodash;
  // 挂载
  app.mount("#app")
}

// // 创建应用实例
// const app = createApp(App)

// // 安装插件（全局组件、自定义指令等）
// installPlugins(app)

// // 安装 pinia 和 router
// app.use(pinia).use(router)

// // router 准备就绪后挂载应用
// router.isReady().then(() => {
//   app.mount("#app")
// })

if (!getToken()) {
  initVue()
} else {
  getLoginInfo()
}
