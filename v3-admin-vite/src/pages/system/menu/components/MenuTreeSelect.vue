<script lang="ts" setup>
import { menuApi } from "@@/apis/system/menu-api"

/**
 * defineModel
 */
// #region defineModel
const value = defineModel<number>(
  "value",
  {
    required: false,
    default: null
  }
)
// #endregion

const treeData = ref<any[]>([])
menuApi.queryTree(true).then(({ data }) => {
  treeData.value = data
})
</script>

<template>
  <el-tree-select
    v-model="value"
    :data="treeData"
    node-key="menuId"
    :props="{ label: 'menuName', children: 'children' }"
    placeholder="请选择上级菜单"
    :default-expanded-keys="[value]"
    :expand-on-click-node="false"
    check-strictly
    style="width: 100%"
  />
</template>

<style lang="scss" scoped>
</style>
