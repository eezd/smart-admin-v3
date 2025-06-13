<script lang="ts" setup>
import { useDevice } from "@/common/composables/useDevice"
import RoleList from "./components/RoleList.vue"
import RoleSetting from "./components/RoleSetting.vue"

const { isMobile } = useDevice()

const loadding = ref(false)

const roleId = ref(undefined)

provide("selectRoleId", roleId)
</script>

<template>
  <div class="app-container">
    <el-container :direction="isMobile ? 'vertical' : 'horizontal'">
      <el-aside width="200px">
        <RoleList v-model:role-id="roleId" v-model:loading="loadding" />
      </el-aside>
      <el-main class="pt-0">
        <RoleSetting v-model:loading="loadding" />
      </el-main>
    </el-container>
  </div>
</template>

<style lang="scss" scoped>

</style>
