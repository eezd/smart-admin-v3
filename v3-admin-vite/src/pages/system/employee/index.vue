<script lang="ts" setup>
import { useDevice } from "@/common/composables/useDevice"
import DepartmentTree from "./components/DepartmentTree.vue"
import EmployeeList from "./components/EmployeeList.vue"

const { isMobile } = useDevice()

const departmentId = ref(0)
</script>

<template>
  <div class="app-container">
    <el-container :direction="isMobile ? 'vertical' : 'horizontal'">
      <el-aside width="200px">
        <DepartmentTree v-model:value="departmentId" />
      </el-aside>
      <el-main class="pt-0">
        <EmployeeList />
      </el-main>
    </el-container>
  </div>
</template>

<style lang="scss" scoped>

</style>
