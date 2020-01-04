\name{MixedModelDataExplore}
\alias{MixedModelDataExplore}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Data Explore}
\description{
To explore the dependent variable (usually continuous variable) with normal distribution test, QQ plot, boxplot, skewness and so on.
}
\usage{
MixedModelDataExplore(Data, DV, DVLog = F, Cond, DeleteCriterion = c(80,1000))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Data}{Data that you want to summary. This data should contain the variables that you put into the function.}
  \item{DV}{The name of dependent variable. A character vector.}
  \item{DVLog}{Whether to perform the log-transform. A logical vector.}
  \item{Cond}{The name of variable on which the DV is explored. A character vector. If you have more than one conditions, please input them as one character element via collapsing them by comma.}
  \item{DeleteCriterion}{Whether to delete the outlier of DV. If you dont want to delete, set it as NULL. Otherwise, set the minimal and miximal value to filter (default value is c(80, 1000), which means to remain the trial in the range from 80 to 1000).}
}
\details{
All plots will be saved in one PDF file existing in your working directory.

This function will return the filtered data, if you have set the parameter DeleteCriterion.
}
\examples{
## Example :
A = MixedModelDataExplore(Data = DemoData, DV = 'DV', DVLog = T, Cond = 'CondA, CondB',DeleteCriterion = c(80,800))
A
}
