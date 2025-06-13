<script setup lang="ts">
import { ref } from "vue"
import RoleDataScope from "./RoleDataScope.vue"
import RoleEmployeeList from "./RoleEmployeeList.vue"
import RoleTree from "./RoleTree/index.vue"

// #region defineModel
const loading = defineModel<boolean>("loading", { required: true })
// #endregion

const activeKey = ref<string>("1")
</script>

<template>
  <el-card class="h-full">
    <el-tabs v-model="activeKey">
      <el-tab-pane label="角色-功能权限" name="1">
        <RoleTree v-model:loading="loading" />
      </el-tab-pane>
      <el-tab-pane label="角色-数据范围" name="2">
        <RoleDataScope />
      </el-tab-pane>
      <el-tab-pane label="角色-员工列表" name="3">
        <RoleEmployeeList />
      </el-tab-pane>
    </el-tabs>
  </el-card>
</template>
