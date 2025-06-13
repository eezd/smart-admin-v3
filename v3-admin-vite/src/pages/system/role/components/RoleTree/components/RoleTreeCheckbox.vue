<!--
  * 权限树复选框组件
  * 负责渲染树形结构的复选框界面
-->
<script setup lang="ts">
import type { MenuItem } from "@/common/apis/system/menu-api"
import { useRoleStore } from "@/pinia/stores/role"
import { computed } from "vue"
import RoleTreeMenu from "./RoleTreeMenu.vue"

interface Props {
  tree: MenuItem[]
  loading?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  loading: false
})

// Store
const roleStore = useRoleStore()

// 计算属性 - 选中的菜单ID列表
const checkedMenuIds = computed({
  get: () => roleStore.checkedData,
  set: (value: number[]) => {
    // Element Plus checkbox-group 的双向绑定会触发这里
    // 但我们通过自定义的 handleMenuToggle 来处理选择逻辑
  }
})

/**
 * 处理菜单选择切换
 */
function handleMenuToggle(menuItem: MenuItem) {
  roleStore.toggleMenuSelection(menuItem)
}
</script>

<template>
  <div class="h-full overflow-auto p-4">
    <el-checkbox-group
      v-model="checkedMenuIds"
      class="w-full"
      :disabled="loading"
    >
      <div class="space-y-2">
        <RoleTreeMenu
          v-for="menuItem in tree"
          :key="menuItem.menuId"
          :menu-item="menuItem"
          :level="0"
          @toggle-menu="handleMenuToggle"
        />
      </div>
    </el-checkbox-group>
  </div>
</template>
