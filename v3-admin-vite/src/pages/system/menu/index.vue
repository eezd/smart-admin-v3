<script lang="ts" setup>
import type { MenuItem } from "@@/apis/system/menu-api"
import type { FormInstance } from "element-plus"
import type { MenuTreeItem, SearchParams } from "./index"
import { menuApi } from "@/common/apis/system/menu-api"
import { FLAG_NUMBER_ENUM } from "@/common/constants/common-const"
import { MENU_PERMS_TYPE_ENUM, MENU_TYPE_ENUM } from "@/common/constants/system/menu-const"
import { ArrowDown, ArrowUp, CirclePlus, Delete, Refresh, RefreshRight, Search } from "@element-plus/icons-vue"
import * as ElementPlusIcons from "@element-plus/icons-vue"
import { cloneDeep } from "lodash-es"
import { reactive, ref } from "vue"
import MenuDialog from "./components/MenuDialog.vue"
import { buildMenuTableTree, filterMenuByQueryForm } from "./index"

defineOptions({
  name: "MenuManagement"
})

const loading = ref(false)

// #region 搜索栏
const searchFormRef = ref<FormInstance | null>(null)
const searchData = reactive<SearchParams>({
  keywords: "",
  menuType: undefined,
  disabledFlag: undefined,
  frameFlag: undefined,
  cacheFlag: undefined,
  visibleFlag: undefined
})

const menuTreeData = ref<MenuTreeItem[]>([])
const menuTypeColorArray: Record<number, "primary" | "warning" | "success" | "info" | "danger"> = ["primary", "warning", "success"]

async function getTableData(params?: SearchParams): Promise<void> {
  try {
    loading.value = true
    const response = await menuApi.queryList()
    if (params === undefined) {
      menuTreeData.value = buildMenuTableTree(response.data)
    } else {
      const filtedMenuList = filterMenuByQueryForm(response.data, params)
      menuTreeData.value = buildMenuTableTree(filtedMenuList)
    }
  } catch {
    menuTreeData.value = []
  } finally {
    loading.value = false
  }
}
function handleSearch() {
  getTableData(searchData)
}
function resetSearch() {
  searchFormRef.value?.resetFields()
  getTableData()
}

/**
 * 展开/收起查询条件
 */
const moreQueryConditionFlag = ref<boolean>(false)
function toggleMoreConditions() {
  moreQueryConditionFlag.value = !moreQueryConditionFlag.value
}
// #endregion

// #region 表单操作
const selectedRows = ref<MenuItem[]>([])
const hasSelectedRows = computed(() => selectedRows.value.length > 0)
const handleSelectionChange = (val: MenuItem[]) => (selectedRows.value = val)

const formDefault: MenuItem = {
  menuId: undefined,
  menuName: "",
  menuType: MENU_TYPE_ENUM.CATALOG.value,
  icon: undefined,
  parentId: 0,
  path: undefined,
  permsType: MENU_PERMS_TYPE_ENUM.SA_TOKEN.value,
  webPerms: undefined,
  apiPerms: undefined,
  sort: 0,
  visibleFlag: true,
  cacheFlag: true,
  component: undefined,
  contextMenuId: undefined,
  disabledFlag: false,
  frameFlag: false,
  frameUrl: undefined
}
const formData = ref<MenuItem>(cloneDeep(formDefault))
const formDialogVisible = ref<boolean>(false)

async function handleDelete(row: MenuItem | MenuItem[]) {
  try {
    const deleteIds: number[] = []
    let confirmMessage = ""

    if (Array.isArray(row)) {
      const ids = row.map(item => item.menuId).filter((id): id is number => id !== undefined)
      if (ids.length === 0) return
      deleteIds.push(...ids)
      confirmMessage = `正在删除：${row.length} 条数据，确认删除？`
    } else {
      if (row.menuId === undefined) return
      deleteIds.push(row.menuId)
      confirmMessage = `正在删除：${row.menuName}，确认删除？`
    }

    await ElMessageBox.confirm(confirmMessage, "提示", {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning"
    })

    loading.value = true
    const response = await menuApi.batchDelete(deleteIds)
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
function openCreateDialog(menuId?: number) {
  formData.value = cloneDeep(formDefault)
  formData.value.parentId = menuId || 0
  formDialogVisible.value = true
}
function openUpdateDialog(row: MenuItem) {
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

/**
 * 获取图标组件
 */
function getIconComponent(iconName: string) {
  if (!iconName) return null
  return ElementPlusIcons[iconName as keyof typeof ElementPlusIcons]
}

getTableData()
</script>

<template>
  <div class="app-container p-20px">
    <!-- 搜索栏 -->
    <el-card v-loading="loading" shadow="never" class="search-wrapper mb-20px">
      <el-form ref="searchFormRef" :inline="true" :model="searchData">
        <!-- 第一行查询条件 -->
        <el-form-item prop="keywords" label="关键字">
          <el-input
            v-model="searchData.keywords"
            placeholder="菜单名称/路由地址/组件路径/权限字符串"
            style="width: 300px"
            clearable
            @keyup.enter="handleSearch"
          />
        </el-form-item>

        <el-form-item prop="menuType" label="类型">
          <el-select
            v-model="searchData.menuType"
            placeholder="请选择类型"
            style="width: 120px"
            clearable
          >
            <el-option
              v-for="item in MENU_TYPE_ENUM"
              :key="item.value"
              :label="item.desc"
              :value="item.value"
            />
          </el-select>
        </el-form-item>

        <el-form-item prop="disabledFlag" label="禁用">
          <el-select
            v-model="searchData.disabledFlag"
            placeholder="请选择状态"
            style="width: 120px"
            clearable
          >
            <el-option
              v-for="item in FLAG_NUMBER_ENUM"
              :key="item.value"
              :label="item.desc"
              :value="item.value"
            />
          </el-select>
        </el-form-item>

        <el-form-item>
          <el-button
            type="primary"
            :icon="Search"
            :loading="loading"
            @click="handleSearch"
          >
            查询
          </el-button>
          <el-button
            :icon="Refresh"
            :loading="loading"
            @click="resetSearch"
          >
            重置
          </el-button>
          <el-button
            :icon="moreQueryConditionFlag ? ArrowUp : ArrowDown"
            class="ml-5"
            @click="toggleMoreConditions"
          >
            {{ moreQueryConditionFlag ? '收起' : '展开' }}
          </el-button>
        </el-form-item>

        <!-- 展开的查询条件 -->
        <template v-if="moreQueryConditionFlag">
          <div class="expanded-search-conditions flex flex-wrap w-full mt-10px">
            <el-form-item prop="frameFlag" label="外链">
              <el-select
                v-model="searchData.frameFlag"
                placeholder="请选择"
                style="width: 120px"
                clearable
              >
                <el-option
                  v-for="item in FLAG_NUMBER_ENUM"
                  :key="item.value"
                  :label="item.desc"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>

            <el-form-item prop="cacheFlag" label="缓存">
              <el-select
                v-model="searchData.cacheFlag"
                placeholder="请选择"
                style="width: 120px"
                clearable
              >
                <el-option
                  v-for="item in FLAG_NUMBER_ENUM"
                  :key="item.value"
                  :label="item.desc"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>

            <el-form-item prop="visibleFlag" label="显示">
              <el-select
                v-model="searchData.visibleFlag"
                placeholder="请选择"
                style="width: 120px"
                clearable
              >
                <el-option
                  v-for="item in FLAG_NUMBER_ENUM"
                  :key="item.value"
                  :label="item.desc"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>
          </div>
        </template>
      </el-form>
    </el-card>

    <!-- 表单 -->
    <el-card v-loading="loading" shadow="never">
      <div class="toolbar-wrapper  mb-20px">
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
      <el-table
        :data="menuTreeData"
        row-key="menuId"
        border
        :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
        empty-text="暂无数据"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="50" />
        <el-table-column prop="menuName" label="名称" width="220" />
        <el-table-column prop="menuType" label="类型" width="180">
          <template #default="{ row }">
            <el-tag :type="menuTypeColorArray[row.menuType] ? menuTypeColorArray[row.menuType] : 'primary'">
              {{ $smartEnumPlugin.getDescByValue('MENU_TYPE_ENUM', row.menuType) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="icon" label="图标" width="80" align="center">
          <template #default="{ row }">
            <div v-if="row.icon" class="icon-display flex items-center justify-center">
              <el-icon :size="20">
                <component :is="getIconComponent(row.icon)" />
              </el-icon>
            </div>
            <span v-else class="text-gray-400">-</span>
          </template>
        </el-table-column>
        <el-table-column prop="path" label="路径" show-overflow-tooltip />
        <el-table-column prop="component" label="组件" show-overflow-tooltip />
        <el-table-column prop="apiPerms" label="后端权限" width="100" show-overflow-tooltip />
        <el-table-column prop="webPerms" label="前端权限" width="100" show-overflow-tooltip />
        <el-table-column prop="sort" label="顺序" width="100" />
        <el-table-column fixed="right" label="操作" width="100">
          <template #default="scope">
            <el-button type="primary" size="small" link @click="openUpdateDialog(scope.row)">
              编辑
            </el-button>
            <el-button type="danger" size="small" link @click="handleDelete(scope.row)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 数据弹窗 -->
    <MenuDialog
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

// 响应式处理
@media (max-width: 768px) {
  .toolbar-wrapper {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;

    .toolbar-left {
      justify-content: center;
    }

    .toolbar-right {
      align-self: center;
    }
  }

  .expanded-search-conditions {
    flex-direction: column;
    gap: 0;
  }
}
</style>
