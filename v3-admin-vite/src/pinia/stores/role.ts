import type { MenuItem } from "@/common/apis/system/menu-api"
import { defineStore } from "pinia"
import { computed, ref } from "vue"

/**
 * 角色权限管理 Store
 */
export const useRoleStore = defineStore("role", () => {
  // ==================== 状态定义 ====================

  /** 已选中的菜单ID列表 */
  const checkedData = ref<number[]>([])

  /** 菜单树映射表，用于快速查找父子关系 */
  const treeMap = ref<Map<number, MenuItem>>(new Map())

  // ==================== 计算属性 ====================

  /** 选中数据的数量 */
  const checkedCount = computed(() => checkedData.value.length)

  /** 是否有选中的数据 */
  const hasCheckedData = computed(() => checkedData.value.length > 0)

  // ==================== 基础操作方法 ====================

  /**
   * 初始化选中数据
   * @param data 选中的菜单ID数组
   */
  function initCheckedData(data: number[]) {
    checkedData.value = [...new Set(data)]
  }

  /**
   * 清空选中数据
   */
  function clearCheckedData() {
    checkedData.value = []
  }

  /**
   * 添加单个选中项
   * @param menuId 菜单ID
   */
  function addCheckedData(menuId: number) {
    if (!checkedData.value.includes(menuId)) {
      checkedData.value.push(menuId)
    }
  }

  /**
   * 移除单个选中项
   * @param menuId 菜单ID
   */
  function removeCheckedData(menuId: number) {
    const index = checkedData.value.indexOf(menuId)
    if (index > -1) {
      checkedData.value.splice(index, 1)
    }
  }

  /**
   * 检查菜单是否被选中
   * @param menuId 菜单ID
   * @returns 是否选中
   */
  function isMenuChecked(menuId: number): boolean {
    return checkedData.value.includes(menuId)
  }

  // ==================== 树形结构操作 ====================

  /**
   * 初始化树形映射表
   * @param tree 菜单树数据
   */
  function initTreeMap(tree: MenuItem[]) {
    treeMap.value.clear()

    const traverse = (nodes: MenuItem[]) => {
      nodes.forEach((node) => {
        if (node.menuId) {
          treeMap.value.set(node.menuId, node)
        }
        if (node.children && node.children.length > 0) {
          traverse(node.children)
        }
      })
    }

    traverse(tree)
  }

  /**
   * 根据菜单ID获取菜单项
   * @param menuId 菜单ID
   * @returns 菜单项或undefined
   */
  function getMenuById(menuId: number): MenuItem | undefined {
    return treeMap.value.get(menuId)
  }

  // ==================== 高级选择逻辑 ====================

  /**
   * 递归添加当前菜单及其所有子菜单
   * @param menuItem 菜单项
   */
  function addMenuAndChildren(menuItem: MenuItem) {
    if (menuItem.menuId) {
      addCheckedData(menuItem.menuId)
    }

    if (menuItem.children && menuItem.children.length > 0) {
      menuItem.children.forEach(child => addMenuAndChildren(child))
    }
  }

  /**
   * 递归移除当前菜单及其所有子菜单
   * @param menuItem 菜单项
   */
  function removeMenuAndChildren(menuItem: MenuItem) {
    if (menuItem.menuId) {
      removeCheckedData(menuItem.menuId)
    }

    if (menuItem.children && menuItem.children.length > 0) {
      menuItem.children.forEach(child => removeMenuAndChildren(child))
    }
  }

  /**
   * 向上选中所有父级菜单
   * @param menuItem 当前菜单项
   */
  function selectParentMenus(menuItem: MenuItem) {
    const findAndSelectParent = (current: MenuItem) => {
      if (!current.parentId) return

      const parent = treeMap.value.get(current.parentId)
      if (!parent || !parent.menuId) return

      // 选中父级菜单
      if (!isMenuChecked(parent.menuId)) {
        addCheckedData(parent.menuId)
      }

      // 递归选中上级父菜单
      if (parent.parentId) {
        findAndSelectParent(parent)
      }
    }

    findAndSelectParent(menuItem)
  }

  /**
   * 检查是否需要取消父级菜单选中状态
   * 当所有子菜单都未选中时，取消父级选中
   * @param menuItem 菜单项
   */
  function checkParentMenuStatus(menuItem: MenuItem) {
    if (!menuItem.parentId) return

    const parent = treeMap.value.get(menuItem.parentId)
    if (!parent || !parent.menuId) return

    // 检查父级的所有子菜单是否都未选中
    // 注意：功能点类型的子菜单不参与父级菜单的选中状态判断
    const hasCheckedChildren = parent.children?.some((child) => {
      if (!child.menuId) return false

      // 如果是功能点，不影响父级菜单状态
      if (child.menuType === 3) return false

      return isMenuChecked(child.menuId)
    })

    // 检查是否有选中的功能点
    const hasCheckedPoints = parent.children?.some((child) => {
      return child.menuId && child.menuType === 3 && isMenuChecked(child.menuId)
    })

    // 如果没有选中的子菜单，但有选中的功能点，保持父级选中状态
    // 如果既没有选中的子菜单，也没有选中的功能点，则取消父级选中
    if (!hasCheckedChildren && !hasCheckedPoints && isMenuChecked(parent.menuId)) {
      removeCheckedData(parent.menuId)
      // 递归检查上级父菜单
      checkParentMenuStatus(parent)
    }
  }

  /**
   * 切换菜单选中状态（主要的选择逻辑）
   * @param menuItem 菜单项
   */
  function toggleMenuSelection(menuItem: MenuItem) {
    if (!menuItem.menuId) return

    const isCurrentlyChecked = isMenuChecked(menuItem.menuId)

    if (isCurrentlyChecked) {
      // 取消选中的逻辑
      if (menuItem.menuType === 3) {
        // 功能点：只取消自己，不影响父级和兄弟节点
        removeCheckedData(menuItem.menuId)
      } else {
        // 菜单/目录：取消自己及所有子菜单
        removeMenuAndChildren(menuItem)
        // 检查是否需要取消父级菜单
        checkParentMenuStatus(menuItem)
      }
    } else {
      // 选中的逻辑
      if (menuItem.menuType === 3) {
        // 功能点：只选中自己，同时确保父级菜单被选中
        addCheckedData(menuItem.menuId)
        selectParentMenus(menuItem)
      } else {
        // 菜单/目录：选中自己及所有子菜单
        addMenuAndChildren(menuItem)
        // 选中所有父级菜单
        selectParentMenus(menuItem)
      }

      // 处理关联菜单
      if (menuItem.contextMenuId) {
        addCheckedData(menuItem.contextMenuId)
      }
    }
  }

  // ==================== 批量操作 ====================

  /**
   * 全选所有菜单
   * @param tree 菜单树
   */
  function selectAllMenus(tree: MenuItem[]) {
    const allMenuIds: number[] = []

    const traverse = (nodes: MenuItem[]) => {
      nodes.forEach((node) => {
        if (node.menuId) {
          allMenuIds.push(node.menuId)
        }
        if (node.children) {
          traverse(node.children)
        }
      })
    }

    traverse(tree)
    checkedData.value = [...new Set(allMenuIds)]
  }

  /**
   * 取消全选
   */
  function deselectAllMenus() {
    checkedData.value = []
  }

  // ==================== 返回 API ====================

  return {
    // 状态
    checkedData,
    treeMap,

    // 计算属性
    checkedCount,
    hasCheckedData,

    // 基础方法
    initCheckedData,
    clearCheckedData,
    addCheckedData,
    removeCheckedData,
    isMenuChecked,

    // 树形结构方法
    initTreeMap,
    getMenuById,

    // 高级选择方法
    addMenuAndChildren,
    removeMenuAndChildren,
    selectParentMenus,
    toggleMenuSelection,

    // 批量操作
    selectAllMenus,
    deselectAllMenus,

    // 兼容旧版本的方法名
    addCheckedDataAndChildren: addMenuAndChildren,
    deleteCheckedDataAndChildren: removeMenuAndChildren,
    selectUpperLevel: selectParentMenus
  }
})

/**
 * 在组件外使用 Store 的辅助函数
 */
export function useRoleStoreOutside() {
  return useRoleStore()
}
