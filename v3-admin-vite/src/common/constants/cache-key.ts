const SYSTEM_NAME = "v3-admin-vite"

/** 缓存数据时用到的 Key */
export class CacheKey {
  static readonly TOKEN = `${SYSTEM_NAME}-token-key`
  static readonly CONFIG_LAYOUT = `${SYSTEM_NAME}-config-layout-key`
  static readonly SIDEBAR_STATUS = `${SYSTEM_NAME}-sidebar-status-key`
  static readonly ACTIVE_THEME_NAME = `${SYSTEM_NAME}-active-theme-name-key`
  static readonly VISITED_VIEWS = `${SYSTEM_NAME}-visited-views-key`
  static readonly CACHED_VIEWS = `${SYSTEM_NAME}-cached-views-key`

  // 用户权限点
  static readonly USER_POINTS = `${SYSTEM_NAME}-user-points`
  // 用户的tag列表
  static readonly USER_TAG_NAV = `${SYSTEM_NAME}-user_tag_nav`
  // 用户的tag列表
  static readonly APP_CONFIG = `${SYSTEM_NAME}-app_config`
  // app config 配置信息
  static readonly HOME_QUICK_ENTRY = `${SYSTEM_NAME}-home_quick_entry`
  // 首页快捷入口
  static readonly NOTICE_READ = `${SYSTEM_NAME}-notice_read`
  // 待办
  static readonly TO_BE_DONE = `${SYSTEM_NAME}-to_be_done`
}
