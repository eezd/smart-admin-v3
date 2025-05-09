<script lang="ts" setup>
import { useUserStore } from "@/pinia/stores/user"
import Admin from "./components/Admin.vue"
import Editor from "./components/Editor.vue"

const userStore = useUserStore()
const isAdmin = userStore.roles.includes("admin")

const router = useRouter()
const routes = router.getRoutes() // 获取所有已注册的路由记录

async function test() {
  console.log(1)

  console.log(routes) // 输出完整的路由表
  console.log(routes[38]) // 输出完整的路由表
}
</script>

<template>
  <div>
    <input type="text">
  </div>
</template>
