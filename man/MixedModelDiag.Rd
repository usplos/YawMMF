\name{MixedModelDiag}
\alias{MixedModelDiag}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Model Diagnosis}
\description{
To provide more comprehensive and objective information for the model based on the parameter
}
\usage{
MixedModelDiag(data, DV, IV, randomfactor, randomeffect, PCAdeletecriterion = 0, Family = 'gaussian')
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{The data that contains the variables in the model}
  \item{DV}{Dependent vairable name. A character parameter}
  \item{IV}{The fixed effect. A character parameter, like 'A + B', or 'A*B'}
  \item{randomfactor}{The name of random factor. A character parameter. If you have more than one factors, input them as a string, collapsed by comma, like 'subj, item'}
  \item{randomeffect}{The name of random intercept and random slope. A character parameter. For example, if you want add intercept and random slope of factor 'CondA', set it '1+CondA'. If you have more than one random factor, input the random effects as a string, collapsed by comma, like '1+CondA, 1+CondA'. Be sure that the order of random effects and that of random factor are same.}
  \item{PCAdeletecriterion}{Criteria for determining whether to remove the component in the random effects. Default value is 0}
  \item{Family}{The distribution family of DV. Default is gaussian, that is, normal distribution.}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\examples{
## Example :
data = DemoData %>%
        Simplecoding(data = ., Factor = 'CondA,CondB') %>%
        MixedModelDummy(data = ., Fix_Factor = 'CondA,CondB',MatrixDesign = '*',ContrastsM = F)
MixedModelDiag(data = data,
               DV = 'DV',
               IV = 'CondA*CondB',
               randomfactor = 'subj,item',
               randomeffect = '1+CondA1+CondB1+CondA1_CondB1,1+CondA1+CondB1+CondA1_CondB1',
               PCAdeletecriterion = 0)
}
