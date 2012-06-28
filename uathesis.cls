\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{uathesis}

\RequirePackage{ifthen}

\newif\ifthesis
\DeclareOption{thesis}{\thesistrue}
\DeclareOption{dissertation}{\thesisfalse}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{report}%
}
\ProcessOptions\relax
\LoadClass[a4paper,12pt]{report}

% margins
\usepackage[top=1in,bottom=1in,left=1in,right=1in]{geometry}
\usepackage{titlesec}
\usepackage{setspace}
\usepackage{textcase}
\usepackage{tocloft}
\usepackage[nonumberlist,xindy,toc]{glossaries}

%% Package graveyard. Leave commented out until it is known that you need it.
%\usepackage{changepage}
%\usepackage{fancyhdr}

\renewcommand{\glossaryname}{LIST OF ABBREVIATIONS AND SYMBOLS}

\renewcommand{\cfttoctitlefont}{\pagebreak\hfill\MakeTextUppercase}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftchapfont}{ }
\renewcommand{\cftdot}{.}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchappagefont}{}

\renewcommand{\cftloftitlefont}{\pagebreak\hfill\MakeTextUppercase}
\renewcommand{\cftafterloftitle}{\hfill}

\renewcommand{\cftlottitlefont}{\pagebreak\hfill\MakeTextUppercase}
\renewcommand{\cftafterlottitle}{\hfill}

%% Title spacings.
\titlespacing{\chapter}{0pt}{2in}{1in}

%% Thesis committee
\newcommand\committee[1]{\renewcommand\@committee{#1}}
\newcommand\@committee{Committee undefined}

%% Adviser
\newcommand\adviser[1]{\renewcommand\@adviser{#1}}
\newcommand\@adviser{Adviser undefined}

%% Candidate degree
\newcommand\degree[1]{\renewcommand\@degree{#1}}
\newcommand\@degree{Undefined Degree}

%% University (if not UA)
\newcommand\university[1]{\renewcommand\@university{#1}}
\newcommand\@university{The University of Alabama}

%% Department
\newcommand\department[1]{\renewcommand\@department{#1}}
\newcommand\@department{Undefined Department}

%% School (in case of undergrad thesis or something)
\newcommand\school[1]{\renewcommand\@school{#1}}
\newcommand\@school{Graduate School}

%% Year of graduation
\newcommand\gradyear[1]{\renewcommand\@gradyear{#1}}
\newcommand\@gradyear{\the\year}

%% Place
\newcommand\place[1]{\renewcommand\@place{#1}}
\newcommand\@place{Tuscaloosa, Alabama}

%% Abstract body text
\renewcommand\abstract[1]{\renewcommand\@abstract{#1}}
\newcommand\@abstract{No abstract body text.}

%% Dedication body text
\newcommand\dedication[1]{\renewcommand\@dedication{#1}}
\newcommand\@dedication{No dedication body text.}

%% Acknowledgments body text
\newcommand\acknowledgments[1]{\renewcommand\@acknowledgments{#1}}
\newcommand\@acknowledgments{No acknowledgments body text.}

%% Rename bibliography
\renewcommand{\bibname}{References}

% Make the front matter...
\newcommand{\makefrontmatter}{
  \thispagestyle{empty}
  \vspace*{50\p@}
  \begin{center}
    \begin{doublespace}
    \renewcommand{\and}{\NoCaseChange{\\}}
    \MakeTextUppercase{\@title} \linebreak \linebreak
    by \linebreak
    \MakeTextUppercase{\@author}
    \begin{singlespace}
      \MakeTextUppercase{\@adviser, Committee Chair \and \@committee}
    \end{singlespace}
    
    \hfill \linebreak
    \ifthesis
      A THESIS
    \else
      A DISSERTATION
    \fi
    \hfill \linebreak
    \begin{singlespace}
	  Submitted in partial fulfillment of the requirements \\
      for the degree of \@degree \\
      in the Department of \@department \\
      in the \@school\,of \\
      \@university
    \end{singlespace}
	\hfill \linebreak
	\hfill \linebreak
	\MakeTextUppercase{\@place}
	\hfill \linebreak
	\hfill \linebreak
	\@gradyear
  \end{doublespace}
  \end{center}
  \pagebreak

    \begin{frontmatter}

    \chapter*{ABSTRACT}
    \addcontentsline{toc}{chapter}{ABSTRACT}

    \@abstract

    \chapter*{DEDICATION}
    \addcontentsline{toc}{chapter}{DEDICATION} 

    \@dedication

    %% Print everything in the glossary.
    \glsaddall
    \printglossary
    \glsresetall

    \chapter*{ACKNOWLEDGMENTS}
    \addcontentsline{toc}{chapter}{ACKNOWLEDGMENTS}

    \@acknowledgments

    \tableofcontents

    \listoftables 
    \addcontentsline{toc}{chapter}{LIST OF TABLES} 

    \listoffigures
    \addcontentsline{toc}{chapter}{LIST OF FIGURES} 

    \end{frontmatter}

}
  
\newcommand{\makecopyright}{
  \thispagestyle{empty}
  \singlespacing
  \null \vfill
  \begin{center}
    Copyright \@author\,\@gradyear \\
    ALL RIGHTS RESERVED
  \end{center}
}


\newenvironment{frontmatter}{
  \makecopyright
  \pagebreak
  \pagenumbering{roman}
  \setcounter{page}{2}
  \setcounter{chapter}{0}
  \begin{doublespace}
  \renewcommand{\@makechapterhead}[1]
  {
    \begin{center}
      \MakeTextUppercase{ ##1 }
    \end{center}
  }
  \renewcommand{\@makeschapterhead}[1]
  {
    \begin{center}
      \MakeTextUppercase{ ##1 }
    \end{center}
  }
}
{
    \end{doublespace}
}
\newenvironment{body}
{
  \pagebreak
  \pagenumbering{arabic}
  \setcounter{page}{1}
  \setcounter{chapter}{0}
  \begin{doublespace}
  \renewcommand{\@makechapterhead}[2]
  {
    \vspace*{50\p@}%
    \begin{center}
      \MakeTextUppercase{ \textbf{ \@chapapp\space \thechapter } }
      \linebreak
      \MakeTextUppercase{ \textbf{ ##1 } }
    \end{center}
  }
  
  \renewcommand{\@makeschapterhead}[1]
  {
    \begin{center}
      \MakeTextUppercase{ \textbf{ ##1 } }
    \end{center}
  }
  
  \renewcommand{\section}
  {
    \@startsection{section}{1}{0mm}{4ex}{2ex}{\normalsize\bfseries}
  }
  
  \renewcommand{\subsection}
  {
    \@startsection{subsection}{1}{0mm}{1mm}{1mm}{\normalsize\bfseries}
  }
}
{
  \end{doublespace}
}

\makeglossaries