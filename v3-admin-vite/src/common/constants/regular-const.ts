/*
 * 正则常量
 *
 * @Author:    1024创新实验室-主任：卓大
 * @Date:      2022-09-06 19:59:05
 * @Wechat:    zhuda1024
 * @Email:     lab1024@163.com
 * @Copyright  1024创新实验室 （ https://1024lab.net ），Since 2012
 */
export const regular = {
  phone: /^(13|14|15|16|17|18|19)\d{9}$/,
  qq: /^[1-9]\d{3,}$/,
  linkUrl:
    /^(https?|ftp):\/\/([a-zA-Z0-9.-]+(:[a-zA-Z0-9.&%$-]+)*@)*((25[0-5]|2[0-4]\d|1\d{2}|[1-9]\d?)(\.(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)){3}|([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(:\d+)*(\/($|[\w.,?'\\+&%$#=~-]+))*$/,

  // eslint-disable-next-line regexp/no-super-linear-backtracking
  isNumber: /(^[\-1-9][1-9]*(.[1-9]+)?)$/, // 判断是否为数字，除了0 外
  isLandlineOrPhone: /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/, // 验证 座机 或者手机
  account: /^[a-z0-9]{3,16}$/, // 请输入3-16位(小写字母|数字)的账号
  mobileAccount: /^[a-z0-9]{6,16}$/, // 请输入6-16位(小写字母|数字)的账号(和移动端保持一致)
  accountDesc: "请输入3-16位(小写字母|数字)的账号",
  pwd: /^[\w.]{6,16}$/, // 请输入6-16位(大小写字母|数字|小数点|下划线)的密码
  pwdDesc: "请输入6-16位(大小写字母|数字|小数点|下划线)的密码",
  delBlankSpace: /\s+/g, // 删除空格
  isPdfReg: /\.(pdf|PDF)/,
  // eslint-disable-next-line regexp/no-dupe-disjunctions
  isElseFileReg: /\.(doc|docx|xls|xlsx|txt|ppt|pptx|pps|ppxs)/,
  isIdentityCard: /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|12]\d)|3[01])\d{3}([0-9X])$/i, // 验证身份证号
  isChinese: /^[\u4E00-\u9FA5]+$/g // 验证是否汉字
}
