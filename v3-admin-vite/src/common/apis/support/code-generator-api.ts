import type { ApiResponseData, PageResultModel, SortItemModel } from "types/api"
import { request } from "@/http/axios"

/**
 * 代码生成器
 */
export const codeGeneratorApi = {
  /** 查询数据库的表 */
  queryTableList: (data: CodeGeneratorQueryTableRequest) => {
    return request<ApiResponseData<PageResultModel<CodeGeneratorTableItem>>>({
      url: "support/codeGenerator/table/queryTableList",
      method: "POST",
      data
    })
  },
  /** 查询表的列 */
  getTableColumns: (table: string) => {
    return request<ApiResponseData<PageResultModel<CodeGeneratorTableColumnItem>>>({
      url: `support/codeGenerator/table/getTableColumns/${table}`,
      method: "GET"
    })
  },

  /** 获取表的配置信息 */
  getConfig: (table: string) => {
    return request<ApiResponseData<PageResultModel<CodeGeneratorConfigItem>>>({
      url: `support/codeGenerator/table/getConfig/${table}`,
      method: "GET"
    })
  },
  /** 更新配置信息 */
  updateConfig: (data: CodeGeneratorUpdateConfigRequest) => {
    return request <ApiResponseData<any>>({
      url: "support/codeGenerator/table/updateConfig",
      method: "POST",
      data
    })
  },

  /** 预览代码 */
  preview: (data: CodeGeneratorPreviewRequest) => {
    return request<ApiResponseData<any>>({
      url: "support/codeGenerator/code/preview",
      method: "POST",
      data
    })
  },
  /** 下载代码 */
  downloadCode: (tableName: string) => {
    return request<any>({
      url: `support/codeGenerator/code/download/${tableName}`,
      method: "GET"
    })
  }
}

export interface CodeGeneratorQueryTableRequest {
  /**
   * 页码(不能为空)
   */
  pageNum: number
  /**
   * 每页数量(不能为空)
   */
  pageSize: number
  /**
   * 是否查询总条数
   */
  searchCount?: boolean
  /**
   * 排序字段集合
   */
  sortItemList?: SortItemModel[]
  /**
   * 表名关键字
   */
  tableNameKeywords?: string
  [property: string]: any
}

export interface CodeGeneratorTableItem {
  /**
   * 配置时间
   */
  configTime?: Date
  /**
   * 创建时间
   */
  createTime?: Date
  /**
   * 表备注
   */
  tableComment?: string
  /**
   * 表名
   */
  tableName?: string
  /**
   * 更新时间
   */
  updateTime?: Date
  [property: string]: any
}

export interface CodeGeneratorTableColumnItem {
  /**
   * 列描述
   */
  columnComment?: string
  /**
   * columnKey
   */
  columnKey?: string
  /**
   * 列名
   */
  columnName?: string
  /**
   * 列类型varchar(50)
   */
  columnType?: string
  /**
   * 数据类型varchar
   */
  dataType?: string
  /**
   * extra
   */
  extra?: string
  /**
   * 是否为空
   */
  isNullable?: string
  [property: string]: any
}

export interface CodeGeneratorConfigItem {
  basic?: CodeBasic
  deleteInfo?: CodeDelete
  /**
   * 字段列
   */
  fields?: CodeField[]
  insertAndUpdate?: CodeInsertAndUpdate
  /**
   * 查询字段
   */
  queryFields?: CodeQueryField[]
  /**
   * 列表字段
   */
  tableFields?: CodeTableField[]
  [property: string]: any
}

/**
 * CodeBasic，基础信息
 */
export interface CodeBasic {
  /**
   * 后端作者
   */
  backendAuthor: string
  /**
   * 后端时间
   */
  backendDate: Date
  /**
   * 版权信息
   */
  copyright: string
  /**
   * 注释
   */
  description: string
  /**
   * 前端作者
   */
  frontAuthor: string
  /**
   * 前端时间
   */
  frontDate: Date
  /**
   * java包名
   */
  javaPackageName: string
  /**
   * 业务名称
   */
  moduleName: string
  [property: string]: any
}

/**
 * CodeDelete，删除 信息
 */
export interface CodeDelete {
  /**
   * <br>  export const CODE_DELETE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;SINGLE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'Single',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'单个删除'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;BATCH:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'Batch',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'批量删除'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;SINGLE_AND_BATCH:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'SingleAndBatch',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'单个和批量删除'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  deleteEnum: string
  /**
   * 是否为物理删除
   */
  isPhysicallyDeleted: boolean
  /**
   * 是否支持删除
   */
  isSupportDelete: boolean
  [property: string]: any
}

/**
 * CodeField，字段信息
 */
export interface CodeField {
  /**
   * 自增
   */
  autoIncreaseFlag: boolean
  /**
   * 列备注
   */
  columnComment?: string
  /**
   * 列
   */
  columnName: string
  /**
   * 字典key
   */
  dict?: string
  /**
   * 枚举名称
   */
  enumName?: string
  /**
   * 字段命名
   */
  fieldName: string
  /**
   * java类型
   */
  javaType: string
  /**
   * js类型
   */
  jsType: string
  /**
   * 字段名词
   */
  label: string
  /**
   * 主键
   */
  primaryKeyFlag: boolean
  [property: string]: any
}

/**
 * CodeInsertAndUpdate，增加、修改 信息
 */
export interface CodeInsertAndUpdate {
  /**
   * 每行字段数量
   */
  countPerLine: number
  /**
   * 字段列表
   */
  fieldList?: CodeInsertAndUpdateField[]
  isSupportInsertAndUpdate: boolean
  /**
   * <br>  export const CODE_GENERATOR_PAGE_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;MODAL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'modal',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'弹窗'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;DRAWER:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'drawer',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'抽屉'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;PAGE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'page',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'新页面'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  pageType?: string
  /**
   * 宽度
   */
  width?: string
  [property: string]: any
}

/**
 * CodeInsertAndUpdateField，字段列表
 */
export interface CodeInsertAndUpdateField {
  /**
   * 列名
   */
  columnName: string
  /**
   * <font style="color: red;">【必填】</font>  <br>  export const CODE_FRONT_COMPONENT_ENUM =
   * <BR>
   * {<br>&nbsp;&nbsp;INPUT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'Input',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'输入框'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;INPUT_NUMBER:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'InputNumber',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'数字输入框'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;TEXTAREA:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'Textarea',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'
   * 文本'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;BOOLEAN_SELECT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'BooleanSelect',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'布尔下拉框'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;ENUM_SELECT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'SmartEnumSelect',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'枚举下拉'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;DICT_SELECT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'DictSelect',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'字典下拉'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;DATE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'Date',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'日期选择'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;DATE_TIME:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'DateTime',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'时间选择'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;FILE_UPLOAD:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'FileUpload',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'文件上传'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  frontComponent?: string
  /**
   * 插入标识
   */
  insertFlag: boolean
  /**
   * 必须
   */
  requiredFlag: boolean
  /**
   * 更新标识
   */
  updateFlag: boolean
  [property: string]: any
}

/**
 * CodeQueryField，查询字段
 */
export interface CodeQueryField {
  /**
   * 列
   */
  columnNameList: string[]
  /**
   * 字段名
   */
  fieldName: string
  /**
   * 条件名称
   */
  label: string
  /**
   * <br>  export const CODE_QUERY_FIELD_QUERY_TYPE_ENUM = <BR>
   * {<br>&nbsp;&nbsp;LIKE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'Like',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'模糊查询'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;EQUAL:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'Equal',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'等于'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;DATE_RANGE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'DateRange',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'日期范围'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;DATE:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'Date',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'指定日期'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;ENUM:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'Enum',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'枚举'<br>&nbsp;&nbsp;},<br>&nbsp;&nbsp;DICT:{<br>&nbsp;&nbsp;&nbsp;&nbsp;value:'Dict',<br>&nbsp;&nbsp;&nbsp;&nbsp;desc:'字典'<br>&nbsp;&nbsp;}<br>}
   * <br>
   */
  queryTypeEnum?: string
  /**
   * 宽度
   */
  width: string
  [property: string]: any
}

/**
 * CodeTableField，列表字段
 */
export interface CodeTableField {
  /**
   * 列名
   */
  columnName: string
  /**
   * 自动省略标识
   */
  ellipsisFlag: boolean
  /**
   * 字段命名
   */
  fieldName: string
  /**
   * 字段名词
   */
  label: string
  /**
   * 列表显示
   */
  showFlag: boolean
  /**
   * 宽度
   */
  width?: number
  [property: string]: any
}

export interface CodeGeneratorUpdateConfigRequest {
  basic: CodeBasic
  deleteInfo: CodeDelete
  /**
   * 字段信息
   */
  fields: CodeField[]
  insertAndUpdate: CodeInsertAndUpdate
  /**
   * 查询字段
   */
  queryFields?: CodeQueryField[]
  /**
   * 列表字段
   */
  tableFields?: CodeTableField[]
  /**
   * 表名
   */
  tableName: string
  [property: string]: any
}

export interface CodeGeneratorPreviewRequest {
  /**
   * 表名
   */
  tableName: string
  /**
   * 模板文件
   */
  templateFile: string
  [property: string]: any
}
