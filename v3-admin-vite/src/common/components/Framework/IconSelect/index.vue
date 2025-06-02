<!--
  * Element Plus 图标选择组件
-->
<script setup lang="ts">
import { Search } from "@element-plus/icons-vue"
import * as ElementPlusIcons from "@element-plus/icons-vue"
import { computed, ref, watch } from "vue"

// 对外抛出选择图标事件
const emit = defineEmits<{
  updateIcon: [iconName: string]
}>()

// Element Plus 图标数组
const allIcons = Object.keys(ElementPlusIcons)

// 分类图标（根据Element Plus图标特点进行分类）
const outlinedIconArray = allIcons.filter(name =>
  !name.includes("Filled") && name !== "Search"
)

const filledIconArray = allIcons.filter(name =>
  name.includes("Filled") || ["CirclePlus", "CircleMinus", "CircleCheck", "CircleClose"].includes(name)
)

// 显示/隐藏
const visible = ref(false)

// 展开更多
const SHOW_MORE_LENGTH = 35
const showMoreIndex = ref(SHOW_MORE_LENGTH)

function showMore() {
  showMoreIndex.value = -1
}

// 图标展示与搜索
const iconStyle = ref("outlined")
const selectIconArray = ref([...outlinedIconArray])

const iconLoopArray = computed(() => {
  if (showMoreIndex.value === -1) {
    return selectIconArray.value
  }
  return selectIconArray.value.slice(0, showMoreIndex.value)
})

const searchValue = ref("")

function updateSelectIconArray() {
  let tempArray: string[] = []

  if (iconStyle.value === "outlined") {
    tempArray = outlinedIconArray
  } else {
    tempArray = filledIconArray
  }

  if (!searchValue.value) {
    selectIconArray.value = tempArray
  } else {
    selectIconArray.value = tempArray.filter(name =>
      name.toLowerCase().includes(searchValue.value.toLowerCase())
    )
  }

  // 重置展开状态
  if (selectIconArray.value.length > SHOW_MORE_LENGTH) {
    showMoreIndex.value = SHOW_MORE_LENGTH
  } else {
    showMoreIndex.value = -1
  }
}

// 获取图标组件
function getIconComponent(iconName: string) {
  return ElementPlusIcons[iconName as keyof typeof ElementPlusIcons]
}

// 监听图标风格变化
watch(iconStyle, () => {
  updateSelectIconArray()
})

function handleClick(iconName: string) {
  visible.value = false
  emit("updateIcon", iconName)
}

// 初始化
updateSelectIconArray()
</script>

<template>
  <div>
    <el-popover
      v-model:visible="visible"
      placement="bottom-start"
      trigger="click"
      :width="450"
      popper-class="icon-select-popover"
    >
      <template #reference>
        <slot name="iconSelect" />
      </template>

      <template #default>
        <div class="icon-select-header">
          <el-form-item label="图标风格" style="margin-bottom: 12px;">
            <el-radio-group
              v-model="iconStyle"
              size="small"
              @change="updateSelectIconArray"
            >
              <el-radio-button value="outlined">
                线框风格
              </el-radio-button>
              <el-radio-button value="filled">
                实心风格
              </el-radio-button>
            </el-radio-group>
          </el-form-item>

          <el-form-item style="margin-bottom: 12px;">
            <el-input
              v-model="searchValue"
              placeholder="输入英文关键词进行搜索"
              clearable
              @input="updateSelectIconArray"
            >
              <template #prefix>
                <el-icon><Search /></el-icon>
              </template>
            </el-input>
          </el-form-item>
        </div>

        <div class="icon-box">
          <div
            v-for="item in iconLoopArray"
            :key="item"
            class="icon-content"
            :title="item"
            @click="handleClick(item)"
          >
            <el-icon :size="20">
              <component :is="getIconComponent(item)" />
            </el-icon>
          </div>

          <div v-if="showMoreIndex > 0 && selectIconArray.length > SHOW_MORE_LENGTH" class="show-more-btn">
            <el-button type="primary" link size="small" @click="showMore">
              点击展开更多图标（共{{ selectIconArray.length }}个）
            </el-button>
          </div>
        </div>
      </template>
    </el-popover>
  </div>
</template>

<style scoped>
.icon-select-header {
  border-bottom: 1px solid var(--el-border-color-light);
  padding-bottom: 12px;
  margin-bottom: 12px;
}

.icon-box {
  overflow: auto;
  width: 100%;
  height: 300px;
  display: flex;
  flex-wrap: wrap;
  align-content: flex-start;
  gap: 8px;
}

.icon-content {
  width: 44px;
  height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border-radius: 6px;
  border: 1px solid var(--el-border-color);
  transition: all 0.2s;
  background-color: var(--el-bg-color);
}

.icon-content:hover {
  background-color: var(--el-color-primary);
  border-color: var(--el-color-primary);
  color: white;
  transform: scale(1.05);
}

.show-more-btn {
  width: 100%;
  text-align: center;
  padding: 12px 0;
  border-top: 1px solid var(--el-border-color-light);
  margin-top: 8px;
}
</style>

<style>
.icon-select-popover {
  padding: 16px !important;
}
</style>
