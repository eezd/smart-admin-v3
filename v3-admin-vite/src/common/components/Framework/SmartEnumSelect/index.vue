<script setup lang="ts">
import { getCurrentInstance, onMounted, ref, watch } from "vue"

interface ValueDescItem {
  value: string | number
  desc: string
}

interface Props {
  enumName?: string
  width?: string
  placeholder?: string
  size?: "large" | "default" | "small"
  disabled?: boolean
  disabledOption?: (string | number)[]
  hiddenOption?: (string | number)[]
}

const props = withDefaults(defineProps<Props>(), {
  width: "100%",
  placeholder: "请选择",
  size: "default",
  disabled: false,
  disabledOption: () => [],
  hiddenOption: () => []
})

// #region defineModel
const selectValue = defineModel<any>("value", { required: true })
// #endregion

const valueDescList = ref<ValueDescItem[]>([])

onMounted(() => {
  const internalInstance = getCurrentInstance()
  const smartEnumPlugin = internalInstance?.appContext.config.globalProperties.$smartEnumPlugin

  if (smartEnumPlugin && props.enumName) {
    valueDescList.value = smartEnumPlugin
      .getValueDescList(props.enumName)
      .filter((item: ValueDescItem) => !props.hiddenOption.includes(item.value))
  }
})
</script>

<template>
  <el-select
    v-model="selectValue"
    :style="`width: ${width}`"
    :placeholder="props.placeholder"
    filterable
    clearable
    :size="size"
    :disabled="disabled"
  >
    <el-option
      v-for="item in valueDescList"
      :key="item.value"
      :value="item.value"
      :label="item.desc"
      :disabled="disabledOption.includes(item.value)"
    />
  </el-select>
</template>
