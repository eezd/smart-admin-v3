<script lang="ts" setup>
import type { PositionItem } from "@/common/apis/system/position-api"
import type { FormInstance } from "element-plus"
import { positionApi } from "@/common/apis/system/position-api"
import { useDevice } from "@/common/composables/useDevice"
import { usePagination } from "@/common/composables/usePagination"
import { CirclePlus, Delete, Refresh, RefreshRight, Search } from "@element-plus/icons-vue"
import { cloneDeep } from "lodash-es"
import { reactive } from "vue"
import PositionFormDialog from "./components/PositionFormDialog.vue"

defineOptions({
  name: "PositionManagement"
})

const loading = ref(false)
const { isMobile } = useDevice()

// #region 搜索栏
const searchFormRef = ref<FormInstance>()
const searchData = reactive({
  keywords: undefined
})

const { paginationData, handleCurrentChange, handleSizeChange } = usePagination()
const tableData = ref<PositionItem[]>([])

async function getTableData(params?: any): Promise<void> {
  try {
    loading.value = true
    await positionApi.queryPage({
      pageNum: paginationData.currentPage,
      pageSize: paginationData.pageSize,
      ...params
    }).then(({ data: { total, list } }) => {
      paginationData.total = total
      tableData.value = list
    })
  } catch {
    tableData.value = []
  } finally {
    loading.value = false
  }
}
function resetSearch() {
  searchFormRef.value?.resetFields()
  getTableData()
}
// #endregion

// #region 表单操作
const selectedRows = ref<PositionItem[]>([])
const hasSelectedRows = computed(() => selectedRows.value.length > 0)
const handleSelectionChange = (val: PositionItem[]) => (selectedRows.value = val)

const formDefault: PositionItem = {
  positionId: undefined,
  positionName: undefined,
  level: undefined,
  sort: 0,
  remark: undefined,
  updateTime: undefined,
  createTime: undefined
}
const formData = ref<PositionItem>(cloneDeep(formDefault))
const formDialogVisible = ref<boolean>(false)

async function handleDelete(row: PositionItem | PositionItem[]): Promise<void> {
  try {
    const deleteIds: number[] = []
    let confirmMessage = ""

    if (Array.isArray(row)) {
      const ids = row.map(item => item.positionId).filter((id): id is number => id !== undefined)
      if (ids.length === 0) return
      deleteIds.push(...ids)
      confirmMessage = `正在删除：${row.length} 条数据，确认删除？`
    } else {
      if (row.positionId === undefined) return
      deleteIds.push(row.positionId)
      confirmMessage = `正在删除：${row.positionName}，确认删除？`
    }

    await ElMessageBox.confirm(confirmMessage, "提示", {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning"
    })

    loading.value = true
    const apiCall = deleteIds.length > 1
      ? positionApi.batchDelete(deleteIds)
      : positionApi.delete(deleteIds[0])
    const response = await apiCall

    ElMessage.success(response.msg)
    selectedRows.value = []
    await getTableData()
  } catch (error) {
    if (error !== "cancel") {
      ElMessage.error("删除失败")
    }
  } finally {
    loading.value = false
  }
}
function openCreateDialog() {
  formData.value = cloneDeep(formDefault)
  formDialogVisible.value = true
}
function openUpdateDialog(row: any) {
  formData.value = cloneDeep(row)
  formDialogVisible.value = true
}

// #endregion

// #region 监听
/**
 * 监听分页参数的变化
 */
watch(
  [() => paginationData.currentPage, () => paginationData.pageSize],
  () => {
    getTableData()
  },
  { immediate: true }
)
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
</script>

<template>
  <div class="app-container">
    <!-- 搜索栏 -->
    <el-card v-loading="loading" shadow="never" class="search-wrapper mb-20px">
      <el-form ref="searchFormRef" :inline="true" :model="searchData">
        <el-form-item prop="keywords" label="关键字查询">
          <el-input v-model="searchData.keywords" placeholder="请输入" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="getTableData(searchData)">
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
      <div class="toolbar-wrapper mb-20px">
        <el-button
          type="primary"
          :icon="CirclePlus"
          @click="openCreateDialog()"
        >
          新增
        </el-button>
        <el-button
          type="danger"
          :icon="Delete"
          :disabled="!hasSelectedRows"
          @click="handleDelete(selectedRows)"
        >
          批量删除
        </el-button>
      </div>
      <div class="toolbar-wrapper flex justify-between items-center mb-10px">
        <el-table
          :data="tableData" border :header-cell-style="{
            color: '#000',
            fontWeight: 'bold',
          }" @selection-change="handleSelectionChange"
        >
          <el-table-column type="selection" width="50" />
          <el-table-column prop="positionName" label="职务名称" />
          <el-table-column prop="level" label="职级" />
          <el-table-column prop="sort" label="排序" />
          <el-table-column prop="remark" label="备注" />
          <el-table-column prop="createTime" label="创建时间" />
          <el-table-column fixed="right" label="操作" :width="isMobile ? 100 : 140">
            <template #default="scope">
              <el-button
                type="primary"
                bg
                size="small"
                @click="openUpdateDialog(scope.row)"
              >
                修改
              </el-button>
              <el-button
                type="danger"
                bg
                size="small"
                :style="isMobile ? 'margin: 10px 0 0 0' : ''"
                @click="handleDelete(scope.row)"
              >
                删除
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>

      <div class="pager-wrapper">
        <el-pagination
          background
          :layout="paginationData.layout"
          :page-sizes="paginationData.pageSizes"
          :total="paginationData.total"
          :page-size="paginationData.pageSize"
          :current-page="paginationData.currentPage"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>

    <!-- 数据弹窗 -->
    <PositionFormDialog
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
  :deep(.el-card__body) {
    padding-bottom: 2px;
  }
}

.pager-wrapper {
  display: flex;
  justify-content: flex-end;
}
</style>
