# HUST-typst-template

用于华科毕业设计（本科）的 typst 模板。

## ⚠️风险警告⚠️

- 民间模板，存在不被认可风险
  - 作者用此模板已成功从网安学院毕业
- 有部分难以短期解决的问题：
  - 无伪粗体：暂时无法解决，但是标题所需的黑体粗体在打印出来的情况下几乎看不出区别
  - 无自定义参考文献格式：自己维护引用项顺序（参见sample.typ）

## 什么是 typst

[typst](https://github.com/typst/typst) 是最新最热的标记文本语言，定位与 LaTeX 类似，具有极强的排版能力，通过一定的语法写文档，然后生成 pdf 文件。与 LaTeX 相比有以下的优势：

1. 编译巨快：因为提供增量编译的功能所以在修改后基本能在一秒内编译出 pdf 文件，typst 提供了监听修改自动编译的功能，可以像 Markdown 一样边写边看效果。
2. 环境搭建简单：原生支持中日韩等非拉丁语言，不用再大量折腾字符兼容问题以及下载好几个 G 的环境。只需要下载命令行程序就能开始编译生成 pdf。
3. 语法友好：对于普通的排版需求，上手难度跟 Markdown 相当，同时文本源码阅读性高：不会再充斥一堆反斜杠跟花括号

个人观点：跟 Markdown 一样好用，跟 LaTeX 一样强大

可以从[这里速通 typst](https://typst.app/docs/tutorial)

跟 word 比的优势：格式好调，玄学问题少。

## 其他特性

* 支持匿名处理，anony 参数设置为 true 即为匿名，会把校名以及个人信息等替换成小黑条，论文提交阶段使用，不需要再对 pdf 作特殊编辑（致谢中的敏感信息还是需要自己处理）


## 使用

快速浏览效果：[查看sample.pdf](./sample.pdf)，样例论文源码：[查看sample.typ](./sample.typ)

### 线上编辑

typst 也提供了线上编辑器（类似overleaf），查看本模板：
https://typst.app/project/rqTPs502DAhLTQctaUmbtn

（ps：浏览器可能没有微软宋体、微软黑体等学校要求的字体，不建议在该平台上生成）

### 本地编辑

1. 下载对应平台的 typst：https://github.com/typst/typst/releases 记得先看看它的 README
2. clone 本仓库
3. 按本仓库中的 sample.typ 照葫芦画瓢即可，sample.typ 既是样例也是说明书
4. 在本项目目录里，命令行执行 `typst watch xxx.typ` 的命令即可编译同名 pdf 文件，而且一旦更新就会增量编译，推荐在 VSCode 中写，下载 `Typst LSP` 插件获得语法提示

## 说明

该模板仍需完善，欢迎 issue / pull request 贡献。

主要排版数据参考来自 https://github.com/zfengg/HUSTtex 同时有一定肉眼排版成分，所以有可能不完全符合华科排版要求，如果遇到不对的间距、字体等请提交 issue 说明。

