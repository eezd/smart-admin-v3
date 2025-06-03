<script lang="ts" setup>
import type { EmployeeItem } from "@/common/apis/system/employee-api"
import type { FormInstance } from "element-plus"
import { employeeApi } from "@/common/apis/system/employee-api"
import { useDevice } from "@/common/composables/useDevice"
import { usePagination } from "@/common/composables/usePagination"
import { GENDER_ENUM } from "@@/constants/common-const"
import { CirclePlus, Delete, Refresh, RefreshRight, Search } from "@element-plus/icons-vue"
import { cloneDeep } from "lodash-es"
import { reactive } from "vue"
import EmployeeFormDialog from "./EmployeeFormDialog.vue"

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
const tableData = ref<EmployeeItem[]>([])

async function getTableData(params?: any): Promise<void> {
  try {
    loading.value = true
    await employeeApi.queryPage({
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
const selectedRows = ref<EmployeeItem[]>([])
const hasSelectedRows = computed(() => selectedRows.value.length > 0)
const handleSelectionChange = (val: EmployeeItem[]) => (selectedRows.value = val)

const formDefault: EmployeeItem = {
  positionId: undefined,
  positionName: undefined,
  level: undefined,
  sort: 0,
  remark: undefined,
  updateTime: undefined,
  createTime: undefined
}
const formData = ref<EmployeeItem>(cloneDeep(formDefault))
const formDialogVisible = ref<boolean>(false)

async function handleDelete(row: EmployeeItem | EmployeeItem[]): Promise<void> {
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
      ? employeeApi.batchDelete(deleteIds)
      : employeeApi.delete(deleteIds[0])
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
function openUpdateDepartmentDialog() {
  // formData.value = cloneDeep(formDefault)
  // formDialogVisible.value = true
}
function openUpdateDialog(row: any) {
  formData.value = cloneDeep(row)
  formDialogVisible.value = true
}
function resetPassword(row: any) {
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
  <div>
    <!-- 表单 -->
    <el-card v-loading="loading" shadow="never">
      <div class="flex justify-between items-center mb-10px">
        <span>部门人员</span>
        <el-form ref="searchFormRef" :inline="true" :model="searchData">
          <!-- <el-form-item label="" prop="disabledFlag">
            <el-radio-group v-model="searchData.disabledFlag" size="default">
              <el-radio-button
              >
                {{ item.desc }}
              </el-radio-button>
            </el-radio-group>
          </el-form-item> -->
          <el-form-item prop="keywords" label="">
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
      </div>

      <div class="toolbar-wrapper mb-20px">
        <el-button
          type="primary"
          :icon="CirclePlus"
          @click="openCreateDialog()"
        >
          新增
        </el-button>
        <el-button
          type="warning"
          :icon="CirclePlus"
          @click="openUpdateDepartmentDialog()"
        >
          批量调整部门
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
          }"
          align="center"
          @selection-change="handleSelectionChange"
        >
          <el-table-column type="selection" width="50" />
          <el-table-column prop="actualName" label="姓名" width="120" />
          <el-table-column prop="gender" label="性别" width="70">
            <template #default="scope">
              {{ Object.values(GENDER_ENUM).find(item => item.value === scope.row.gender)?.desc || '未知' }}
            </template>
          </el-table-column>
          <el-table-column prop="loginName" label="登录账号" width="120" />
          <el-table-column prop="phone" label="手机号" width="115" />
          <el-table-column prop="email" label="邮箱" width="160" />
          <el-table-column prop="administratorFlag" label="超管" width="70">
            <template #default="scope">
              <el-tag v-if="scope.row.administratorFlag" type="danger">
                超管
              </el-tag>
              <span v-else />
            </template>
          </el-table-column>
          <el-table-column prop="disabledFlag" label="状态" width="70">
            <template #default="scope">
              <el-tag :type="scope.row.disabledFlag ? 'danger' : 'primary'">
                {{ scope.row.disabledFlag ? '禁用' : '启用' }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="positionName" label="职务" width="150" />
          <el-table-column prop="roleNameList" label="角色" width="150" />
          <el-table-column prop="departmentName" label="部门" width="250" />
          <el-table-column fixed="right" label="操作" width="220">
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
                type="warning"
                bg
                size="small"
                @click="resetPassword(scope.row)"
              >
                重置密码
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
    <EmployeeFormDialog
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
