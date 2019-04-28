[//]: # (nanicolle/README.md)
[//]: # (20190428)

# nanicolle

nanicolle 是一个用于排版植物标本中文采集标签和鉴定标签的 LaTeX 文档类。

## 关于 TeX 等

据我观察，TeX 在植物学界中并不流行。因此，这里不妨简单介绍一下。

TeX 是一个自由的排版程序，由 Donald E. Knuth 教授发明于 1978 年。LaTeX 是 TeX 的一种格式。XeTeX 是一个原生支持 Unicode 的 TeX 类程序，和 LaTeX 格式组合起来便称为 XeLaTeX。TeX 中 X 的发音与现代汉语拼音中的 h（中的辅音）一致。

TeX 有很多发行版，这些发行版中除了 TeX 等程序本身还包含了大量的宏包，方便用户获得更丰富的功能。
要获得 TeX 等程序及相关宏包，推荐安装最新的 TeX Live 发行版（目前的版本是 TeX Live 2018）。

Microsoft Office Word 是文字处理软件，其功能和 TeX 有些类似。除了授权类型不同（前者是要收费的商业软件）外，二者还有着不同的工作方式：Word 是“所见即所得”的，而 TeX 则是标记语言，是“所思即所得”的。TeX 的源文件是纯文本格式，经排版引擎编译后转换成 PDF 等可以直接印刷的格式。二者各有所长。

nanicolle 是 LaTeX 格式的一个宏包，当中提供了同名的文档类。这个宏包不包含能独立运行的软件，它仅定义了一些能被 XeLaTeX 程序识别的通用命令。要使用 nanicolle 文档类生成标本的标签，需要用 XeLaTeX 程序执行。

了解更多 TeX 的知识，可参考：
- https://liam.page/2014/09/08/latex-introduction/
- https://www.jianshu.com/p/3e842d67ada2

## 用法

在使用 nanicolle 文档类排版标签之前，须做好以下准备：
- 安装好 TeX 的某个发行版；
- 下载了 nanicolle 宏包；
- 已经有一个工作表软件（如 Microsoft Office Excel）。

这时，在命令行中输入 `xelatex` 并回车，应该可以看到一点（非平凡的）东西。按 `x` 并回车即可退出。

完成准备工作后，就可使用 nanicolle 文档类排版标签了。完整的工作流程如下：
1. 在工作表中建立原始数据库；
2. 在 `nanicolle.cls` 的同一目录中建立 TeX 源文件；
3. 使用 XeLaTeX 编译。

### 准备原始数据库

建立工作表，在第一行中从左到右分别填写 `命令` `记录号` `采集人` `采集号` `采集日期` `科名` `中文名` `学名` `照片号` `标本份数` `产地` `经度` `纬度` `海拔` `生境` `生活型` `体高` `胸径` `描述` 共 19 格。以下诸行分别依实际状况填写，但 `命令` 以下的单元格需统一填写 `\Collect`。其余各项的意义与填写规范，见手册文件 `nanicolle.pdf`。

### 建立 TeX 源文件

使用任意的文本编辑器，新建文本文件，并输入：
~~~latex
\documentclass{nanicolle}
\begin{document}

\end{document}
~~~
之后，复制原始数据库当中的若干整行，粘贴到 `\begin{document}` 和 `\end{document}` 之间。此时，源文件已经完成了。

这个文本文件需要以文件名 `<filename>.tex` 保存于 `nanicolle.cls` 所在的目录下，当中 `<filename>` 不应包含汉字、空格或句点 `.`。

### 使用 XeLaTeX 编译

打开命令行，定位到 `nanicolle.cls` 所在的目录，输入 `xelatex <filename>` 并回车，程序运行完成后，便可以在当前目录下得到 `<filename>.pdf`。这个 PDF 文件就包含可直接打印的标签。

## 在线版本

`nanicolle` 的在线版本自 2018.6.19 起发布于
- http://www.chinaplantredlist.org/NaniColle/doge.php

其内部版本为 v1.14，和最新 v2.00 不兼容。

使用在线版本可以免于安装相关的支持程序，在线得到 PDF 标签。

## 版本历史

- v1.01: 2016.8.3
- ...
- v2.00: 2019.4.28



