<script lang="ts" setup>
import DepartmentTree from "./components/DepartmentTree.vue"
import EmployeeList from "./components/EmployeeList.vue"

const departmentId = ref(0)
</script>

<template>
  <div class="app-container">
    <el-container>
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
.search-wrapper {
  margin-bottom: 20px;
  :deep(.el-card__body) {
    padding-bottom: 2px;
  }
}

.toolbar-wrapper {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
}

.table-wrapper {
  margin-bottom: 20px;
}

.pager-wrapper {
  display: flex;
  justify-content: flex-end;
}
</style>
