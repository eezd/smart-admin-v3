<script lang="ts" setup>
import type { EmployeeItem } from "@/common/apis/system/employee-api"
import type { FormInstance } from "element-plus"
import { employeeApi } from "@/common/apis/system/employee-api"
import { useDevice } from "@/common/composables/useDevice"
import { usePagination } from "@/common/composables/usePagination"
import { GENDER_ENUM } from "@@/constants/common-const"
import { CirclePlus, Delete, Refresh, Search } from "@element-plus/icons-vue"
import { cloneDeep } from "lodash-es"
import { reactive } from "vue"
// import DepartmentTreeDialog from "./DepartmentTreeDialog.vue"
// import EmployeeFormDialog from "./EmployeeFormDialog.vue"

defineOptions({
  name: "PositionManagement"
})

const loading = ref(false)
const { isMobile } = useDevice()

// #region 搜索栏
const searchFormRef = ref<FormInstance>()
const searchData = reactive({
  disabledFlag: undefined,
  keyword: undefined
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
  employeeId: undefined,
  actualName: undefined,
  departmentId: 0,
  disabledFlag: false,
  leaveFlag: false,
  gender: GENDER_ENUM.MAN.value,
  loginName: undefined,
  phone: undefined,
  roleIdList: undefined,
  positionId: undefined,
  email: undefined
}
const formData = ref<EmployeeItem>(cloneDeep(formDefault))
const formDialogVisible = ref<boolean>(false)

async function handleDelete(row: EmployeeItem | EmployeeItem[]): Promise<void> {
  try {
    const deleteIds: number[] = []
    let confirmMessage = ""

    if (Array.isArray(row)) {
      const ids = row.map(item => item.employeeId).filter((id): id is number => id !== undefined)
      if (ids.length === 0) return
      deleteIds.push(...ids)
      confirmMessage = `正在删除：${row.length} 条数据，确认删除？`
    } else {
      if (row.employeeId === undefined) return
      deleteIds.push(row.employeeId)
      confirmMessage = `正在删除：${row.loginName}，确认删除？`
    }

    await ElMessageBox.confirm(confirmMessage, "提示", {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning"
    })

    loading.value = true
    const response = await employeeApi.batchDelete(deleteIds)

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
// #endregion

// #region 数据弹窗监听
/**
 * 弹窗提交执行
 */
function handleSubmitSuccess() {
  getTableData()
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
watch(
  [() => searchData.disabledFlag],
  () => {
    getTableData(searchData)
  }
)
// #endregion
</script>

<template>
  <div>
    <!-- 表单 -->
    <el-card v-loading="loading" shadow="never">
      <div class="flex justify-between items-center mb-10px">
        <span>部门人员</span>
        <el-form ref="searchFormRef" :inline="true" :model="searchData">
          <el-form-item label="" prop="disabledFlag">
            <el-radio-group v-model="searchData.disabledFlag" size="default">
              <el-radio value="">
                全部
              </el-radio>
              <el-radio :value="0">
                启用
              </el-radio>
              <el-radio :value="1">
                禁用
              </el-radio>
            </el-radio-group>
          </el-form-item>

          <el-form-item prop="keyword" label="">
            <el-input v-model="searchData.keyword" placeholder="请输入" />
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
          <el-table-column prop="actualName" label="姓名"/>
          <el-table-column prop="loginName" label="登录账号" />
          <el-table-column prop="phone" label="手机号"  />
          <el-table-column prop="disabledFlag" label="状态" width="70">
            <template #default="scope">
              <el-tag :type="scope.row.disabledFlag ? 'danger' : 'primary'">
                {{ scope.row.disabledFlag ? '禁用' : '启用' }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="departmentName" label="部门"  />
          <el-table-column fixed="right" label="操作" width="60">
            <template #default="scope">
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
    <!-- <EmployeeFormDialog
      v-model:loading="loading"
      v-model:form-dialog-visible="formDialogVisible"
      v-model:form-data="formData"
      @submit-success="handleSubmitSuccess"
    /> -->
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
