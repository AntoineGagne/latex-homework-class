%!TEX encoding = UTF-8 Unicode

\NeedsTeXFormat{LaTeX2e}
\LoadClassWithOptions{article}
\ProvidesClass{homework}[2014/12/16 Class file for homework assignments]

% ----- Options ---------------------------------------------------------------
\newcommand\@opanon{0}
\DeclareOption{anonymous}{\renewcommand\@opanon{1}}
\newcommand\@oplargemargins{0}
\DeclareOption{largemargins}{\renewcommand\@oplargemargins{1}}
\newcommand\@opindex{0}
\DeclareOption{index}{\renewcommand\@opindex{1}}
\ProcessOptions%

% ----- Packages --------------------------------------------------------------

% Better fonts with accents
\RequirePackage[T1]{fontenc}
\RequirePackage[french]{babel}
\RequirePackage{lmodern}
\RequirePackage{caption}

% Required for starred commands
\RequirePackage{suffix}

% Math symbols
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{centernot}

% Nice lists
\RequirePackage{enumerate}
\RequirePackage{enumitem}

% Nice images, figures, and listings
\RequirePackage{graphicx}
\RequirePackage{grffile}
\RequirePackage[all]{xy}
\RequirePackage{wrapfig}
\RequirePackage{fancyvrb}
\RequirePackage{listings}

% Translations
\RequirePackage{translations}

% Conditionals
\RequirePackage{ifthen}
\RequirePackage{xparse}

% Header & Page Setup
\RequirePackage{fancyhdr}
\RequirePackage[explicit]{titlesec}
\ifthenelse{\equal{\@oplargemargins}{1}}{}{\RequirePackage{fullpage}}

% Colors
\RequirePackage{xcolor}

% Indices
\ifthenelse{\equal{\@opindex}{1}}{\RequirePackage{imakeidx}}{}

% Links
\RequirePackage{hyperref}

% Definition of the `hyperref` package parameters
\hypersetup{plainpages=false,%
            breaklinks=false,%
            pdfencoding=auto,%
            psdextra,%
            colorlinks=true}

% ----- Questions -------------------------------------------------------------
% Prefix for questions
\def\questiontype#1{\def\thequestiontype{#1}}
\def\thequestiontype{Question\ }

\titleformat%
{\section}%
[hang]%
{\normalfont\bfseries}%
{%
    \bf\thequestiontype\arabic{section}.%
}%
{0pt}%
{%
    \def\sectionname{#1}
    \ifx\sectionname\empty%
    \else%
        \sectionname%
    \fi
}%
[%
    \vspace{0.1em}%
    \titlerule%
]

\DeclareDocumentCommand{\question}{o}{%
    \IfNoValueTF{#1}{%
        \section[\thequestiontype\arabic{section}]{}
    }{%
        \section[#1]{}
    }
}
\WithSuffix\newcommand\question*[1]{%
    \questiontype{}
    \section{#1}
    \questiontype{Question\ }
}

% ----- Question Parts --------------------------------------------------------

\newenvironment{alphaparts}[0]{%
  \begin{enumerate}[label=\textbf{(\alph*)}]%
}{\end{enumerate}}

\newenvironment{arabicparts}[0]{%
  \begin{enumerate}[label=\textbf{\arabic{section}.\arabic*})]%
}{\end{enumerate}}

\newcommand{\questionpart}[0]{\item}

% ----- Induction Environment -------------------------------------------------

\newenvironment{induction}[0]{%
  \begin{description}
}{\end{description}}

\DeclareTranslationFallback{induction-base-case}{Base Case}
\DeclareTranslation{English}{induction-base-case}{Base Case}
\DeclareTranslation{French}{induction-base-case}{Cas de base}
\DeclareTranslationFallback{induction-hypothesis}{Induction Hypothesis}
\DeclareTranslation{English}{induction-hypothesis}{Induction Hypothesis}
\DeclareTranslation{French}{induction-hypothesis}{Hypoth\`{e}se d'induction}
\DeclareTranslationFallback{induction-step}{Induction Step}
\DeclareTranslation{English}{induction-step}{Induction Step}
\DeclareTranslation{French}{induction-step}{Pas d'induction}
\newcommand{\thebasecase}{\GetTranslation{induction-base-case}}
\newcommand{\theindhyp}{\GetTranslation{induction-hypothesis}}
\newcommand{\theindstep}{\GetTranslation{induction-step}}
\newcommand{\basecase}{\item[\thebasecase]\mbox{}\\}
\newcommand{\indhyp}{\item[\theindhyp]\mbox{}\\}
\newcommand{\indstep}{\item[\theindstep]\mbox{}\\}

% ----- Answer Box ------------------------------------------------------------

\newcommand{\answerbox}[1]{%
\begin{framed}
\vspace{#1}
\end{framed}}

% ----- Page Setup ------------------------------------------------------------

% Use block style paragraphs
\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt plus 1pt}
\setlength{\headheight}{15.2pt}
\setlength{\headsep}{25pt}

\def\indented#1{\list{}{}\item[]}
\let\indented=\endlist

% ----- Title & Header --------------------------------------------------------
\pagestyle{empty}
\pagestyle{fancy}

%\if\@opanon%
\ifthenelse{\equal{\@opanon}{0}}{%
  \renewcommand{\maketitle}[0]{%
    % Setup header
    \fancyhf{}
    \fancyhead[LE,RO]{\small\hwname{}}
    \fancyhead[RE,LO]{\thepage}%

    % Setup hrule in header

    % Don't put header on first page
    \thispagestyle{empty}

    \begin{center}
      {\Large \hwclass{} \hwtype{} \hwnum}

        \textsc{\hwname{}}

        \hwemail{}

      \today
    \end{center}
  }

}%
{%
  \renewcommand{\maketitle}[0]{%
    % Make all pages plain
    \thispagestyle{empty}

    % Put header on it's own page
    \begin{center}
      {\Large \hwclass{} \hwtype{} \hwnum}

      \hwname{} (\hwemail)

      \today
    \end{center}
    \newpage
  }
}

% ----- For usage with pandoc converted documents -----------------------------

\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

\definecolor{red}{HTML}{CC241D}
\definecolor{darkred}{HTML}{9D0006}
\definecolor{green}{HTML}{98971A}
\definecolor{darkgreen}{HTML}{79740E}
\definecolor{yellow}{HTML}{D79921}
\definecolor{darkyellow}{HTML}{B57614}
\definecolor{blue}{HTML}{458588}
\definecolor{darkblue}{HTML}{076678}
\definecolor{purple}{HTML}{B16286}
\definecolor{darkpurple}{HTML}{8F3F71}
\definecolor{aqua}{HTML}{689D6A}
\definecolor{darkaqua}{HTML}{427B58}
\definecolor{gray}{HTML}{928374}
\definecolor{darkgray}{HTML}{7C9F64}
\definecolor{orange}{HTML}{D65D0E}
\definecolor{darkorange}{HTML}{AF3A03}
\definecolor{fg}{HTML}{3C3836}
\definecolor{bg}{HTML}{FBF1C7}

% -----------------------------------------------------------------------------
% Defines the highlighting for the programming languages
\lstdefinestyle{custom}{
    backgroundcolor=\color{white},
    basicstyle=\footnotesize\ttfamily\color{fg},
    belowcaptionskip=1\baselineskip,
    breakatwhitespace=true,
    breaklines=true,
    captionpos=b,
    commentstyle=\ttfamily\color{gray},
    identifierstyle=\color{darkblue},
    keywordstyle=\bfseries\color{red},
    language=Python,
    numbers=left,
    numbersep=5pt,
    numberstyle=\tiny\color{gray},
    showstringspaces=false,
    showtabs=false,
    stepnumber=1,
    stringstyle=\color{green},
    tabsize=4,
    xleftmargin=\parindent,
}

% Defines the UTF8 characters and their associated values
\lstset{literate=
  {á}{{\'a}}1 {é}{{\'e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ú}{{\'u}}1
  {Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1
  {à}{{\`a}}1 {è}{{\`e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1 {ù}{{\`u}}1
  {À}{{\`A}}1 {È}{{\'E}}1 {Ì}{{\`I}}1 {Ò}{{\`O}}1 {Ù}{{\`U}}1
  {ä}{{\"a}}1 {ë}{{\"e}}1 {ï}{{\"i}}1 {ö}{{\"o}}1 {ü}{{\"u}}1
  {Ä}{{\"A}}1 {Ë}{{\"E}}1 {Ï}{{\"I}}1 {Ö}{{\"O}}1 {Ü}{{\"U}}1
  {â}{{\^a}}1 {ê}{{\^e}}1 {î}{{\^i}}1 {ô}{{\^o}}1 {û}{{\^u}}1
  {Â}{{\^A}}1 {Ê}{{\^E}}1 {Î}{{\^I}}1 {Ô}{{\^O}}1 {Û}{{\^U}}1
  {œ}{{\oe}}1 {Œ}{{\OE}}1 {æ}{{\ae}}1 {Æ}{{\AE}}1 {ß}{{\ss}}1
  {ű}{{\H{u}}}1 {Ű}{{\H{U}}}1 {ő}{{\H{o}}}1 {Ő}{{\H{O}}}1
  {ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1 {å}{{\r a}}1 {Å}{{\r A}}1
  {€}{{\EUR}}1 {£}{{\pounds}}1 {==}{\texttt{==}}{2}
  {<=}{\texttt{<=}}{2} {>=}{\texttt{>=}}{2} {===}{\texttt{===}}{2}
  {!=}{\texttt{!=}}{2} {/=}{\texttt{/=}}{2} {!==}{\texttt{!==}}{2}
  {=/=}{\texttt{=/=}}{2} {...}{\texttt{...}}{2}
}

% Use the custom style defined earlier
\lstset{escapechar=@, style=custom}

% Adds translations
\DeclareTranslationFallback{listing-table-name}{List of programs}
\DeclareTranslation{English}{listing-table-name}{List of programs}
\DeclareTranslation{French}{listing-table-name}{Liste des programmes}

\DeclareTranslationFallback{program-caption}{Program}
\DeclareTranslation{English}{program-caption}{Program}
\DeclareTranslation{French}{program-caption}{Programme}

\DeclareTranslationFallback{table-caption-name}{Table}
\DeclareTranslation{English}{table-caption-name}{Table}
\DeclareTranslation{French}{table-caption-name}{Tableau}

% Changes the name of the list of listings and the listings caption
\renewcommand\lstlistlistingname{\GetTranslation{listing-table-name}}
\renewcommand\lstlistingname{\GetTranslation{program-caption}}
\captionsetup[table]{name=\textsc{\GetTranslation{table-caption-name}}}
% -----------------------------------------------------------------------------
