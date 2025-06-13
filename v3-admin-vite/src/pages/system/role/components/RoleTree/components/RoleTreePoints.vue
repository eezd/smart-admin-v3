<!--
  * 功能点组件
  * 负责渲染功能点列表
-->
<script setup lang="ts">
import type { MenuItem } from "@/common/apis/system/menu-api"
import { useRoleStore } from "@/pinia/stores/role"

interface Props {
  points: MenuItem[]
}

interface Emits {
  (e: "togglePoint", point: MenuItem): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

// Store
const roleStore = useRoleStore()

/**
 * 检查功能点是否被选中
 */
function isPointChecked(menuId?: number): boolean {
  return menuId ? roleStore.checkedData.includes(menuId) : false
}

/**
 * 处理功能点切换
 */
function handlePointToggle(point: MenuItem) {
  emit("togglePoint", point)
}
</script>

<template>
  <div class="points-container">
    <div class="bg-blue-50 border border-blue-200 rounded-md p-3">
      <div class="text-xs text-blue-600 font-medium mb-2">
        功能权限
      </div>
      <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-2">
        <div
          v-for="point in points"
          :key="point.menuId"
          class="flex items-center"
        >
          <el-checkbox
            :value="point.menuId"
            :checked="isPointChecked(point.menuId)"
            size="small"
            @change="handlePointToggle(point)"
          >
            <span class="text-xs text-gray-600 truncate max-w-20" :title="point.menuName">
              {{ point.menuName }}
            </span>
          </el-checkbox>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.points-container {
  margin-top: 8px;
}

.max-w-20 {
  max-width: 5rem;
}
</style>
