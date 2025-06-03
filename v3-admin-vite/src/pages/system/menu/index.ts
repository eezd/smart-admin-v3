/*
 * 此文件是处理 菜单数据的类，主要用于：
 * 1、菜单树形表格的构造
 * 2、菜单的前端过滤
 *
 * @Author:    1024创新实验室-主任：卓大
 * @Date:      2022-06-15 16:47:20
 * @Wechat:    zhuda1024
 * @Email:     lab1024@163.com
 * @Copyright  1024创新实验室 （ https://1024lab.net ），Since 2012
 */

import type { MenuItem } from "@/common/apis/system/menu-api"
import { isNil } from "lodash-es"

export interface SearchParams {
  keywords: string
  menuType: number | undefined
  disabledFlag: number | undefined
  frameFlag: number | undefined
  cacheFlag: number | undefined
  visibleFlag: number | undefined
}

export interface MenuTreeItem extends MenuItem {
  children?: MenuTreeItem[] // 明确树形结构
  level?: number // 可选：添加层级标记
  isLeaf?: boolean // 可选：标记是否为叶子节点
}

/**
 * 过滤菜单
 * @param {*} menuList
 * @param {*} queryForm
 * @returns
 */
export function filterMenuByQueryForm(menuList: MenuItem[], queryForm: SearchParams) {
  if (!menuList || menuList.length === 0) {
    return []
  } else if (queryForm === undefined) {
    return menuList
  }
  const filterResult = []
  for (const menu of menuList) {
    // console.log(menu, isMenuExistKeywords(menu, queryForm.keywords), isMenuExistMenuType(menu, queryForm.menuType), isMenuExistMenuFlag(menu, queryForm))
    if (isMenuExistKeywords(menu, queryForm.keywords) && isMenuExistMenuType(menu, queryForm.menuType) && isMenuExistMenuFlag(menu, queryForm)) {
      filterResult.push(menu)
    }
  }
  return filterResult
}

/**
 * 构建菜单表格树形数据
 */
export function buildMenuTableTree(menuList: MenuItem[]) {
  const topMenuList = []
  const menuIdSet = new Set()
  for (const menu of menuList) {
    menuIdSet.add(menu.menuId)
  }

  for (const menu of menuList) {
    const parentId = menu.parentId
    // 不存在父节点，则为顶级菜单
    if (!menuIdSet.has(parentId)) {
      topMenuList.push(menu)
    }
  }

  recursiveMenuTree(menuList, topMenuList)
  return topMenuList
}

/**
 * 递归遍历菜单树形数据
 * @param {*} menuList
 * @param {*} parentArray
 */
function recursiveMenuTree(menuList: MenuItem[], parentArray: MenuItem[]) {
  for (const parent of parentArray) {
    const children = menuList.filter(e => e.parentId === parent.menuId)
    if (children.length > 0) {
      parent.children = children
      recursiveMenuTree(menuList, parent.children)
    }
  }
}

/**
 * 过滤菜单状态
 * @param {*} menu
 * @param {*} queryForm
 * @returns
 */
function isMenuExistMenuFlag(menu: MenuItem, queryForm: SearchParams) {
  let frameFlagCondition = false
  if (!isNil(queryForm.frameFlag)) {
    frameFlagCondition = !isNil(menu.frameFlag) && menu.frameFlag === (queryForm.frameFlag === 1)
  } else {
    frameFlagCondition = true
  }

  let cacheFlagCondition = false
  if (!isNil(queryForm.cacheFlag)) {
    cacheFlagCondition = !isNil(menu.cacheFlag) && menu.cacheFlag === (queryForm.cacheFlag === 1)
  } else {
    cacheFlagCondition = true
  }

  let visibleFlagCondition = false
  if (!isNil(queryForm.visibleFlag)) {
    visibleFlagCondition = !isNil(menu.visibleFlag) && menu.visibleFlag === (queryForm.visibleFlag === 1)
  } else {
    visibleFlagCondition = true
  }

  let disabledFlagCondition = false
  if (!isNil(queryForm.disabledFlag)) {
    disabledFlagCondition = !isNil(menu.disabledFlag) && menu.disabledFlag === (queryForm.disabledFlag === 1)
  } else {
    disabledFlagCondition = true
  }
  return frameFlagCondition && cacheFlagCondition && visibleFlagCondition && disabledFlagCondition
}

/**
 * 过滤菜单类型
 * @param {*} menu
 * @param {*} menuType
 * @returns
 */
function isMenuExistMenuType(menu: MenuItem, menuType: number | undefined) {
  if (!menuType) {
    return true
  }

  if (menu.menuType && menu.menuType === menuType) {
    return true
  }
  return false
}

/**
 * 过滤关键字
 */
function isMenuExistKeywords(menu: any, keywords: string) {
  if (!keywords) {
    return true
  }
  if (menu.component && menu.component.includes(keywords)) {
    return true
  }
  if (menu.menuName && menu.menuName.includes(keywords)) {
    return true
  }
  if (menu.path && menu.path.includes(keywords)) {
    return true
  }
  if (menu.apiPerms && menu.apiPerms.includes(keywords)) {
    return true
  }
  if (menu.webPerms && menu.webPerms.includes(keywords)) {
    return true
  }
  return false
}
