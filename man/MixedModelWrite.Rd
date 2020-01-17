\name{MixedModelWrite}
\alias{MixedModelWrite}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Model information write out}
\description{
Write the fixed effects of a given and the description information of a given data out to your disk. The out-put files will be in your working directory.
}
\usage{
MixedModelWrite(Model = NULL, Data = NULL, Prefix = 'DV',...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Model}{A model of which the fixed effects are to be written out.}
  \item{Data}{A data of which the description information is to be written out.}
  \item{Prefix}{Prefix of the written-out files. A character element.}
  \item{...}{Other parameters needed to be put into the MixedModelDataSummary().}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\examples{
## Example :
Model = lmer(data = DemoData, DV~CondA+(1|subj)+(1|item))
MixedModelWrite(Model = Model, Data = DemoData, DV = 'DV',Cond = 'CondA,CondB', Group = 'subj')
}
