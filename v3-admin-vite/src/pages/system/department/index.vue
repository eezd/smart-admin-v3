<script lang="ts" setup>
import type { DepartmentItem } from "@@/apis/system/department-api"
import type { FormInstance } from "element-plus"
import { departmentApi } from "@@/apis/system/department-api"
import { Refresh, Search } from "@element-plus/icons-vue"
import { cloneDeep } from "lodash-es"
import { reactive } from "vue"

import DepartmentDialog from "./components/DepartmentDialog.vue"

defineOptions({
  name: "DepartmentManagement"
})

const loading = ref(false)

// #region 搜索栏
const searchFormRef = ref<FormInstance | null>(null)
const searchData = reactive<any>({
  keywords: undefined
})

const departmentData = ref<any[]>([])
const departmentTreeData = ref<any[]>([])

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
const formDefault: DepartmentItem = {
  departmentId: undefined,
  name: "",
  managerId: undefined,
  managerName: "",
  parentId: 0,
  sort: 0,
  updateTime: undefined,
  createTime: undefined
}
const formData = ref<DepartmentItem>(cloneDeep(formDefault))
const formDialogVisible = ref<boolean>(false)

async function handleDelete(row: any) {
  try {
    let confirmMessage = ""
    confirmMessage = `正在删除：${row.name}，确认删除？`
    await ElMessageBox.confirm(confirmMessage, "提示", {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning"
    })
    loading.value = true
    const response = await departmentApi.delete(row.departmentId)
    ElMessage.success(response.msg)
    await getTableData()
  } catch (error) {
    if (error !== "cancel") {
      ElMessage.error("删除失败")
    }
  } finally {
    loading.value = false
  }
}
function openCreateDialog(departmentId?: number) {
  formData.value = cloneDeep(formDefault)
  formData.value.parentId = departmentId || 0
  formDialogVisible.value = true
}
function openUpdateDialog(row: any) {
  formData.value = cloneDeep(row)
  formDialogVisible.value = true
}
// #endregion

// #region 数据弹窗监听
/**
 * 弹窗提交执行
 */
function handleSubmitSuccess() {
  getTableData()
}
/**
 * 弹窗关闭执行
 */
function handleSubmitCancel() {
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
