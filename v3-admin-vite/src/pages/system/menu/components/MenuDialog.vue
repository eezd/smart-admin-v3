<script lang="ts" setup>
import type { MenuItem, MenuUpdateRequest } from "@@/apis/system/menu-api"
import type { FormInstance, FormRules } from "element-plus"
import { useDevice } from "@/common/composables/useDevice"
import { MENU_PERMS_TYPE_ENUM, MENU_TYPE_ENUM } from "@/common/constants/system/menu-const"
import { menuApi } from "@@/apis/system/menu-api"
import IconSelect from "@@/components/Framework/IconSelect/index.vue"
import * as ElementPlusIcons from "@element-plus/icons-vue"
import MenuTreeSelect from "./MenuTreeSelect.vue"

// #region defineEmits
const emit = defineEmits<{
  submitSuccess: []
}>()
// #endregion

// #region defineModel
const loading = defineModel<boolean>("loading", { required: true })
const dialogVisible = defineModel<boolean>("formDialogVisible", { required: true })
const formData = defineModel<MenuItem>(
  "formData",
  {
    required: true
  }
)
// #endregion

const { isMobile } = useDevice()

const title = computed(() => {
  return formData.value.menuId === undefined ? "新增" : "编辑"
})

const formRef = ref<FormInstance>()
const parentMenuTreeSelectRef = ref<FormInstance>()
const contextMenuTreeSelectRef = ref<FormInstance>()

/**
 * 表单验证规则
 */
const formRules = computed<FormRules<MenuItem>>(() => {
  const rules: FormRules<MenuItem> = {}
  if (!formData.value.menuType) {
    return rules
  }
  // 目录：菜单名称必填
  if (isCatalogType.value) {
    rules.menuName = [
      { required: true, message: "请输入菜单名称", trigger: "blur" }
    ]
  }
  // 菜单：菜单名称、路由地址必填
  if (isMenuType.value) {
    rules.menuName = [
      { required: true, message: "请输入菜单名称", trigger: "blur" }
    ]
    rules.path = [
      { required: true, message: "请输入路由地址", trigger: "blur" }
    ]
  }
  // 按钮/功能点：功能点名称必填
  if (isPointsType.value) {
    rules.menuName = [
      { required: true, message: "请输入功能点名称", trigger: "blur" }
    ]
  }
  return rules
})

const isMenuType = computed(() => formData.value.menuType === MENU_TYPE_ENUM.MENU.value)
const isCatalogType = computed(() => formData.value.menuType === MENU_TYPE_ENUM.CATALOG.value)
const isPointsType = computed(() => formData.value.menuType === MENU_TYPE_ENUM.POINTS.value)

/**
 * 创建或更新
 */
function handleCreateOrUpdate() {
  formRef.value?.validate(async (valid: boolean) => {
    // (valid: boolean, fields)
    if (valid) {
      try {
        loading.value = true
        if (formData.value.menuId) {
          await menuApi.update(formData.value as MenuUpdateRequest)
        } else {
          await menuApi.create(formData.value)
        }
        emit("submitSuccess")
        dialogVisible.value = false
      } finally {
        loading.value = false
      }
    }
  })
}

function selectIcon(iconName: string) {
  formData.value.icon = iconName
}
function getIconComponent(iconName: string) {
  return ElementPlusIcons[iconName as keyof typeof ElementPlusIcons]
}
</script>

<template>
  <el-drawer v-model="dialogVisible" :title="title" direction="rtl" :size="isMobile ? '100%' : '50%'" destroy-on-close>
    <el-form ref="formRef" :model="formData" :rules="formRules" label-position="left" label-width="100px">
      <el-form-item label="菜单类型" prop="menuType">
        <el-radio-group v-model="formData.menuType" size="default">
          <el-radio-button
            v-for="item in MENU_TYPE_ENUM"
            :key="item.value"
            :value="item.value"
          >
            {{ item.desc }}
          </el-radio-button>
        </el-radio-group>
      </el-form-item>

      <el-form-item :label="isCatalogType ? '上级目录' : '上级菜单'">
        <MenuTreeSelect ref="parentMenuTreeSelectRef" v-model:value="formData.parentId" />
      </el-form-item>

      <!-- 目录 菜单 start -->
      <template v-if="isCatalogType || isMenuType">
        <el-form-item prop="menuName" label="菜单名称">
          <el-input v-model="formData.menuName" placeholder="请输入" />
        </el-form-item>

        <el-form-item label="菜单图标" prop="icon">
          <IconSelect @update-icon="selectIcon">
            <template #iconSelect>
              <div style="display: flex; align-items: center; gap: 8px;">
                <el-input
                  v-model="formData.icon"
                  placeholder="请输入菜单图标"
                  style="width: 200px"
                />
                <el-icon v-if="formData.icon && getIconComponent(formData.icon)" size="20">
                  <component :is="getIconComponent(formData.icon)" />
                </el-icon>
              </div>
            </template>
          </IconSelect>
        </el-form-item>

        <!-- 菜单专用 -->
        <template v-if="isMenuType">
          <el-form-item label="路由地址" prop="path">
            <el-input v-model="formData.path" placeholder="请输入路由地址" />
          </el-form-item>

          <el-form-item v-if="formData.frameFlag" label="外链地址" prop="frameUrl">
            <el-input v-model="formData.frameUrl" placeholder="请输入外链地址" />
          </el-form-item>
          <el-form-item v-else label="组件地址" prop="component">
            <el-input
              v-model="formData.component"
              placeholder="请输入组件地址 默认带有开头@/views"
            />
            <template #extra>
              <div class="el-form-item__extra">
                比如 商品列表：/business/erp/goods/goods-list.vue
              </div>
            </template>
          </el-form-item>

          <el-form-item inline-prompt label="是否缓存" prop="cacheFlag">
            <el-switch
              v-model="formData.cacheFlag"
              inline-prompt
              active-text="开启缓存"
              inactive-text="不缓存"
            />
          </el-form-item>

          <el-form-item inline-prompt label="是否外链" prop="frameFlag">
            <el-switch
              v-model="formData.frameFlag"
              inline-prompt
              active-text="是外链"
              inactive-text="不是外链"
            />
          </el-form-item>
        </template>

        <el-form-item label="显示状态" prop="visibleFlag">
          <el-switch
            v-model="formData.visibleFlag"
            inline-prompt
            active-text="显示"
            inactive-text="不显示"
          />
        </el-form-item>

        <el-form-item label="禁用状态" prop="disabledFlag">
          <el-switch
            v-model="formData.disabledFlag"
            inline-prompt
            :active-value="false"
            :inactive-value="true"
            active-text="启用"
            inactive-text="禁用"
          />
        </el-form-item>
      </template>
      <!-- 目录 菜单 end -->

      <!-- 功能点 start -->
      <template v-if="isPointsType">
        <el-form-item label="功能点名称" prop="menuName">
          <el-input v-model="formData.menuName" placeholder="请输入功能点名称" />
        </el-form-item>

        <el-form-item label="功能点关联菜单">
          <MenuTreeSelect ref="contextMenuTreeSelectRef" v-model:value="formData.contextMenuId" />
        </el-form-item>

        <el-form-item label="功能点状态" prop="funcDisabledFlag">
          <el-switch
            v-model="formData.disabledFlag"
            :active-value="false"
            :inactive-value="true"
            active-text="启用"
            inactive-text="禁用"
          />
        </el-form-item>

        <el-form-item label="权限类型" prop="permsType">
          <el-radio-group v-model="formData.permsType" size="default">
            <el-radio-button
              v-for="item in MENU_PERMS_TYPE_ENUM"
              :key="item.value"
              :value="item.value"
            >
              {{ item.desc }}
            </el-radio-button>
          </el-radio-group>
        </el-form-item>

        <el-form-item label="前端权限" prop="webPerms">
          <el-input v-model="formData.webPerms" placeholder="请输入前端权限" />
          <template #extra>
            <div class="el-form-item__extra">
              用于前端按钮等功能的展示和隐藏，搭配v-privilege使用
            </div>
          </template>
        </el-form-item>

        <el-form-item label="后端权限" prop="apiPerms">
          <el-input v-model="formData.apiPerms" placeholder="请输入后端权限" />
          <template #extra>
            <div class="el-form-item__extra">
              后端@SaCheckPermission中的权限字符串，多个以英文逗号,分割
            </div>
          </template>
        </el-form-item>
      </template>
      <!-- 功能点 end -->

      <el-form-item label="排序" prop="sort">
        <el-input-number
          v-model="formData.sort"
          :min="0"
          placeholder="请输入排序"
          style="width: 100px"
        />
        <template #extra>
          <div class="el-form-item__extra">
            值越小越靠前
          </div>
        </template>
      </el-form-item>
    </el-form>

    <template #footer>
      <el-button @click="dialogVisible = false">
        取消
      </el-button>
      <el-button type="primary" :loading="loading" @click="handleCreateOrUpdate">
        确认
      </el-button>
    </template>
  </el-drawer>
</template>

<style lang="scss" scoped>
</style>
