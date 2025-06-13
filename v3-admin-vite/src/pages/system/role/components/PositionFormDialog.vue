<script lang="ts" setup>
import type { PositionCreateRequest, PositionItem, PositionUpdateRequest } from "@/common/apis/system/position-api"
import type { FormInstance, FormRules } from "element-plus"
import { positionApi } from "@/common/apis/system/position-api"
import { useDevice } from "@/common/composables/useDevice"

// #region defineEmits
const emit = defineEmits<{
  submitSuccess: []
}>()
// #endregion

// #region defineModel
const loading = defineModel<boolean>("loading", { required: true })
const dialogVisible = defineModel<boolean>("formDialogVisible", { required: true })
const formData = defineModel<PositionItem>(
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
        if (formData.value.positionId) {
          await positionApi.update(formData.value as PositionUpdateRequest)
        } else {
          await positionApi.create(formData.value as PositionCreateRequest)
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
