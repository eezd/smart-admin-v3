<script lang="ts" setup>
import type { ElTree } from "element-plus"
import { departmentApi } from "@@/apis/system/department-api"
import { ref } from "vue"

/**
 * defineModel
 */
// #region defineModel
const departmentId = defineModel<number>(
  "value",
  {
    required: true
  }
)
// #endregion

const departmentTreeData = ref<any[]>([])
const treeRef = ref<InstanceType<typeof ElTree>>()

departmentApi.queryTree().then(({ data }) => {
  departmentTreeData.value = data
})

// 处理树节点点击事件
function handleNodeClick(data: any) {
  departmentId.value = data.departmentId
}

// 监听enterpriseId变化，更新树的选中状态
watch(() => departmentId.value, (newVal) => {
  if (treeRef.value && newVal) {
    treeRef.value.setCurrentKey(newVal)
  }
}, { immediate: true })
</script>

<template>
  <el-tree
    ref="treeRef"
    :data="departmentTreeData"
    node-key="departmentId"
    :props="{ label: 'name', children: 'children' }"
    :expand-on-click-node="false"
    :current-node-key="departmentId"
    :default-expanded-keys="departmentId ? [departmentId] : []"
    highlight-current
    default-expand-all
    style="width: 100%"
    @node-click="handleNodeClick"
  />
</template>

<style lang="scss" scoped>
.el-tree {
  border: 1px solid var(--el-border-color);
  border-radius: var(--el-border-radius-base);
  padding: 8px;
  max-height: 300px;
  overflow-y: auto;
}
</style>
