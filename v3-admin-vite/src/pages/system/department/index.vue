<script lang="ts" setup>
import type { FormInstance } from "element-plus"
import { useDevice } from "@/common/composables/useDevice"
import { departmentApi } from "@@/apis/system/department-api"
import { Refresh, Search } from "@element-plus/icons-vue"
import { cloneDeep } from "lodash-es"
import { reactive } from "vue"

import DepartmentDialog from "./components/DepartmentDialog.vue"

// defineOptions({
//   name: "SysManagement"
// })

const departmentData = ref<any[]>([])
const departmentTreeData = ref<any[]>([])

const loading = ref(false)

// 表单数据
const formData = ref<Partial<any> & Partial<any>>(cloneDeep({}))
// 数据弹窗
const formDialogVisible = ref<boolean>(false)

const { isMobile } = useDevice()

// #region 搜索栏
const searchFormRef = ref<FormInstance | null>(null)
const searchData = reactive({
  keywords: undefined
} as any)
/**
 * 获取表格数据
 */
async function getTableData(): Promise<void> {
  try {
    loading.value = true
    await departmentApi.queryTree().then(({ data }) => {
      departmentTreeData.value = data
    })
    await departmentApi.queryList().then(({ data }) => {
      departmentData.value = data
    })
  } catch {
    departmentTreeData.value = []
    departmentData.value = []
  } finally {
    loading.value = false
  }
}

// 递归过滤树形数据
function filterTreeData(data: any[], keywords: string): any[] {
  return data.filter((node) => {
    if (node.name.includes(keywords)) return true
    if (node.children?.length) {
      node.children = filterTreeData(node.children, keywords)
      return node.children.length > 0
    }
    return false
  })
}

// 处理搜索
function handleSearch() {
  if (!searchData.keywords) {
    getTableData()
    return
  }

  const filteredData = filterTreeData(departmentTreeData.value, searchData.keywords)
  departmentTreeData.value = filteredData
}

function resetSearch() {
  searchFormRef.value?.resetFields()
  getTableData()
}
// #endregion

// #region 表单操作

/**
 * 删除
 *
 * @param row
 */
function handleDelete(row: any) {
  let msg = ""
  msg = `正在删除：${row.name}，确认删除？`
  ElMessageBox.confirm(msg, "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning"
  }).then(() => {
    loading.value = true
    departmentApi.delete(row.departmentId).then((res) => {
      ElMessage.success(res.msg)
      getTableData()
    }).finally(() => {
      loading.value = false
    })
  }).catch(() => {})
}

/**
 * 打开添加弹窗
 */
function openCreateDialog(departmentId?: number) {
  // resetForm()
  formDialogVisible.value = true
  formData.value = cloneDeep({})
  formData.value.parentId = departmentId
}

/**
 * 打开修改弹窗
 *
 * @param row
 */
function openUpdateDialog(row: any) {
  formDialogVisible.value = true
  formData.value = cloneDeep(row)
}

// #endregion

// #region 监听
// 父组件监听子组件事件
function handleSubmitSuccess() {
  getTableData()
}

function handleSubmitCancel() {
  // 取消提交，不做任何操作
}
// #endregion

getTableData()
</script>

<template>
  <div class="app-container">
    <!-- 搜索栏 -->
    <el-card v-loading="loading" shadow="never" class="search-wrapper">
      <el-form ref="searchFormRef" :inline="true" :model="searchData">
        <el-form-item prop="keywords" label="部门名称">
          <el-input v-model="searchData.keywords" placeholder="请输入部门名称" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="handleSearch">
            查询
          </el-button>
          <el-button :icon="Refresh" @click="resetSearch">
            重置
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 表单 -->
    <el-card v-loading="loading" shadow="never">
      <el-table
        :data="departmentTreeData"
        row-key="departmentId"
        border
        default-expand-all
        :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
      >
        <el-table-column prop="name" label="部门名称" width="220" />
        <el-table-column prop="managerName" label="部门负责人" width="180" />
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column prop="createTime" label="创建时间" width="180" />
        <el-table-column prop="updateTime" label="更新时间" width="180" />
        <el-table-column fixed="right" label="操作" width="220">
          <template #default="scope">
            <el-button type="primary" size="small" @click="openCreateDialog(scope.row.departmentId)">
              添加下级
            </el-button>
            <el-button type="primary" size="small" @click="openUpdateDialog(scope.row)">
              编辑
            </el-button>
            <el-button type="danger" size="small" @click="handleDelete(scope.row)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 数据弹窗 -->
    <DepartmentDialog
      v-model:loading="loading"
      v-model:form-dialog-visible="formDialogVisible"
      v-model:form-data="formData"
      @submit-success="handleSubmitSuccess"
      @submit-cancel="handleSubmitCancel"
    />
  </div>
</template>

<style lang="scss" scoped>
.search-wrapper {
  margin-bottom: 20px;
  :deep(.el-card__body) {
    padding-bottom: 2px;
  }
}

.toolbar-wrapper {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
}

.table-wrapper {
  margin-bottom: 20px;
}

.pager-wrapper {
  display: flex;
  justify-content: flex-end;
}
</style>
