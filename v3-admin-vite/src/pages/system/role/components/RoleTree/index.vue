<!--
  * 角色权限树形结构管理
  * 重构版本：使用 Vue 3.5 + Element Plus + UnoCSS + TypeScript
-->
<script setup lang="ts">
import type { MenuItem } from "@/common/apis/system/menu-api"
import { roleMenuApi } from "@/common/apis/system/role-menu-api"
import { useRoleStore } from "@/pinia/stores/role"
import { ElLoading, ElMessage } from "element-plus"
import { isEmpty } from "lodash-es"
import { computed, inject, ref, watch } from "vue"
import RoleTreeCheckbox from "./components/RoleTreeCheckbox.vue"

// Store
const roleStore = useRoleStore()

// 响应式数据
const menuTree = ref<MenuItem[]>([])
const loading = ref(false)

// 注入的角色ID
const selectRoleId = inject<Ref<number | null>>("selectRoleId", ref(null))

// 计算属性
const hasSelectedRole = computed(() => Boolean(selectRoleId?.value))

// 监听角色ID变化，获取权限数据
watch(
  selectRoleId,
  async (newRoleId) => {
    if (newRoleId) {
      await fetchRoleMenuData()
    } else {
      resetData()
    }
  },
  { immediate: true }
)

/**
 * 获取角色权限数据
 */
async function fetchRoleMenuData() {
  if (!selectRoleId?.value) return

  loading.value = true
  try {
    const response = await roleMenuApi.getRoleSelectedMenu(selectRoleId.value)
    const { menuTreeList = [], selectedMenuId = [] } = response.data

    // 初始化树形映射
    if (isEmpty(roleStore.treeMap)) {
      roleStore.initTreeMap(menuTreeList)
    }

    // 初始化选中数据
    roleStore.initCheckedData(selectedMenuId)
    menuTree.value = menuTreeList
  } catch (error) {
    console.error("获取角色权限数据失败:", error)
    ElMessage.error("获取权限数据失败")
  } finally {
    loading.value = false
  }
}

/**
 * 保存权限变更
 */
async function handleSaveChange() {
  const checkedMenuIds = roleStore.checkedData

  if (isEmpty(checkedMenuIds)) {
    ElMessage.warning("请至少选择一项权限")
    return
  }

  if (!selectRoleId?.value) {
    ElMessage.error("未选择角色")
    return
  }

  const loadingInstance = ElLoading.service({
    lock: true,
    text: "保存中...",
    background: "rgba(0, 0, 0, 0.7)"
  })

  try {
    await roleMenuApi.updateRoleMenu({
      roleId: selectRoleId.value,
      menuIdList: checkedMenuIds
    })
    // console.log({ roleId: selectRoleId.value, menuIdList: checkedMenuIds })

    ElMessage.success("权限保存成功")
  } catch (error) {
    console.error("保存权限失败:", error)
    ElMessage.error("保存权限失败，请重试")
  } finally {
    loadingInstance.close()
  }
}

/**
 * 重置数据
 */
function resetData() {
  menuTree.value = []
  roleStore.clearCheckedData()
}
</script>

<template>
  <div class="h-full flex flex-col">
    <!-- 头部操作区域 -->
    <div class="flex items-center justify-between p-4 bg-gray-50 border-b border-gray-200">
      <div class="text-gray-600 text-sm">
        设置角色对应的功能操作、后台管理权限
      </div>
      <el-button
        v-if="selectRoleId"
        type="primary"
        :loading="loading"
        @click="handleSaveChange"
      >
        保存更改
      </el-button>
    </div>

    <!-- 权限树内容区域 -->
    <div class="flex-1 overflow-hidden">
      <RoleTreeCheckbox
        v-if="menuTree.length > 0"
        :tree="menuTree"
        :loading="loading"
      />
      <div v-else class="flex items-center justify-center h-full text-gray-400">
        <el-empty description="暂无权限数据" />
      </div>
    </div>
  </div>
</template>
