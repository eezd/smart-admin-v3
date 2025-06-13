<script lang="ts" setup>
import type { RoleItem } from "@/common/apis/system/role-api"
import type { FormInstance } from "element-plus"
import { roleApi } from "@/common/apis/system/role-api"
import { useDevice } from "@/common/composables/useDevice"
import { CirclePlus, Delete, Edit, MoreFilled, Refresh, Search } from "@element-plus/icons-vue"
import { cloneDeep } from "lodash-es"
import { reactive } from "vue"
import RoleFormDialog from "./RoleFormDialog.vue"

// #region defineModel
const loading = defineModel<boolean>("loading", { required: true })
const roleId = defineModel<number | undefined>("roleId", { default: undefined })
// #endregion

const { isMobile } = useDevice()

// #region 搜索栏
const tableData = ref<RoleItem[] | any>([])

async function getTableData(): Promise<void> {
  try {
    loading.value = true
    await roleApi.queryAll().then(({ data }) => {
      tableData.value = data
      if (roleId.value === undefined && tableData.value.length > 0) {
        roleId.value = tableData.value[0].roleId
      }
    })
  } catch {
    tableData.value = []
  } finally {
    loading.value = false
  }
}
// #endregion

// #region 表单操作
const formDefault: RoleItem = {
  roleId: undefined,
  roleName: undefined,
  roleCode: undefined,
  remark: undefined
}
const formData = ref<RoleItem>(cloneDeep(formDefault))
const formDialogVisible = ref<boolean>(false)

async function handleDelete(row: RoleItem): Promise<void> {
  try {
    let confirmMessage = ""

    if (row.roleId === undefined) return
    confirmMessage = `正在删除：${row.roleName}，确认删除？`

    await ElMessageBox.confirm(confirmMessage, "提示", {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning"
    })

    loading.value = true
    const response = await roleApi.deleteRole(row.roleId)

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
function openCreateDialog() {
  formData.value = cloneDeep(formDefault)
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
// #endregion

getTableData()

// 下拉菜单命令处理
interface DropdownCommand {
  action: "edit" | "delete"
  data: RoleItem
}
function handleCommand(command: DropdownCommand): void {
  if (command.action === "edit") {
    openUpdateDialog(command.data as RoleItem)
  } else if (command.action === "delete") {
    handleDelete(command.data as any)
  }
}

function handleMenuSelect(index: string): void {
  roleId.value = Number(index)
}
</script>

<template>
  <div>
    <!-- 表单 -->
    <el-card v-loading="loading" shadow="never" class="role-container">
      <template #default>
        <div class="p-5px">
          <div class="toolbar-wrapper mb-20px">
            <el-button
              type="primary"
              :icon="CirclePlus"
              @click="openCreateDialog()"
            >
              新增
            </el-button>
          </div>
          {{ roleId }}
          <el-menu
            :default-active="roleId?.toString()"
            mode="vertical"
            class="role-menu border-r-none"
            @select="handleMenuSelect"
          >
            <el-menu-item
              v-for="item in tableData"
              :key="item.roleId"
              :index="item.roleId.toString()"
              class="group"
            >
              <div class="menu-item-content flex justify-between items-center w-full">
                <span class="role-name flex-1 text-left">{{ item.roleName }}</span>
                <el-dropdown
                  trigger="click"
                  placement="bottom-end"
                  @command="handleCommand"
                >
                  <el-button
                    type="primary"
                    text
                    :icon="MoreFilled"
                    class="more-btn opacity-0 group-hover:opacity-100 transition-opacity duration-300 p-4px min-w-auto h-auto md:opacity-100"
                    @click.stop
                  />
                  <template #dropdown>
                    <el-dropdown-menu>
                      <el-dropdown-item
                        :command="{ action: 'edit', data: item }"
                      >
                        <el-icon><Edit /></el-icon>
                        编辑
                      </el-dropdown-item>
                      <el-dropdown-item
                        :command="{ action: 'delete', data: item }"
                      >
                        <el-icon><Delete /></el-icon>
                        删除
                      </el-dropdown-item>
                    </el-dropdown-menu>
                  </template>
                </el-dropdown>
              </div>
            </el-menu-item>
          </el-menu>
        </div>
      </template>
    </el-card>

    <!-- 数据弹窗 -->
    <RoleFormDialog
      v-model:loading="loading"
      v-model:form-dialog-visible="formDialogVisible"
      v-model:form-data="formData"
      @submit-success="handleSubmitSuccess"
    />
  </div>
</template>

<style>
.role-container {
  height: 100%;
  overflow-y: auto;
}

.role-container :deep(.el-card__body) {
  padding: 5px;
}

.role-menu {
  border-right: none;
}
</style>
