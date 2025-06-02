<script lang="ts" setup>
import { departmentApi } from "@@/apis/system/department-api"

/**
 * defineModel
 */
// #region defineModel
const enterpriseId = defineModel<number>(
  "enterpriseId",
  {
    required: true
  }
)
// #endregion

const departmentTreeData = ref<any[]>([])
departmentApi.queryTree().then(({ data }) => {
  departmentTreeData.value = data
})
</script>

<template>
  <el-tree-select
    v-model="enterpriseId"
    :data="departmentTreeData"
    node-key="departmentId"
    :props="{ label: 'name', children: 'children' }"
    placeholder="请选择上级部门"
    :default-expanded-keys="[enterpriseId]"
    :expand-on-click-node="false"
    check-strictly
    style="width: 100%"
  />
</template>

<style lang="scss" scoped>
</style>
