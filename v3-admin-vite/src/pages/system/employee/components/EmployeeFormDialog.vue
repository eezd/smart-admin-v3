<script lang="ts" setup>
import type { EmployeeItem } from "@/common/apis/system/employee-api"
import type { FormInstance, FormRules } from "element-plus"
import { employeeApi } from "@/common/apis/system/employee-api"
import { useDevice } from "@/common/composables/useDevice"
import { positionApi } from "@@/apis/system/position-api"
import { roleApi } from "@@/apis/system/role-api"
import SmartEnumSelect from "@@/components/Framework/SmartEnumSelect/index.vue"
import DepartmentTreeSelect from "@@/components/System/DepartmentTreeSelect/index.vue"

// #region defineEmits
const emit = defineEmits<{
  submitSuccess: []
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
  return {
    actualName: [
      { required: true, message: "请输入姓名", trigger: "blur" }
    ],
    phone: [
      { required: true, message: "请输入手机号", trigger: "blur" }
    ],
    departmentId: [
      { required: true, message: "请选择部门", trigger: "change" }
    ],
    loginName: [
      { required: true, message: "请输入登录账号", trigger: "blur" }
    ],
    email: [
      { required: true, message: "请输入邮箱", trigger: "blur" },
      { type: "email", message: "请输入正确的邮箱格式", trigger: ["blur", "change"] }
    ],
    gender: [
      { required: true, message: "请选择性别", trigger: "change" }
    ],
    disabledFlag: [
      { required: true, message: "请选择状态", trigger: "change" }
    ]
  }
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
          const response = await employeeApi.update(formData.value as any)
          ElMessage.success(response.msg)
        } else {
          const response = await employeeApi.create(formData.value as any)
          ElMessage.success(response.msg)
        }
        emit("submitSuccess")
        dialogVisible.value = false
      } finally {
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
</script>

<template>
  <el-drawer v-model="dialogVisible" :title="title" direction="rtl" :size="isMobile ? '100%' : '50%'" destroy-on-close>
    <el-form ref="formRef" :model="formData" :rules="formRules" label-position="left" label-width="100px">
      <el-form-item prop="actualName" label="姓名">
        <el-input v-model="formData.actualName" placeholder="请输入" />
      </el-form-item>

      <el-form-item prop="phone" label="手机号">
        <el-input v-model="formData.phone" placeholder="请输入" />
      </el-form-item>

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
      <el-button @click="dialogVisible = false">
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
