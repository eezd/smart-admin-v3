<!--
  * iframe 组件
  *
  * @Author:    1024创新实验室-主任：卓大
  * @Date:      2022-09-01 23:14:49
  * @Wechat:    zhuda1024
  * @Email:     lab1024@163.com
  * @Copyright  1024创新实验室 （ https://1024lab.net ），Since 2012
-->
<script setup lang="ts">
defineProps({
  name: String,
  url: String
})
</script>

<template>
  <iframe :id="name" :src="url" frameborder="0" height="800" scrolling="yes" width="100%" />
</template>
