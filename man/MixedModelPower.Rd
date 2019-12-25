\name{MixedModelPower}
\alias{MixedModelPower}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Power calculator}
\description{
To perform the power analysis for the given model
}
\usage{
MixedModelPower(Model, FixEffect = NULL, Methods = 't', Nsim = 100,
                Along = NULL, maxNumber = NULL, Breaks = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Model}{A mixed model build via lme4 package}
  \item{FixEffect}{The fixed effect of which the power is to calculate}
  \item{Methods}{The methods to examine the power}
  \item{Nsim}{Number of simulation}
  \item{Along}{The name of the group variable which you want extent the data along. A character name}
  \item{maxNumber}{The max number to extend the data along the group variable}
  \item{Breaks}{You can define the levels to calculate the power}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\examples{
## Example :
Model = lmer(data = DemoData, DV~CondA+(1|subj)+(1|item))
MixedModelPower(Model = Model, FixEffect = "CondAA2", Methods = "t", Nsim = 10, Along = 'subj',maxNumber = 50, Breaks = seq(5,50,5))
}
\seealso{
\code{\link{MixedModelOptPower}}
}
