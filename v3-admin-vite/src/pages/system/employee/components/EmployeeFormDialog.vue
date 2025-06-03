<script lang="ts" setup>
import type { EmployeeItem } from "@/common/apis/system/employee-api"
import type { MenuItem, MenuUpdateRequest } from "@@/apis/system/menu-api"
import type { FormInstance, FormRules } from "element-plus"
import { useDevice } from "@/common/composables/useDevice"
import { MENU_PERMS_TYPE_ENUM, MENU_TYPE_ENUM } from "@/common/constants/system/menu-const"
import { menuApi } from "@@/apis/system/menu-api"
import IconSelect from "@@/components/Framework/IconSelect/index.vue"
import * as ElementPlusIcons from "@element-plus/icons-vue"

// #region defineEmits
const emit = defineEmits<{
  submitSuccess: []
  submitCancel: []
}>()
// #endregion

// #region defineModel
const loading = defineModel<boolean>("loading", { required: true })
const dialogVisible = defineModel<boolean>("formDialogVisible", { required: true })
const formData = defineModel<EmployeeItem>(
  "formData",
  {
    required: true
  }
)
// #endregion

const { isMobile } = useDevice()

const title = computed(() => {
  return formData.value.menuId === undefined ? "新增" : "编辑"
})

const formRef = ref<FormInstance>()
const parentMenuTreeSelectRef = ref<FormInstance>()
const contextMenuTreeSelectRef = ref<FormInstance>()

/**
 * 表单验证规则
 */
const formRules = computed<FormRules<MenuItem>>(() => {
  const rules: FormRules<MenuItem> = {}
  if (!formData.value.menuType) {
    return rules
  }
  // 目录：菜单名称必填
  if (isCatalogType.value) {
    rules.menuName = [
      { required: true, message: "请输入菜单名称", trigger: "blur" }
    ]
  }
  // 菜单：菜单名称、路由地址必填
  if (isMenuType.value) {
    rules.menuName = [
      { required: true, message: "请输入菜单名称", trigger: "blur" }
    ]
    rules.path = [
      { required: true, message: "请输入路由地址", trigger: "blur" }
    ]
  }
  // 按钮/功能点：功能点名称必填
  if (isPointsType.value) {
    rules.menuName = [
      { required: true, message: "请输入功能点名称", trigger: "blur" }
    ]
  }
  return rules
})

const isMenuType = computed(() => formData.value.menuType === MENU_TYPE_ENUM.MENU.value)
const isCatalogType = computed(() => formData.value.menuType === MENU_TYPE_ENUM.CATALOG.value)
const isPointsType = computed(() => formData.value.menuType === MENU_TYPE_ENUM.POINTS.value)

/**
 * 创建或更新
 */
function handleCreateOrUpdate() {
  formRef.value?.validate(async (valid: boolean) => {
    // (valid: boolean, fields)
    if (valid) {
      try {
        loading.value = true
        if (formData.value.menuId) {
          await menuApi.update(formData.value as MenuUpdateRequest)
        } else {
          await menuApi.create(formData.value)
        }
        emit("submitSuccess")
      } finally {
        dialogVisible.value = false
        loading.value = false
      }
    }
  })
}

function handleCancel() {
  dialogVisible.value = false
  emit("submitCancel")
}

function selectIcon(iconName: string) {
  formData.value.icon = iconName
}
function getIconComponent(iconName: string) {
  return ElementPlusIcons[iconName as keyof typeof ElementPlusIcons]
}
</script>

<template>
  <el-drawer v-model="dialogVisible" :title="title" direction="rtl" :size="isMobile ? '100%' : '50%'" destroy-on-close>
    <el-form ref="formRef" :model="formData" :rules="formRules" label-position="left" label-width="100px">
      <!-- <el-form-item :label="isCatalogType ? '上级目录' : '上级菜单'">
        <MenuTreeSelect ref="parentMenuTreeSelectRef" v-model:value="formData.parentId" />
      </el-form-item> -->
      <el-form-item prop="actualName" label="姓名">
        <el-input v-model="formData.actualName" placeholder="请输入" />
      </el-form-item>
      <el-form-item prop="phone" label="手机号">
        <el-input v-model="formData.phone" placeholder="请输入" />
      </el-form-item>

      <!-- 部门 -->

      <el-form-item prop="loginName" label="登录账号">
        <el-input v-model="formData.loginName" placeholder="请输入" />
      </el-form-item>
      <el-form-item prop="email" label="邮箱">
        <el-input v-model="formData.email" placeholder="请输入" />
      </el-form-item>

      <!-- 性别 -->
      <!-- 状态 -->
      <!-- 职务 -->
      <!-- 角色 -->
    </el-form>

    <template #footer>
      <el-button @click="handleCancel">
        取消
      </el-button>
      <el-button type="primary" :loading="loading" @click="handleCreateOrUpdate">
        确认
      </el-button>
    </template>
  </el-drawer>
</template>

<style lang="scss" scoped>
</style>
