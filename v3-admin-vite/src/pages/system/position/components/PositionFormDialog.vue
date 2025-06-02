<script lang="ts" setup>
import type { FormInstance, FormRules } from "element-plus"
import { positionApi } from "@/common/apis/system/position-api"
import { useDevice } from "@/common/composables/useDevice"
import { cloneDeep } from "lodash-es"

/**
 * defineEmits
 */
// #region defineEmits
const emit = defineEmits<{
  submitSuccess: []
  submitCancel: []
}>()
// #endregion

/**
 * defineModel
 */
// #region defineModel
const loading = defineModel<boolean>("loading", { required: true })
const dialogVisible = defineModel<boolean>("formDialogVisible", { required: true })
const formData = defineModel<any>(
  "formData",
  {
    required: true
  }
)
// #endregion

const title = computed(() => {
  return formData.value.positionId === undefined ? "新增" : "编辑"
})

const { isMobile } = useDevice()

// 组件实例 (权限树)
const formRef = ref<FormInstance | null>(null)

const formRules: FormRules<any> = {
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
        console.log(formData.value)
        if (formData.value.positionId) {
          await positionApi.update(formData.value)
        } else {
          await positionApi.create(formData.value)
        }
      } finally {
        dialogVisible.value = false
        loading.value = false
      }
    }
  })
}

/**
 * 重置表单
 */
function resetForm() {
  formRef.value?.clearValidate()
  formRef.value?.resetFields()
  formData.value = cloneDeep({})
}

function handleCancel() {
  dialogVisible.value = false
  emit("submitCancel")
}
</script>

<template>
  <el-dialog v-model="dialogVisible" :title="title" :width="isMobile ? '80%' : '40%'" @closed="resetForm">
    <el-form ref="formRef" label-width="80px" :model="formData" :rules="formRules" label-position="left">
      <el-form-item prop="positionName" label="职务名称">
        <el-input v-model="formData.positionName" placeholder="请输入" />
      </el-form-item>
      <el-form-item prop="level" label="职级">
        <el-input v-model="formData.level" placeholder="请输入" />
      </el-form-item>
      <el-form-item prop="sort" label="显示顺序">
        <el-input-number v-model="formData.sort" :min="1" :max="9999" />
      </el-form-item>
      <el-form-item prop="remark" label="备注">
        <el-input v-model="formData.remark" placeholder="请输入" />
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
  </el-dialog>
</template>

<style lang="scss" scoped>
</style>
