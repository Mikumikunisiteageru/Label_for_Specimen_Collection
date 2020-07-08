[//]: # (nanicolle/README.md)
[//]: # (20200708)

# nanicolle

nanicolle 是一个用于排版中式和西式植物标本采集标签和鉴定标签的 LaTeX 文档类。

## 用法

在使用 nanicolle 文档类排版标签之前，须做好以下准备：
- 安装好 TeX 的某个发行版；
- 下载了 nanicolle 宏包（如使用最新版的 TeX Live 或 MikTeX，则可跳过此步骤）；
- 有一个工作表软件（如 Microsoft Office Excel）。

这时，在命令行中输入 `xelatex` 并回车，应该可以看到一点（非平凡的）东西。按 `x` 并回车即可退出。

完成准备工作后，就可使用 nanicolle 文档类排版标签了。完整的工作流程如下：
1. 在工作表中建立原始数据库；
2. 在 `nanicolle.cls` 的同一目录中建立 TeX 源文件；
3. 使用 XeLaTeX 编译。

### 准备原始数据库

建立工作表，在第一行中从左到右分别填写 `命令` `记录号` `采集人` `采集号` `采集日期` `科名` `中文名` `学名` `照片号` `标本份数` `产地` `经度` `纬度` `海拔` `生境` `生活型` `体高` `胸径` `附注` 共 19 格。以下诸行分别依实际状况填写，但 `命令` 以下的单元格需统一填写 `\Collect`。其余各项的意义与填写要求，见手册文件 `nanicolle.pdf`。

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
