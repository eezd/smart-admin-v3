<script lang="ts" setup>
import type { EmployeeItem } from "@/common/apis/system/employee-api"
import type { FormInstance, FormRules } from "element-plus"
import { employeeApi } from "@/common/apis/system/employee-api"
import { useDevice } from "@/common/composables/useDevice"
import { MENU_PERMS_TYPE_ENUM, MENU_TYPE_ENUM } from "@/common/constants/system/menu-const"
import { positionApi } from "@@/apis/system/position-api"
import { roleApi } from "@@/apis/system/role-api"
import IconSelect from "@@/components/Framework/IconSelect/index.vue"
import SmartEnumSelect from "@@/components/Framework/SmartEnumSelect/index.vue"
import DepartmentTreeSelect from "@@/components/System/DepartmentTreeSelect/index.vue"
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
  return formData.value.employeeId === undefined ? "新增" : "编辑"
})

const formRef = ref<FormInstance>()

/**
 * 表单验证规则
 */
const formRules = computed<FormRules<any>>(() => {
  const rules: FormRules<any> = {}
  return rules
})

/**
 * 创建或更新
 */
function handleCreateOrUpdate() {
  formRef.value?.validate(async (valid: boolean) => {
    // (valid: boolean, fields)
    if (valid) {
      try {
        loading.value = true
        if (formData.value.employeeId) {
          await employeeApi.update(formData.value as any)
        } else {
          await employeeApi.create(formData.value as any)
        }
        emit("submitSuccess")
      } finally {
        dialogVisible.value = false
        loading.value = false
      }
    }
  })
}

const positionList = ref<any[]>([])
positionApi.queryList().then((res) => {
  positionList.value = res.data
})

const roleList = ref<any[]>([])
roleApi.queryAll().then((res) => {
  roleList.value = res.data
})

function handleCancel() {
  dialogVisible.value = false
  emit("submitCancel")
}
</script>

<template>
  <el-drawer v-model="dialogVisible" :title="title" direction="rtl" :size="isMobile ? '100%' : '50%'" destroy-on-close>
    <el-form ref="formRef" :model="formData" :rules="formRules" label-position="left" label-width="100px">
      {{ formData }}
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
      <el-form-item prop="departmentId" label="部门">
        <DepartmentTreeSelect v-model:value="formData.departmentId" />
      </el-form-item>

      <el-form-item prop="loginName" label="登录账号">
        <el-input v-model="formData.loginName" placeholder="请输入" />
      </el-form-item>
      <el-form-item prop="email" label="邮箱">
        <el-input v-model="formData.email" placeholder="请输入" />
      </el-form-item>

      <el-form-item prop="gender" label="性别">
        <SmartEnumSelect v-model:value="formData.gender" style="width: 100%" placeholder="请选择性别" enum-name="GENDER_ENUM" />
      </el-form-item>

      <el-form-item label="状态" prop="disabledFlag">
        <el-switch
          v-model="formData.disabledFlag"
          inline-prompt
          :active-value="false"
          :inactive-value="true"
          active-text="启用"
          inactive-text="禁用"
        />
      </el-form-item>

      <el-form-item label="职务" prop="roleIdList">
        <el-select
          v-model="formData.positionId"
          filterable
          placeholder="请选择职务"
        >
          <el-option
            v-for="item in positionList"
            :key="item.positionId"
            :label="item.positionName"
            :value="item.positionId"
          />
        </el-select>
      </el-form-item>

      <el-form-item label="角色" prop="roleIdList">
        <el-select
          v-model="formData.roleIdList"
          multiple
          filterable
          placeholder="请选择角色"
        >
          <el-option
            v-for="item in roleList"
            :key="item.roleId"
            :label="item.roleName"
            :value="item.roleId"
          />
        </el-select>
      </el-form-item>
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
