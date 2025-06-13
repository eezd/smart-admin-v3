<script setup lang="ts">
import type { Ref } from "vue"
import { roleApi } from "@/common/apis/system/role-api"
import { smartSentry } from "@/lib/smart-sentry"
import { ElMessage } from "element-plus"
import { inject, onMounted, ref, watch } from "vue"

// 类型定义
interface ViewType {
  viewType: number
  viewTypeName: string
}

interface DataScopeItem {
  dataScopeType: number
  dataScopeTypeName: string
  dataScopeTypeDesc: string
  viewTypeList: ViewType[]
}

interface SelectedDataScope {
  viewType: number | undefined
  dataScopeType: number
}

// Props 定义
interface Props {
  value?: number
}

const props = withDefaults(defineProps<Props>(), {
  value: 0
})

// Emits 定义
const emit = defineEmits<{
  "update:value": [value: number]
}>()

// 响应式数据
const selectRoleId = inject<Ref<number>>("selectRoleId")!
const dataScopeList = ref<DataScopeItem[]>([])
const selectedDataScopeList = ref<SelectedDataScope[]>([])
const loading = ref(false)
const saveLoading = ref(false)

// 监听角色ID变化
watch(
  () => selectRoleId.value,
  (newRoleId) => {
    if (newRoleId) {
      getRoleDataScope()
    }
  },
  { immediate: true }
)

// 生命周期
onMounted(() => {
  getDataScope()
})

/**
 * 获取系统支持的所有数据范围类型
 */
async function getDataScope(): Promise<void> {
  try {
    loading.value = true
    const result = await roleApi.getDataScopeList()

    if (result.data) {
      dataScopeList.value = result.data
      initSelectedDataScopeList()

      if (selectRoleId.value) {
        await getRoleDataScope()
      }
    }
  } catch (error) {
    ElMessage.error("获取数据范围失败")
    smartSentry.captureError(error)
  } finally {
    loading.value = false
  }
}

/**
 * 初始化选中的数据范围列表
 */
function initSelectedDataScopeList(): void {
  selectedDataScopeList.value = dataScopeList.value.map(item => ({
    viewType: undefined,
    dataScopeType: item.dataScopeType
  }))
}

/**
 * 根据角色ID获取数据范围配置
 */
async function getRoleDataScope(): Promise<void> {
  if (!selectRoleId.value) {
    return
  }

  try {
    const result = await roleApi.getDataScopeByRoleId(selectRoleId.value)
    const roleDataScopes = result.data || []

    selectedDataScopeList.value = dataScopeList.value.map((item) => {
      const existingScope = roleDataScopes.find(
        scope => scope.dataScopeType === item.dataScopeType
      )

      return {
        viewType: existingScope?.viewType,
        dataScopeType: item.dataScopeType
      }
    })
  } catch (error) {
    ElMessage.error("获取角色数据范围失败")
    smartSentry.captureError(error)
  }
}

/**
 * 更新数据范围配置
 */
async function handleUpdateDataScope(): Promise<void> {
  if (!selectRoleId.value) {
    ElMessage.warning("请先选择角色")
    return
  }

  try {
    saveLoading.value = true

    const updateData = {
      roleId: selectRoleId.value,
      dataScopeItemList: selectedDataScopeList.value.filter(
        item => item.viewType !== undefined
      )
    }

    await roleApi.updateDataScope(updateData)
    ElMessage.success("保存成功")

    // 重新获取数据以确保数据同步
    await getDataScope()
  } catch (error) {
    ElMessage.error("保存失败")
    smartSentry.captureError(error)
  } finally {
    saveLoading.value = false
  }
}

/**
 * 刷新数据
 */
async function handleRefresh(): Promise<void> {
  await getDataScope()
  ElMessage.success("刷新成功")
}
</script>

<template>
  <div class="role-data-scope">
    <!-- 操作按钮组 -->
    <div class="flex justify-end mb-4 gap-3">
      <el-button
        v-privilege="'system:role:dataScope:update'"
        type="primary"
        :loading="saveLoading"
        @click="handleUpdateDataScope"
      >
        保存
      </el-button>
      <el-button @click="handleRefresh">
        刷新
      </el-button>
    </div>

    <!-- 表头 -->
    <div class="grid grid-cols-12 gap-4 py-3 border-b border-gray-200 font-semibold bg-gray-50">
      <div class="col-span-3 text-center">
        业务单据
      </div>
      <div class="col-span-6 text-center">
        查看数据范围
      </div>
      <div class="col-span-3 text-center">
        说明
      </div>
    </div>

    <!-- 数据列表 -->
    <div class="max-h-170 overflow-y-auto">
      <div
        v-for="(item, index) in dataScopeList"
        :key="item.dataScopeType"
        class="grid grid-cols-12 gap-4 py-4 border-b border-gray-100 items-center"
      >
        <!-- 业务单据名称 -->
        <div class="col-span-3 text-center font-medium">
          {{ item.dataScopeTypeName }}
        </div>

        <!-- 数据范围选项 -->
        <div class="col-span-6">
          <el-radio-group
            v-model="selectedDataScopeList[index].viewType"
            class="flex flex-col gap-2"
          >
            <el-radio
              v-for="scope in item.viewTypeList"
              :key="`${item.dataScopeType}-${scope.viewType}`"
              :value="scope.viewType"
              class="h-8 leading-8 "
            >
              {{ scope.viewTypeName }}
            </el-radio>
          </el-radio-group>
        </div>

        <!-- 描述信息 -->
        <div class="col-span-3 text-sm text-gray-600 leading-relaxed">
          {{ item.dataScopeTypeDesc }}
        </div>
      </div>
    </div>

    <!-- 空状态 -->
    <el-empty
      v-if="!dataScopeList.length && !loading"
      description="暂无数据范围配置"
      class="my-8"
    />
  </div>
</template>

<style scoped>
.role-data-scope {
  @apply p-4 bg-white rounded-lg;
}

/* 自定义滚动条样式 */
.max-h-170 {
  max-height: 680px;
}

.max-h-170::-webkit-scrollbar {
  @apply w-1;
}

.max-h-170::-webkit-scrollbar-track {
  @apply bg-gray-100 rounded;
}

.max-h-170::-webkit-scrollbar-thumb {
  @apply bg-gray-300 rounded hover:bg-gray-400;
}
</style>
