%% nanicolle.cls
%% Copyright 2016--2020 Yuchang Yang < yang.yc.allium@gmail.com >
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Yuchang Yang.
%
% This work consists of:
%   - the class file: [nanicolle.cls];
%   - the illustration files: [point.pdf, ChinaMainland.pdf, Dongguan.pdf];
%   - the manual files: [nanicolle-zh.tex, nanicolle-zh.pdf, 
%                        nanicolle-en.tex, nanicolle-en.pdf, README.md];
%   - the example files: [nanicolle-example-zh.tex, nanicolle-example-zh.pdf,
%                         nanicolle-example-en.tex, nanicolle-example-en.pdf].
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nanicolle}[2020/07/08 v2.02 class nanicolle]
% CATCODE PART I
\makeatletter
% CLASS OPTIONS
\newif\if@rulerhead
  \@rulerheadfalse
\newif\if@col@barcode
  \@col@barcodefalse
\newif\if@det@barcode
  \@det@barcodefalse
\newif\if@auto@duplicate
  \@auto@duplicatefalse
\newif\ifmap
  \maptrue
\newif\if@internal
  \@internalfalse
\DeclareOption{rulerhead}{\@rulerheadtrue}
\DeclareOption{colbarcode}{\@col@barcodetrue}
\DeclareOption{detbarcode}{\@det@barcodetrue}
\DeclareOption{nomap}{\mapfalse}
\DeclareOption{autoduplicate}{\@auto@duplicatetrue}
\DeclareOption{internal}{\@internaltrue}
\ProcessOptions
\LoadClass[UTF8,oneside]{ctexart}
% CONSTANT INTEGERS
\chardef\@ne=1
\chardef\tw@=2
\chardef\thr@@=3
\chardef\f@ur=4
\chardef\@other=12
\chardef\Identify@len=8
\chardef\Collect@len=19
% CONSTANT CHARACTER AND STRINGS
\def\space{ }
\def\@unit{pt}
\def\vb@xt@{\vbox to}
% CATCODE PART II
% CONDITIONS
\newif\if@param@enough@
\newif\if@drew@map@
\newif\if@barcodeprepared@
\newif\if@identifying@
  \@identifying@false
% KERNING AND SPACING
\def\!{\kern-.0889em\relax}
\def\:{\kern+.0667em\relax}
\def\,{\kern+.1667em\relax}
\def\;{\kern+.2777em\relax}
\frenchspacing
% DIMENSIONS
\newdimen\NC@margin
  \setlength\NC@margin{21.0757pt}
\newdimen\NC@seprule
  \setlength\NC@seprule{0.14pt}
\newdimen\NC@fontsize
  \setlength\NC@fontsize{9.3939pt}
  \renewcommand\normalsize{\fontsize\NC@fontsize\NC@fontsize\selectfont}
\newdimen\map@x
\newdimen\map@y
\setlength\parskip\z@
\setlength\parindent\z@
\setlength\linewidth{169.1102pt}
% PAGE LAYOUT
\RequirePackage{graphicx}
\RequirePackage{geometry}
  \geometry{paperwidth=297mm, paperheight=210mm, 
    left=\NC@margin, right=\NC@margin, top=\z@, bottom=\z@}
\RequirePackage{multicol}
  \setlength\columnsep{2\NC@margin}
  \setlength\columnseprule{\NC@seprule}
% COUNTS
\newcount\repeat@cnt
\newcount\word@cnt
% BOXES
\newbox\header@box
\newbox\temp@box
\newbox\pin@point
  \setbox\pin@point=\vb@xt@\z@{\vss\hb@xt@\z@{%
    \hss\includegraphics{point.pdf}\hss}\vss}
% 20190926
\newdimen\whiterule
\newdimen\whitevsep
\newdimen\whitehsep
\whiterule=1.5pt
\whitevsep=0.7pt
\whitehsep=0.3pt
\def\white@uline#1{%
  \setbox\@tempboxa\hbox{\bfseries#1}%
  \@tempdima\dimexpr\whiterule+%
    \whitevsep+\dp\@tempboxa\relax
  \leavevmode\allowbreak\hbox{%
    \kern-\whitehsep
    \lower\@tempdima\vbox{%
      \hbox{%
        \kern\whitehsep
        \box\@tempboxa
        \kern\whitehsep}%
      \vskip\whitevsep
      {\color{white}\hrule\@height\whiterule}}%
    \kern-\whitehsep}}
\long\def\lines@box#1{%
  \setbox\@tempboxa=\vbox{#1\par}%
  \vbox to \ht\@tempboxa{\leaders\hb@xt@\hsize{%
    \kern1em\uline{\strut\hfill}}\vfill
    \kern-1em}\vskip-\ht\@tempboxa\box\@tempboxa\par}
% UNIT EXPRESSIONS
\def\degree{\ensuremath{^\circ}}
\def\add@degree#1#2#3{%
  \edef\@arg{#1}%
  \if\relax#1\relax\else
    \ifdim#1\@unit>\z@
      #1\:\degree\!#2%
    \else
      \expandafter\@gobble\@arg\:\degree\!#3%
    \fi
  \fi}
\def\add@long#1{\add@degree{#1}EW}
\def\add@lat#1{\add@degree{#1}NS}
\def\add@unit#1#2{%
  \if\relax#1\relax\else
    #1\,#2%
  \fi}
\def\add@cm#1{\add@unit{#1}{cm}}
\def\add@m#1{\add@unit{#1}{m}}
% PARSING
% LATIN PARSING
\def\inter@taxon@skip{ \hskip .1667em minus .1667em\relax}
\def\upd@shape{%
  \advance\word@cnt-\@ne
  \ifcase\word@cnt
    \upshape
    \unskip\penalty-\f@ur
    \inter@taxon@skip
  \or
    \itshape
  \fi\ignorespaces}
\RequirePackage{xstring}
\def\strsubs#1#2{%
  \StrSubstitute{\@tempstring}{#1}{#2}[\@tempstring]\ignorespaces}
\def\handle@f{\textup{f.}\unless\ifnum\word@cnt<0\word@cnt\tw@\fi}
\def\latin@parse#1{%
  \word@cnt\tw@
  \edef\@tempstring{#1}%
  \expandarg
  \strsubs{ '}{ \upshape`}
  \strsubs{ }{ \upd@shape}%
  \strsubs{subsp.}{\textup{subsp.}\word@cnt\tw@}
  \strsubs{var.}{\textup{var.}\word@cnt\tw@}
  \strsubs{f.}{\handle@f}
  \strsubs{sp.}{\upshape sp.\word@cnt\z@}
  \strsubs{cf.}{\textup{cf.}\word@cnt\tw@}
  \strsubs{aff.}{\textup{aff.}\word@cnt\tw@}
  \strsubs{et}{\penalty-\@ne et\penalty-\@ne}
  \strsubs{ex}{\penalty-\tw@ et\penalty-\tw@}
  \strsubs{(}{\penalty-\thr@@(}\strsubs{)}{)\penalty-\thr@@}
  \strsubs{×}{\ensuremath{\mathsf{\times}}\word@cnt\@ne\ignorespaces}
  {\itshape\@tempstring}}
\def\col@latin#1{%
  \raggedright
  \hangindent=4em
  \latin@parse{#1}}
\def\det@latin#1{%
  \latin@parse{#1}}
\RequirePackage{listofitems}
  \reademptyitems
  \catcode`\^^I\@other
  \setsepchar{^^I}
\def\get@argin#1{%
  \ifnum#1>\temp@arginlen\relax
    \else\temp@argin[#1]\fi}
\def\col@parse@params#1{%
  \readlist\temp@argin{#1}
  \@param@enough@true
  \def\RecNum{\get@argin{2}}
  \def\Collector{\get@argin{3}}
  \def\ColNum{\get@argin{4}}
  \def\ColDate{\get@argin{5}}
  \def\Family{\get@argin{6}}
  \def\ChnName{\get@argin{7}}
  \edef\LatName{\get@argin{8}}
  \def\PhotoNum{\get@argin{9}}
  \def\NumDup{\get@argin{10}}
  \def\Location{\get@argin{11}}
  \def\Longitude{\get@argin{12}}
  \def\Latitude{\get@argin{13}}
  \def\Altitude{\get@argin{14}}
  \def\Habitat{\get@argin{15}}
  \def\LifeForm{\get@argin{16}}
  \def\Height{\get@argin{17}}
  \def\DBH{\get@argin{18}}
  \def\Descr{\get@argin{19}}
  \repeat@cnt\@ne
  \if@auto@duplicate\if\relax\NumDup\relax\else
    \repeat@cnt\NumDup\relax
  \fi\fi
  \if\relax\Collector\relax\@param@enough@false\fi
  \if\relax\ColDate\relax\@param@enough@false\fi
  \if\relax\Location\relax\@param@enough@false\fi}
\def\det@parse@params#1{%
  \readlist\temp@argin{#1}
  \@param@enough@true
  \def\RecNum{\get@argin{2}}
  \def\LatName{\get@argin{3}}
  \def\ChnName{\get@argin{4}}
  \def\Identifier{\get@argin{5}}
  \def\IdentifierStd{\get@argin{6}}
  \def\DateIdentification{\get@argin{7}}
  \def\Remark{\get@argin{8}}
  \def\temp@name{\Identifier\IdentifierStd}
  \if\relax\LatName\relax\@param@enough@false\fi
  \if\relax\temp@name\relax\@param@enough@false\fi
  \if\relax\DateIdentification\relax\@param@enough@false\fi}
% FONT STYLE
\def\headerstyle{\bfseries}
\def\headingstyle{\scshape}
\def\detlatinstyle{\sffamily\bfseries}
\def\detchinesestyle{\bfseries}
\def\identifierstyle{\itshape}
% INDIVIDUALIZATION
\def\@herbariumcode{}
\def\@heading{}
\def\@subheading{}
\def\herbariumcode#1{\def\@herbariumcode{#1}}
\def\heading#1{\def\@heading{#1}}
\def\subheading#1{\def\@subheading{#1}}
% MAP DEFINITION
\def\mapdef#1#2#3#4#5#6{%
  \expandafter\newbox\csname#1@map\endcsname
    \setbox\csname#1@map\endcsname=\hbox{%
      \includegraphics[width=\linewidth]{#2}}%
  \expandafter\def\csname#1@longmin\endcsname{#3}%
  \expandafter\def\csname#1@longmax\endcsname{#4}%
  \expandafter\def\csname#1@latmin\endcsname{#5}%
  \expandafter\def\csname#1@latmax\endcsname{#6}}
% MAP DEFINITIONS
\mapdef{ChinaMainland}{ChinaMainland.pdf}{73}{136}{17}{54}
% \mapdef{Dongguan}{Dongguan.pdf}{113.5}{114.26667}{22.63333}{23.16667}
% FULL LINE COMMAND TRICK
\begingroup
  \catcode`\^^M\@other%
  \gdef\def@to@eol#1#2{%
    \gdef#1{\begingroup\catcode`\^^M\@other\csname\string#1\endcsname}%
    \expandafter\gdef\csname\string#1\endcsname##1^^M{#2{##1}\endgroup}}%
\endgroup
% COMPONENTS IN COMMON
\def\cutting@line{%
  \nointerlineskip
  \centerline{\hss\rule{.25\paperwidth}{\NC@seprule}\hss}}
% COMPONENTS OF COLLECTION LABELS
\RequirePackage{color}
\def\if@over@length@or#1#2{%
  \setbox\header@box=\hbox{\headerstyle\white@uline{#1}}%
  \setbox\temp@box=\hbox{\copy\header@box\quad#2}%
  \ifdim\wd\temp@box>\linewidth
    \par\hangindent=1em\relax
    \leavevmode\box\header@box\quad\CJKglue#2\par
  \else}
\def\form@line#1#2{%
  \if@over@length@or{#1}{#2}%
    \leavevmode\box\header@box
    \quad\hfill#2\hskip\stretch2\null\par\fi}
\def\form@cell#1#2{%
  \if@over@length@or{#1}{#2}%  
    \leavevmode\box\header@box
    \;\hfill#2\hfill\;\null\penalty-1\relax\ignorespaces\fi}
\def\heading@line#1{%
  \setbox\temp@box=\hbox{#1}%
  \ifdim\wd\temp@box>\linewidth
    \centerline{\resizebox{\linewidth}{\height}{\box\temp@box}}%
  \else
    \centerline{\box\temp@box}%
  \fi}
\if@rulerhead
  \RequirePackage{rulerbox}
    \setlength\rulersep{-.2pt}
    \setlength\rulerwidth{1mm}
\fi
\def\printheadings{%
  \if\relax\@heading\relax\else
    \heading@line{\headingstyle\@heading}
    \if\relax\@subheading\relax\else
      \vskip-2pt\relax
      \heading@line{\headingstyle\@subheading}\fi
    \if@rulerhead
      \nointerlineskip\vskip2pt\relax
      \centerline{%
        \rulerbox[tb]{\kern-.9mm\rule{6.18cm}{.4pt}\kern-.9mm}}%
      \vskip5pt\relax
    \else
      \hrule\@height\NC@seprule
      \vskip9pt\relax
    \fi
  \fi}
\def\printform{%
  \lines@box{%
    \form@line{采集人}{\Collector}%
    \form@cell{采集号}{\ColNum}%
      \if@internal\form@cell{照片号}{\PhotoNum}\par\fi
    \form@cell{采集日期}{\ColDate}%
      \if@internal\form@cell{标本份数}{\NumDup}\fi\par
    \form@line{产地}{\Location}%
    \form@cell{经度}{\add@long\Longitude}%
      \form@cell{纬度}{\add@lat\Latitude}\par
    \form@cell{海拔}{\add@m\Altitude}%
      \form@cell{生境}{\Habitat}\par
    \form@cell{生活型}{\LifeForm}\penalty-2\relax%
      \form@cell{体高}{\add@m\Height}%
      \form@cell{胸径}{\add@cm\DBH}\par
    \form@cell{科名}{\Family}%
      \form@cell{中文名}{\ChnName}\par
    \form@line{学名}{\col@latin{\LatName}}
    \form@line{附注}{\Descr}}
  \nointerlineskip}
\if@col@barcode
  \RequirePackage[code=Code39,X=.5mm,H=4mm]{makebarcode}
\fi
\def\printbarcode{%
  \let\if@barcodeprepared@\if@col@barcode
  \if\relax\RecNum\relax\@barcodeprepared@false\fi
  \if\relax\@herbariumcode\relax\@barcodeprepared@false\fi
  \if@barcodeprepared@
    \vskip6.6pt\relax
    \resizebox{\columnwidth}{4mm}{\barcode{\@herbariumcode-\RecNum}}\par
    \nointerlineskip\vskip13.9pt\relax
  \else
    \vskip\NC@margin
  \fi
  \cutting@line}
\RequirePackage{calc}
\def\make@map#1{%
  \setlength\map@x{\wd\csname#1@map\endcsname*%
    \ratio{\Longitude\@unit-\csname#1@longmin\endcsname\@unit}%
      {\csname#1@longmax\endcsname\@unit-\csname#1@longmin\endcsname\@unit}}%
  \setlength\map@y{\ht\csname#1@map\endcsname*%
    \ratio{\Latitude\@unit-\csname#1@latmin\endcsname\@unit}%
      {\csname#1@latmax\endcsname\@unit-\csname#1@latmin\endcsname\@unit}}%
  \begingroup\ooalign{%
    \copy\csname#1@map\endcsname\cr
    \hb@xt@\map@x{\hss\vb@xt@\map@y{\copy\pin@point\vss}}\cr}%
  \endgroup}
\def\print@map#1{%
  \vskip3.5mm\relax
  \make@map{#1}%
  \vskip\NC@margin
  \cutting@line}
\def\choose@map#1{%
  \unless\if@drew@map@
    \if\relax\Longitude\relax\else
    \if\relax\Latitude\relax\else
    \ifdim\Longitude\@unit>\csname#1@longmin\endcsname\@unit
    \ifdim\Longitude\@unit<\csname#1@longmax\endcsname\@unit
    \ifdim\Latitude\@unit>\csname#1@latmin\endcsname\@unit
    \ifdim\Latitude\@unit<\csname#1@latmax\endcsname\@unit
      \print@map{#1}%
      \@drew@map@true
    \fi\fi\fi\fi\fi\fi
  \fi}
\def\printmap{\ifmap\@for\@tmp:=\map@series\do{\choose@map{\@tmp}}\fi}
\@drew@map@false
% \def\map@series{Dongguan,ChinaMainland}
\def\map@series{ChinaMainland}
\def\mapseries#1{\def\map@series{#1}}
\def\loop@the@loop#1{%
  \loop\ifnum\repeat@cnt>\z@#1%
  \advance\repeat@cnt-\@ne\repeat}
\def\@Collect#1{%
  \col@parse@params{#1}%
  \if@param@enough@
    \loop@the@loop{%
      \nointerlineskip
      \begin{minipage}[c]{\linewidth}%
        \vskip\NC@margin
        \printheadings
        \printform
        \printbarcode
        \printmap
      \end{minipage}%
      \filbreak}
  \fi}
\def@to@eol\Collect\@Collect
% COLLECTING LABELS IN WESTERN LANGUAGES
\def\aster{\ensuremath{\ast}\hss}
\def\printheadings@en{%
  \if\relax\@heading\relax\else
    \heading@line{\headingstyle\@heading}
    \if\relax\@subheading\relax\else
      \heading@line{\headingstyle\@subheading}\fi
    \vskip2pt\relax
    \centerline{\makebox[0.618\linewidth][s]{%
      \aster\aster\aster\aster\aster\unskip}}
    \vskip4pt\relax
  \fi}
\def\unless@empty#1{%
  \edef\tmp{#1}%
  \unless\ifx\tmp\empty}
\def\right@aligned{\leftskip\fill\rightskip\z@\relax}
\def\init@punct{\def\the@punct{}}\init@punct
\def\push@punct#1{\def\the@punct{#1 }}
\def\pop@punct{\the@punct\initpunct}
\def\print@tmp#1#2{%
  \setbox\temp@box=\hbox{#1\hskip0.5em\relax#2}%
  \ifdim\wd\temp@box>0.85\linewidth
    #1\;\allowbreak\null\nobreak\hfill#2\par
  \else\leavevmode\box\temp@box\par\fi}
\def\printform@en{%
  \raggedright
  \unless@empty\Family\textsc{\Family}\par\fi
  \unless@empty\LatName{\raggedleft\det@latin{\LatName}\par}\fi
  \parskip=5pt\relax
  \print@tmp{\Collector}{\#\,\ColNum}%
  \unless@empty  \ColDate                     \ColDate  \push@punct{;}\fi
    \unless@empty\Location \pop@punct         \Location \push@punct{,}\fi
    \unless@empty\Longitude\pop@punct\add@long\Longitude\push@punct{,}\fi
    \unless@empty\Latitude \pop@punct \add@lat\Latitude \push@punct{,}\fi
    \unless@empty\Altitude \pop@punct   \add@m\Altitude \space a.s.l.\push@punct{;}\fi
    \unless@empty\Habitat  \pop@punct         \Habitat                \fi
    \push@punct{.}\pop@punct\par
  \unless@empty  \LifeForm                    \LifeForm \push@punct{,}\fi
    \unless@empty\Height   \pop@punct   \add@m\Height\space height\push@punct{,}\fi
    \unless@empty\DBH   \pop@punct DBH \add@cm\DBH                    \fi
    \push@punct{.}\pop@punct\Descr\par}
\def\@Collect@en#1{{%
  \let\printheadings\printheadings@en
  \let\printform\printform@en
  \@Collect{#1}}}
\def@to@eol\Collect@en\@Collect@en
\let\collect\Collect@en
% COMPONENTS OF IDENTIFICATION LABELS
\if@det@barcode
  \RequirePackage{qrcode}
\fi
\def\printqrcode{%
  \let\if@barcodeprepared@\if@det@barcode
  \if\relax\RecNum\relax\@barcodeprepared@false\fi
  \if\relax\@herbariumcode\relax\@barcodeprepared@false\fi
  \if@barcodeprepared@
    \vb@xt@\z@{\vss\hbox{\qrcode[height=1cm]{\@herbariumcode.\RecNum}}\kern-5pt}\fi}
\def\identifier@skip{\hskip 12mm minus 12mm}
\def\@Identify#1{%
  \@identifying@true
  \det@parse@params{#1}%
  \if@param@enough@
    \par
    \begin{minipage}[c]{\columnwidth}%
      \vskip\NC@margin
      \begingroup
        \centering
        {\detlatinstyle\expandafter\det@latin\expandafter{\LatName}\par}%
        {\detchinesestyle\leavevmode\ChnName\par}%
      \endgroup
      \vskip7pt\relax
      \hb@xt@\linewidth{%
        \sfcode`\.=390\relax
        \printqrcode\identifier@skip\identifier@skip\identifier@skip
        {\identifierstyle\Identifier}\identifier@skip
        {\identifierstyle\IdentifierStd}\identifier@skip\identifier@skip
        \DateIdentification}\par
      \if\relax\Remark\relax\else
        \vskip3pt
        \hskip44pt\Remark\par\fi
      \vskip\NC@margin
      \cutting@line
    \end{minipage}%
    \filbreak
  \fi
  \@identifying@false}
\def@to@eol\Identify\@Identify
\let\identify\Identify
% CATCODES PART III
\catcode`\&\active
  \def&{et}
\makeatother
% HOOKS
\AtBeginDocument{\begin{multicols*}{4}}
\AtEndDocument{\end{multicols*}}
\endinput
% END OF FILE nanicolle.cls
