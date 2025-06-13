<script lang="ts" setup>
import type { RoleCreateRequest, RoleItem, RoleUpdateRequest } from "@/common/apis/system/role-api"
import type { FormInstance, FormRules } from "element-plus"
import { roleApi } from "@/common/apis/system/role-api"
import { useDevice } from "@/common/composables/useDevice"

// #region defineEmits
const emit = defineEmits<{
  submitSuccess: []
}>()
// #endregion

// #region defineModel
const loading = defineModel<boolean>("loading", { required: true })
const dialogVisible = defineModel<boolean>("formDialogVisible", { required: true })
const formData = defineModel<RoleItem>(
  "formData",
  {
    required: true
  }
)
// #endregion

const title = computed(() => {
  return formData.value.roleId === undefined ? "新增" : "编辑"
})

const { isMobile } = useDevice()

const formRef = ref<FormInstance | null>(null)
const formRules: FormRules<any> = {
  roleName: [
    { required: true, message: "请输入角色名称", trigger: "blur" },
    { min: 2, max: 50, message: "长度在 2 到 50 个字符", trigger: "blur" }
  ],
  roleCode: [
    { required: true, message: "请输入角色编码", trigger: "blur" },
    { min: 2, max: 50, message: "长度在 2 到 50 个字符", trigger: "blur" }
  ]
}

/**
 * 创建或更新
 */
function handleCreateOrUpdate() {
  formRef.value?.validate(async (valid: boolean) => {
    // (valid: boolean, fields)
    if (valid) {
      try {
        loading.value = true
        if (formData.value.roleId) {
          await roleApi.updateRole(formData.value as RoleUpdateRequest)
        } else {
          await roleApi.createRole(formData.value as RoleCreateRequest)
        }
        emit("submitSuccess")
        dialogVisible.value = false
      } finally {
        loading.value = false
      }
    }
  })
}
</script>

<template>
  <el-dialog v-model="dialogVisible" :title="title" :width="isMobile ? '80%' : '40%'" destroy-on-close>
    <el-form ref="formRef" label-width="80px" :model="formData" :rules="formRules" label-position="left">
      {{ formData }}
      <el-form-item prop="roleName" label="角色名称">
        <el-input v-model="formData.roleName" placeholder="请输入" />
      </el-form-item>
      <el-form-item prop="roleCode" label="角色编码">
        <el-input v-model="formData.roleCode" placeholder="请输入" />
      </el-form-item>
      <el-form-item prop="remark" label="角色备注">
        <el-input v-model="formData.remark" placeholder="请输入" />
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
  </el-dialog>
</template>

<style lang="scss" scoped>
</style>
