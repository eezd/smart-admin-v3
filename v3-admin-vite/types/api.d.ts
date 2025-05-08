export interface ApiResponseData<T> {
  /**
   * 返回码
   */
  code: number
  data: T
  /**
   * 数据类型
   * export const DATA_TYPE_ENUM = {
   * NORMAL: { value: 1, desc: '普通数据'},
   * ENCRYPT: { value: 10, desc: '加密数据'}
   * }
   */
  dataType: number
  /**
   * 级别
   */
  level: string
  msg: string
  ok: boolean
  [property: string]: any
}

export interface SortItemModel {
  /**
   *
   * @type {boolean}
   * @memberof SortItemModel
   */
  asc: boolean
  /**
   *
   * @type {string}
   * @memberof SortItemModel
   */
  column: string
}

export interface PageResultModel<T> {
  /**
   * 是否为空
   * @type {boolean}
   * @memberof PageResultModel
   */
  emptyFlag?: boolean
  /**
   * 结果集
   * @type {Array<T>}
   * @memberof PageResultModel
   */
  list: Array<T>
  /**
   * 当前页
   * @type {number}
   * @memberof PageResultModel
   */
  pageNum?: number
  /**
   * 每页的数量
   * @type {number}
   * @memberof PageResultModel
   */
  pageSize?: number
  /**
   * 总页数
   * @type {number}
   * @memberof PageResultModel
   */
  pages?: number
  /**
   * 总记录数
   * @type {number}
   * @memberof PageResultModel
   */
  total: number
}

export interface PageParamModel {
  /**
   * 页码(不能为空)
   * @type {number}
   * @memberof ClueUserQueryForm
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   * @type {number}
   * @memberof ClueUserQueryForm
   */
  pageSize: number

  /**
   * 排序字段集合
   * @type {Array<SortItemDto>}
   * @memberof ClueUserQueryForm
   */
  sortItemList?: Array<SortItemModel>
}
