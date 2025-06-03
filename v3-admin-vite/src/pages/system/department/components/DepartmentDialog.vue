<script lang="ts" setup>
import type { DepartmentCreateRequest, DepartmentItem, DepartmentUpdateRequest } from "@@/apis/system/department-api"
import type { FormInstance, FormRules } from "element-plus"
import { useDevice } from "@/common/composables/useDevice"
import { departmentApi } from "@@/apis/system/department-api"
import DepartmentTreeSelect from "@@/components/System/DepartmentTreeSelect/index.vue"

// #region defineEmits
const emit = defineEmits<{
  submitSuccess: []
  submitCancel: []
}>()
// #endregion

// #region defineModel
const loading = defineModel<boolean>("loading", { required: true })
const dialogVisible = defineModel<boolean>("formDialogVisible", { required: true })
const formData = defineModel<DepartmentItem>(
  "formData",
  {
    required: true
  }
)
// #endregion

const title = computed(() => {
  return formData.value.departmentId === undefined ? "新增" : "编辑"
})

const { isMobile } = useDevice()

// 组件实例 (权限树)
const formRef = ref<FormInstance | null>(null)

const formRules: FormRules<any> = {
}

const departmentTreeData = ref<any[]>([])
departmentApi.queryTree().then(({ data }) => {
  departmentTreeData.value = data
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
        if (formData.value.departmentId) {
          await departmentApi.update(formData.value as DepartmentUpdateRequest)
        } else {
          await departmentApi.create(formData.value as DepartmentCreateRequest)
        }
        emit("submitSuccess") // 通知父组件刷新数据
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
</script>

<template>
  <el-dialog v-model="dialogVisible" :title="title" :width="isMobile ? '80%' : '40%'" destroy-on-close>
    <el-form ref="formRef" label-width="80px" :model="formData" :rules="formRules" label-position="left">
      <el-form-item prop="parentId" label="上级部门">
        <DepartmentTreeSelect v-model:enterprise-id="formData.parentId" />
      </el-form-item>
      <el-form-item prop="name" label="部门名称">
        <el-input v-model="formData.name" placeholder="请输入" />
      </el-form-item>
      <el-form-item prop="managerName" label="部门负责人">
        <el-input v-model="formData.managerName" placeholder="请输入" />
      </el-form-item>
      <el-form-item prop="sort" label="显示顺序">
        <el-input-number v-model="formData.sort" :min="1" :max="9999" />
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
