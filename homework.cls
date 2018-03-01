%!TEX encoding = UTF-8 Unicode

\NeedsTeXFormat{LaTeX2e}
\LoadClassWithOptions{article}
\ProvidesClass{homework}[2014/12/16 Class file for homework assignments]

% ----- Options ---------------------------------------------------------------
\newcommand\@opanon{0}
\DeclareOption{anonymous}{\renewcommand\@opanon{1}}
\newcommand\@opnewpage{0}
\DeclareOption{newpage}{\renewcommand\@opnewpage{1}}
\newcommand\@oplargemargins{0}
\DeclareOption{largemargins}{\renewcommand\@oplargemargins{1}}
\newcommand\@opindex{0}
\DeclareOption{index}{\renewcommand\@opindex{1}}
\ProcessOptions%

% ----- Packages --------------------------------------------------------------

% Better fonts with accents
\RequirePackage[T1]{fontenc}
\RequirePackage[USenglish,french]{babel}
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

% Header & Page Setup
\RequirePackage{fancyhdr}
\ifthenelse{\equal{\@oplargemargins}{1}}{}{\RequirePackage{fullpage}}

% Indices
\ifthenelse{\equal{\@opindex}{1}}{\RequirePackage{imakeidx}}{}

% Links
\RequirePackage{hyperref}

% Definition of the `hyperref` package parameters
\hypersetup{plainpages=false,%
            breaklinks=false,%
            colorlinks=true}

% ----- Questions -------------------------------------------------------------
\newcounter{questionCounter}
\newcounter{partCounter}[questionCounter]

% Prefix for questions
\newcommand{\questiontype}[0]{Question}

% Use this if your "written" questions are all under one section
% For example, if the homework handout has Section 5: Written Questions
% and all questions are 5.1, 5.2, 5.3, etc. set this to 5
% Use for 0 no prefix. Redefine as needed per-question.
\newcommand{\writtensection}[0]{0}

% Numbered question
\providecommand{\question}{}
\renewcommand{\question}[0]{%
  % Emit \newpage if option `newpage` is present
  \ifthenelse{\equal{\@opnewpage}{1}}{%
    \newpage
  }{}

  % Wrap in minipage so that we don't get a line break enywhere in between
  \begin{minipage}{\linewidth}%
    \stepcounter{questionCounter}%
      \vspace{.2in}%
      \ifx\writtensection\undefined{}
        \noindent{\bf \questiontype\ \arabic{questionCounter}.}%
        \else
          \if\writtensection0
          \noindent{\bf \questiontype\ \arabic{questionCounter}.}%
          \else
          \noindent{\bf \questiontype\ \writtensection.\arabic{questionCounter}}%
        \fi
      \vspace{0.3em} \hrule \vspace{.1in}%
  \end{minipage}
}

% Named question, takes one argument
\WithSuffix\providecommand\question*{}
\WithSuffix\renewcommand\question*[1]{%
  % Emit \newpage if option `newpage` is present
  \ifthenelse{\equal{\@opnewpage}{1}}{%
    \newpage%
  }{}%
  % Wrap in minipage so that we don't get a line break enywhere in between
  \begin{minipage}{\linewidth}%
    \addtocounter{questionCounter}{1}%
    \setcounter{partCounter}{0}%
    \vspace{.2in}%
    \noindent{\bf \arabic{questionCounter}. #1}%
    \vspace{0.3em} \hrule \vspace{.1in}%
  \end{minipage}
}

% Override normal section defintions
\renewcommand{\section}[0]{\question}
\WithSuffix\newcommand\section*[1]{\question*{#1}}

% ----- Question Parts --------------------------------------------------------

\newenvironment{alphaparts}[0]{%
  \begin{enumerate}[label=\textbf{(\alph*)}]%
}{\end{enumerate}}

\newenvironment{arabicparts}[0]{%
  \begin{enumerate}[label=\textbf{\arabic{questionCounter}.\arabic*})]%
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

\def\indented#1{\list{}{}\item[]}
\let\indented=\endlist

% ----- Title & Header --------------------------------------------------------
\pagestyle{empty}
\pagestyle{fancy}

%\if\@opanon%
\ifthenelse{\equal{\@opanon}{0}}{%
  \renewcommand{\maketitle}[0]{%
    % Setup header
    \setlength{\headheight}{15.2pt}
    \setlength{\headsep}{0.2in}
    \lhead{\hwclass{} \hwlecture\hwsection}%
    \chead{\hwname{}}%
    \rhead{\hwtype{} \hwnum}%

    % Setup hrule in header
    \renewcommand{\headrulewidth}{0pt}
    \headrule{}

    % Don't put header on first page
    \thispagestyle{plain}

    \begin{center}
      {\Large \hwclass{} \hwtype{} \hwnum}

      \hwname{} (\hwemail)

      \today
    \end{center}
    \renewcommand{\headrulewidth}{0.4pt}
  }

}%
{%
  \renewcommand{\maketitle}[0]{%
    % Make all pages plain
    \pagestyle{plain}

    % Put header on it's own page
    \begin{center}
      {\Large \hwclass{} \hwtype{} \hwnum}

      \hwname{} (\hwemail)

      \today
    \end{center}
    \renewcommand{\headrulewidth}{0.4pt}
    \newpage
  }
}

% ----- For usage with pandoc converted documents -----------------------------

\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

% -----------------------------------------------------------------------------
% Defines the highlighting for the programming languages
\lstdefinestyle{custom}{
  basicstyle=\footnotesize\ttfamily,
  belowcaptionskip=1\baselineskip,
  breaklines=true,
  captionpos=b,
  commentstyle=\ttfamily\color{gray},
  identifierstyle=\color{blue},
  keywordstyle=\bfseries\color{green!40!black},
  language=Python,
  numbers=left,
  numbersep=0.5pt,
  showstringspaces=false,
  showtabs=false,
  stepnumber=1,
  stringstyle=\color{orange},
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
  {€}{{\EUR}}1 {£}{{\pounds}}1
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
