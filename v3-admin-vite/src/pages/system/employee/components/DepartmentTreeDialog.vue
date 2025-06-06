<script lang="ts" setup>
import type { ElTree } from "element-plus"
import { employeeApi } from "@/common/apis/system/employee-api"
import { useDevice } from "@/common/composables/useDevice"
import { departmentApi } from "@@/apis/system/department-api"
import message from "element-plus/es/components/message/index.mjs"
import { isEmpty } from "lodash-es"
import { ref } from "vue"

/**
 * defineProps
 */
// #region defineProps
interface Props {
  employeeIdList: any[]
}

const props = defineProps<Props>()
// #endregion

// #region defineEmits
const emit = defineEmits<{
  submitSuccess: []
}>()
// #endregion

// #region defineModel
const loading = defineModel<boolean>("loading", { required: true })
const dialogVisible = defineModel<boolean>("formDialogVisible", { required: true })

// #endregion

const { isMobile } = useDevice()

const departmentTreeData = ref<any[]>([])
const treeRef = ref<InstanceType<typeof ElTree>>()
departmentApi.queryTree().then(({ data }) => {
  departmentTreeData.value = data
})

async function handleCreateOrUpdate() {
  try {
    // 自动获取当前选中的节点
    const currentNode = treeRef.value?.getCurrentNode()
    const selectedDepartmentId = currentNode?.departmentId
    if (selectedDepartmentId === undefined) {
      ElMessage.error("请选择部门")
      return
    }
    if (isEmpty(props.employeeIdList)) {
      ElMessage.error("请选择员工")
      return
    }
    loading.value = true

    await employeeApi.batchUpdateDepartmentEmployee({
      employeeIdList: props.employeeIdList,
      departmentId: selectedDepartmentId
    })
    message.success("操作成功")
    emit("submitSuccess")
    dialogVisible.value = false
  } catch (e) {
    message.error("操作失败")
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <el-dialog v-model="dialogVisible" :width="isMobile ? '80%' : '40%'" destroy-on-close>
    <el-tree
      ref="treeRef"
      :data="departmentTreeData"
      node-key="departmentId"
      :props="{ label: 'name', children: 'children' }"
      :expand-on-click-node="false"
      highlight-current
      default-expand-all
      style="width: 100%"
    />
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
