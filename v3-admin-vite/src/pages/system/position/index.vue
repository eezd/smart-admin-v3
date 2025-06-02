<script lang="ts" setup>
import type { FormInstance } from "element-plus"
import { positionApi } from "@/common/apis/system/position-api"
import { useDevice } from "@/common/composables/useDevice"
import { usePagination } from "@/common/composables/usePagination"
import { CirclePlus, Delete, Refresh, RefreshRight, Search } from "@element-plus/icons-vue"
import { cloneDeep } from "lodash-es"
import { reactive } from "vue"
import PositionFormDialog from "./components/PositionFormDialog.vue"

// defineOptions({
//   name: "SysManagement"
// })

const loading = ref(false)
// 表格数据
const tableData = ref<any[]>([])
// 分页
const { paginationData, handleCurrentChange, handleSizeChange } = usePagination()

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
const selectedRows = ref<any[]>([])
const handleSelectionChange = (val: any[]) => (selectedRows.value = val)

/**
 * 删除
 *
 * @param row
 */
function handleDelete(row: any | any[]) {
  let del_id: number[] = []
  let msg = ""
  if (Array.isArray(row)) {
    del_id = row.map(item => item.positionId)
    msg = `正在删除：${row.length} 条数据，确认删除？`
  } else {
    del_id.push(row.positionId)
    msg = `正在删除：${row.positionName}，确认删除？`
  }

  ElMessageBox.confirm(msg, "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning"
  }).then(() => {
    loading.value = true
    const apiCall = del_id.length > 1
      ? positionApi.batchDelete(del_id)
      : positionApi.delete(del_id[0])

    apiCall.then((res) => {
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
function openCreateDialog() {
  // resetForm()
  formDialogVisible.value = true
  formData.value = cloneDeep({})
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

// 父组件监听子组件事件
function handleSubmitSuccess() {
  getTableData()
}

function handleSubmitCancel() {
  // 取消提交，不做任何操作
}
// #endregion
</script>

<template>
  <div class="app-container">
    <!-- 搜索栏 -->
    <el-card v-loading="loading" shadow="never" class="search-wrapper">
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
      <div class="toolbar-wrapper" :style="isMobile ? 'flex-direction: row; gap: 15px' : ''">
        <div>
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
            @click="handleDelete(selectedRows)"
          >
            批量删除
          </el-button>
        </div>
        <div>
          <el-tooltip content="刷新当前页">
            <el-button type="primary" :icon="RefreshRight" circle @click="() => getTableData()" />
          </el-tooltip>
        </div>
      </div>
      <div class="table-wrapper">
        <el-table
          :data="tableData" border :header-cell-style="{
            color: '#000', // 白色文字
            fontWeight: 'bold', // 加粗
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
