%% nanicolle.cls
%% Copyright 2016--2019 Yuchang Yang < yang.yc.allium@gmail.com >
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
%   - the manual files: [nanicolle.tex, nanicolle.pdf, README.md];
%   - the example files: [nanicolle-example.tex, nanicolle-example.pdf].
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nanicolle}[2019/04/28 v2.00 class nanicolle]
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
\catcode`\^^@\@other
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
% UNIT EXPRESSIONS
\def\degree{\ensuremath{^\circ}}
\def\gobble@char#1{\relax}
\def\plus@one@degree#1#2#3{%
  \if\relax#1\relax\else
    \ifdim#1\@unit>\z@
      #1\:\ensuremath{^\circ}\!#2%
    \else
      \expandafter\gobble@char#1\:\degree\!#3%
    \fi
  \fi}
\def\plus@one@long#1{\plus@one@degree{#1}EW}
\def\plus@one@lat#1{\plus@one@degree{#1}NS}
\def\plus@one@second#1#2{%
  \if\relax#1\relax\else
    #1\,#2%
  \fi}
\def\plus@one@cm#1{\plus@one@second{#1}{cm}}
\def\plus@one@m#1{\plus@one@second{#1}{m}}
% PARSING
\RequirePackage{calc}
\RequirePackage{listofitems}
  \reademptyitems
\def\get@argin#1{%
  \ifnum#1>\temp@arginlen\relax
    \else\temp@argin[#1]\fi}
\def\col@parse@params#1{%
  \edef\temp@list{#1}
  \setsepchar{^^@}
  \readlist\temp@argin{\temp@list}
  \@param@enough@true
  \edef\RecordNo{\get@argin{2}}
  \edef\Collector{\get@argin{3}}
  \edef\CollectionNo{\get@argin{4}}
  \edef\DateCollection{\get@argin{5}}
  \edef\Family{\get@argin{6}}
  \edef\ChineseName{\get@argin{7}}
  \edef\ScientificName{\get@argin{8}}
  \edef\PhotoNo{\get@argin{9}}
  \edef\NoDuplication{\get@argin{10}}
  \edef\Location{\get@argin{11}}
  \edef\Longitude{\get@argin{12}}
  \edef\Latitude{\get@argin{13}}
  \edef\Altitude{\get@argin{14}}
  \edef\Habitat{\get@argin{15}}
  \edef\LifeForm{\get@argin{16}}
  \edef\Height{\get@argin{17}}
  \edef\DBH{\get@argin{18}}
  \edef\Description{\get@argin{19}}
  \repeat@cnt\@ne
  \if@auto@duplicate\if\relax\NoDuplication\relax\else
    \repeat@cnt\NoDuplication\relax
  \fi\fi
  \if\relax\Collector\relax\@param@enough@false\fi
  \if\relax\DateCollection\relax\@param@enough@false\fi
  \if\relax\Location\relax\@param@enough@false\fi
  }
\def\det@parse@params#1{%
  \edef\temp@list{#1}
  \setsepchar{^^@}
  \readlist\temp@argin{\temp@list}
  \@param@enough@true
  \edef\RecordNo{\get@argin{2}}
  \edef\ScientificName{\get@argin{3}}
  \edef\ChineseName{\get@argin{4}}
  \edef\Identifier{\get@argin{5}}
  \edef\IdentifierStd{\get@argin{6}}
  \edef\DateIdentification{\get@argin{7}}
  \edef\Remark{\get@argin{8}}
  \edef\temp@name{\Identifier\IdentifierStd}
  \if\relax\ScientificName\relax\@param@enough@false\fi
  \if\relax\temp@name\relax\@param@enough@false\fi
  \if\relax\DateIdentification\relax\@param@enough@false\fi
  }
% LATIN PARSING
\def\col@latin@break{\hfill\penalty-\@ne
  \hskip -3em plus -1fill\relax\hbox{}\hskip3em\relax}
\def\col@latin@prefix{=-=}
\def\col@latin@mark#1#2{%
  \expandafter\gdef\csname\col@latin@prefix#1\endcsname{#2}}
  \col@latin@mark{subsp.}{\col@latin@break{\upshape subsp\@.}\itshape\space}
  \col@latin@mark{var.}{\col@latin@break{\upshape var\@.}\itshape\space}
  \col@latin@mark{f.}{\col@latin@break{\upshape f\@.}\itshape\space}
  \col@latin@mark{cf.}{{\upshape cf\@.}\space}
  \col@latin@mark{aff.}{{\upshape aff\@.}\space}
  \col@latin@mark{sp.}{\upshape sp\@.\space}
  \col@latin@mark{@bquote}{\upshape\string`}
  \col@latin@mark{@equote}{\unskip\string'}
  \col@latin@mark{@times}{\ensuremath{\times}}
  \col@latin@mark{@end}{\global\let\@iterator\relax}
\def\col@latin#1{%
  \itshape
  \gdef\@iterator##1 {%
    \@ifundefined{\col@latin@prefix##1}%
      {##1\space}%
      {\csname\col@latin@prefix##1\endcsname}%
    \@iterator}%
  \@iterator#1 @end 
}
\def\inter@taxon@skip{\hskip .1667em minus .1667em\relax}
\def\det@latin@prefix{^_^}
\def\det@latin@mark#1#2{%
  \expandafter\gdef\csname\det@latin@prefix#1\endcsname{#2}}
  \det@latin@mark{subsp.}{{\upshape subsp\@.}\word@cnt\tw@\space}
  \det@latin@mark{var.}{{\upshape var\@.}\word@cnt\tw@\space}
  \det@latin@mark{f.}{{\upshape f\@.}\advance\word@cnt\tw@\space}
  \det@latin@mark{cf.}{{\upshape cf\@.}\word@cnt\tw@\space}
  \det@latin@mark{aff.}{{\upshape aff\@.}\word@cnt\tw@\space}
  \det@latin@mark{sp.}{\upshape sp\@.\word@cnt\z@\space}
  \det@latin@mark{@bquote}{\upshape\string`}
  \det@latin@mark{@equote}{\unskip\string'}
  \det@latin@mark{@times}{\ensuremath{\mathsf\times}\advance\word@cnt\@ne}
  \det@latin@mark{et}{\penalty-\@ne et\penalty-\@ne\space}
  \det@latin@mark{ex}{\penalty-\tw@ et\penalty-\tw@\space}
  \det@latin@mark{@lparen}{\penalty-\thr@@\lparen}
  \det@latin@mark{@rparen}{\unskip\rparen\penalty-\thr@@}
  \det@latin@mark{@end}{\global\let\@iterator\relax}
\def\det@latin#1{%
  \itshape
  \word@cnt\tw@
  \leavevmode
  \gdef\@iterator##1 {%
    \@ifundefined{\det@latin@prefix##1}%
      {##1\space}%
      {\csname\det@latin@prefix##1\endcsname}%
    \advance\word@cnt-\@ne
    \ifcase\word@cnt\penalty-\f@ur\upshape\inter@taxon@skip\or\itshape\fi
    \@iterator}%
  \@iterator#1 @end 
}
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
  \expandafter\def\csname#1@latmax\endcsname{#6}%
}
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
\def\form@line#1#2{%
  \par\hangindent=1em%
  \leavevmode
  \setbox\header@box=\hbox{\headerstyle#1}%
  \setbox\temp@box=\hbox{\copy\header@box\quad#2}%
  \def\glue@begin{\quad\hfill}%
  \def\glue@end{\hfill\hfill\hbox{}}%
  \ifdim\wd\temp@box>\linewidth
    \def\glue@begin{\CJKglue\quad\CJKglue}\fi
  \box\header@box
    \uline{\glue@begin#2\glue@end}\par}
\def\form@cell#1#2{%
  \leavevmode
  \hbox{\headerstyle#1}\nobreak
  \uline{\;\hfill#2\hfill\;}\hbox{}\penalty-1\relax}
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
      \centerline{\hbox{}\hss
        \rulerbox[tb]{\kern-.9mm\rule{6.18cm}{.4pt}\kern-.9mm}%
        \hss\hbox{}}%
      \vskip5pt\relax
    \else
      \hrule\@height\NC@seprule
      \vskip9pt\relax
    \fi
  \fi}
\def\printform{%
  \form@line{采集人}{\Collector}%
  \form@cell{采集号}{\CollectionNo}%
    \if@internal\form@cell{照片号}{\PhotoNo}\par\fi
  \form@cell{采集日期}{\DateCollection}%
    \if@internal\form@cell{标本份数}{\NoDuplication}\fi\par
  \form@line{产地}{\Location}%
  \form@cell{经度}{\plus@one@long\Longitude}%
    \form@cell{纬度}{\plus@one@lat\Latitude}\par
  \form@cell{海拔}{\plus@one@m\Altitude}%
    \form@cell{生境}{\Habitat}\par
  \form@cell{生活型}{\LifeForm}\penalty-2\relax%
    \form@cell{体高}{\plus@one@m\Height}%
    \form@cell{胸径}{\plus@one@cm\DBH}\par
  \form@cell{科名}{\Family}%
    \form@cell{中文名}{\ChineseName}\par
  \form@line{学名}{\expandafter\col@latin\expandafter{\ScientificName}}
  \form@line{附注}{\Description}
  \nointerlineskip}
\if@col@barcode
  \RequirePackage[code=Code39,X=.5mm,H=4mm]{makebarcode}
\fi
\def\printbarcode{%
  \let\if@barcodeprepared@\if@col@barcode
  \if\relax\RecordNo\relax\@barcodeprepared@false\fi
  \if\relax\@herbariumcode\relax\@barcodeprepared@false\fi
  \if@barcodeprepared@
    \vskip6.6pt\relax
    \resizebox{\columnwidth}{4mm}{\barcode{\@herbariumcode-\RecordNo}}\par
    \nointerlineskip\vskip13.9pt\relax
  \else
    \vskip\NC@margin
  \fi
  \cutting@line}
\def\makemap#1{%
  \unless\if@drew@map@
    \if\relax\Longitude\relax\else
    \if\relax\Latitude\relax\else
    \ifdim\Longitude\@unit>\csname#1@longmin\endcsname\@unit
    \ifdim\Longitude\@unit<\csname#1@longmax\endcsname\@unit
    \ifdim\Latitude\@unit>\csname#1@latmin\endcsname\@unit
    \ifdim\Latitude\@unit<\csname#1@latmax\endcsname\@unit
      \setlength\map@x{\wd\csname#1@map\endcsname*%
        \ratio{\Longitude\@unit-\csname#1@longmin\endcsname\@unit}%
          {\csname#1@longmax\endcsname\@unit-\csname#1@longmin\endcsname\@unit}}
      \setlength\map@y{\ht\csname#1@map\endcsname*%
        \ratio{\Latitude\@unit-\csname#1@latmin\endcsname\@unit}%
          {\csname#1@latmax\endcsname\@unit-\csname#1@latmin\endcsname\@unit}}
      \vskip3.5mm\relax
      \begingroup\ooalign{%
        \copy\csname#1@map\endcsname\cr
        \hb@xt@\map@x{\hss\vb@xt@\map@y{\copy\pin@point\vss}}\cr}
      \endgroup
      \vskip\NC@margin
      \cutting@line
      \@drew@map@true
    \fi\fi\fi\fi\fi\fi
  \fi}
% \def\map@series{Dongguan,ChinaMainland}
\def\map@series{ChinaMainland}
\def\mapseries#1{\def\map@series{#1}}
\def\@Collect#1{%
  \@drew@map@false
  \col@parse@params{#1}%
  \if@param@enough@
    \loop\ifnum\repeat@cnt>\z@
    \nointerlineskip
    \begin{minipage}[c]{\linewidth}%
      \vskip\NC@margin
      \printheadings
      \printform
      \printbarcode
      \ifmap\@for\@tmp:=\map@series\do{\makemap{\@tmp}}\fi
    \end{minipage}%
    \filbreak
    \advance\repeat@cnt-\@ne\repeat
  \fi}
\def@to@eol\Collect\@Collect
% COMPONENTS OF IDENTIFICATION LABELS
\if@det@barcode
  \RequirePackage{qrcode}
\fi
\def\printqrcode{%
  \let\if@barcodeprepared@\if@det@barcode
  \if\relax\RecordNo\relax\@barcodeprepared@false\fi
  \if\relax\@herbariumcode\relax\@barcodeprepared@false\fi
  \if@barcodeprepared@
    \vb@xt@\z@{\vss\hbox{\qrcode[height=1cm]{\@herbariumcode.\RecordNo}}\kern-5pt}\fi}
\def\identifier@skip{\hskip12mm minus 12mm}
\def\@Identify#1{%
  \@identifying@true
  \det@parse@params{#1}%
  \if@param@enough@
    \par
    \begin{minipage}[c]{\columnwidth}%
      \vskip\NC@margin
      \begingroup
        \centering
        {\detlatinstyle\expandafter\det@latin\expandafter{\ScientificName}\par}%
        {\detchinesestyle\leavevmode\ChineseName\par}%
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
% CATCODES PART III
\def\markdown{\catcode`\*\active\catcode`\'\active}
\def\endmarkdown{\catcode`\*\@other\catcode`\'\@other}
\markdown
\def*#1*{{\noexpand\noexpand\noexpand\itshape#1}}
\def'#1'{@bquote #1 @equote }
\endmarkdown
\catcode`\×\active
  \def×{@times }
\catcode`\&\active
  \def&{et}
\let\lparen(%)
\let\rparen)%(
\catcode`\(\active%\)
\def(#1){%
  \if@identifying@
    @lparen\space #1 @rparen\space
  \else
    \lparen#1\rparen
  \fi}
\catcode`\^^@\@other
\catcode`\^^I\active
  \def^^I{^^@}
\makeatother
% HOOKS
\AtBeginDocument{\begin{multicols*}{4}\markdown}
\AtEndDocument{\endmarkdown\end{multicols*}}
\endinput
% END OF FILE nanicolle.cls
