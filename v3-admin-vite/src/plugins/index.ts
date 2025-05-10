import type { App } from "vue"
import constantsInfo from "@@/constants/index"
import { installDictPlugin } from "./dict-plugin"
import { installElementPlusIcons } from "./element-plus-icons"
import { installPrivilege } from "./privilege-plugin"
import { installSmartEnum } from "./smart-enums-plugin"
import { installSvgIcon } from "./svg-icon"
import { installVxeTable } from "./vxe-table"

export function installPlugins(app: App) {
  installElementPlusIcons(app)
  installSmartEnum(app, constantsInfo)
  installPrivilege(app)
  installDictPlugin(app)
  installSvgIcon(app)
  installVxeTable(app)
}
