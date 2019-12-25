\name{MixedModelDataSummary}
\alias{MixedModelDataSummary}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Data Summary}
\description{
Calculate the mean and standard error of dependent variable
}
\usage{
MixedModelDataSummary(Data = , DV = 'DV',Cond = 'CondA', Group = 'subj')
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Data}{Data that you want to summary. This data should contain the variables that you put into the function.}
  \item{DV}{The name of dependent variable. A character vector.}
  \item{Cond}{The name of variable on which the DV is summarized. A character vector. If you have more than one variable, please input them as one character element via collapsing them by comma.}
  \item{Group}{The name of group variable, usually the subject or the item. A character vector.}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\examples{
## Example :
MixedModelDataSummary(Data = DemoData, DV = 'DV', Cond = 'CondA, CondB', Group = 'subj')
}
