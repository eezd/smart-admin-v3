<!--
  * 递归菜单组件
  * 负责渲染菜单项和子菜单
-->
<script setup lang="ts">
import type { MenuItem } from "@/common/apis/system/menu-api"
import { MENU_TYPE_ENUM } from "@/common/constants/system/menu-const"
import { useRoleStore } from "@/pinia/stores/role"
import RoleTreePoints from "./RoleTreePoints.vue"

interface Props {
  menuItem: MenuItem
  level: number
}

interface Emits {
  (e: "toggleMenu", menuItem: MenuItem): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

// Store
const roleStore = useRoleStore()

// 计算属性
const isChecked = computed(() =>
  props.menuItem.menuId ? roleStore.checkedData.includes(props.menuItem.menuId) : false
)

// 子菜单（非功能点）
const subMenuChildren = computed(() =>
  props.menuItem.children?.filter(child =>
    child.menuType !== MENU_TYPE_ENUM.POINTS.value
  ) || []
)

// 功能点子项
const pointChildren = computed(() =>
  props.menuItem.children?.filter(child =>
    child.menuType === MENU_TYPE_ENUM.POINTS.value
  ) || []
)

// 是否有子菜单
const hasSubMenus = computed(() => subMenuChildren.value.length > 0)

// 是否有功能点
const hasPoints = computed(() => pointChildren.value.length > 0)

/**
 * 处理选择切换
 */
function handleToggle() {
  emit("toggleMenu", props.menuItem)
}

/**
 * 处理功能点切换
 */
function handlePointToggle(point: MenuItem) {
  emit("toggleMenu", point)
}
</script>

<template>
  <div class="menu-item" :style="{ paddingLeft: `${level * 20}px` }">
    <!-- 菜单项 -->
    <div class="flex items-center py-2 px-3 hover:bg-gray-50 rounded-md transition-colors">
      <el-checkbox
        :value="menuItem.menuId"
        :checked="isChecked"
        class="mr-2"
        @change="handleToggle"
      >
        <span class="text-sm font-medium text-gray-700">
          {{ menuItem.menuName }}
        </span>
      </el-checkbox>

      <!-- 菜单图标 -->
      <el-icon v-if="menuItem.menuIcon" class="ml-2 text-gray-400">
        <component :is="menuItem.menuIcon" />
      </el-icon>
    </div>

    <!-- 功能点 -->
    <div v-if="hasPoints" class="ml-6 mt-2">
      <RoleTreePoints
        :points="pointChildren"
        @toggle-point="handlePointToggle"
      />
    </div>

    <!-- 子菜单 -->
    <div v-if="hasSubMenus" class="ml-2">
      <RoleTreeMenu
        v-for="subMenu in subMenuChildren"
        :key="subMenu.menuId"
        :menu-item="subMenu"
        :level="level + 1"
        @toggle-menu="$emit('toggleMenu', $event)"
      />
    </div>
  </div>
</template>

<style scoped>
.menu-item {
  transition: all 0.2s ease;
}

.menu-item:hover {
  background-color: rgba(0, 0, 0, 0.02);
}
</style>
