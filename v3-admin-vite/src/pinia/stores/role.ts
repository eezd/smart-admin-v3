import type { MenuItem } from "@/common/apis/system/menu-api"
import { defineStore } from "pinia"

export const useRoleStore = defineStore("role", () => {
  // 状态定义
  const checkedData: Ref<number[]> = ref([])
  const treeMap: Ref<Map<number, MenuItem>> = ref(new Map())

  // 操作方法
  const initCheckedData = (data: number[]) => {
    checkedData.value = [...new Set(data)]
  }

  const addCheckedData = (data: number) => {
    if (!checkedData.value.includes(data)) {
      checkedData.value.push(data)
    }
  }

  const deleteCheckedData = (index: number) => {
    checkedData.value.splice(index, 1)
  }

  const addCheckedDataAndChildren = (data: MenuItem) => {
    if (data.menuId && !checkedData.value.includes(data.menuId)) {
      addCheckedData(data.menuId)
    }
    data.children?.forEach((child: MenuItem) => addCheckedDataAndChildren(child))
  }

  const deleteCheckedDataAndChildren = (data: MenuItem) => {
    const index = checkedData.value.findIndex(val => val === data.menuId)
    if (index !== -1) {
      deleteCheckedData(index)
    }
    data.children?.forEach((child: MenuItem) => deleteCheckedDataAndChildren(child))
  }

  const initTreeMap = (tree: MenuItem[]) => {
    treeMap.value.clear()
    const traverse = (nodes: MenuItem[]) => {
      nodes.forEach((node) => {
        if (node.menuId) {
          treeMap.value.set(node.menuId, node)
          node.children && traverse(node.children)
        }
      })
    }
    traverse(tree)
  }

  const selectUpperLevel = (module: MenuItem) => {
    const findParent = (current: MenuItem) => {
      if (!current.parentId) return
      const parent = treeMap.value.get(current.parentId)
      if (!parent) return

      if (parent.menuId && !checkedData.value.includes(parent.menuId)) {
        addCheckedData(parent.menuId)
      }

      if (parent.parentId) {
        findParent(parent)
      }
    }

    findParent(module)
  }

  return {
    // 状态
    checkedData,
    treeMap,

    // 方法
    initCheckedData,
    addCheckedData,
    deleteCheckedData,
    addCheckedDataAndChildren,
    deleteCheckedDataAndChildren,
    initTreeMap,
    selectUpperLevel
  }
})

// SSR/SPA 辅助函数
export function useRoleStoreOutside() {
  return useRoleStore()
}
