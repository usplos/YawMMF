\name{MixedModelOpt}
\alias{MixedModelOpt}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Model Optimization}
\description{
To optimize your model, either maximum model or pre-defined model
}
\usage{
MixedModelOpt(FormulaManual = NULL,Data, DV, Fix_Factor, Re_Factor,
              Family = 'gaussian', criterionPCA = 0.01, MatrixDesign = '*', REML = F)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{FormulaManual}{The formula that you give. The default value is NULL. And if so, the function will use the following parameters. Otherwise, it will optimize the model based on this formula}
  \item{Data}{Data to build the model.}
  \item{DV}{The name of the dependent variable. A character vector}
  \item{Fix_Factor}{The names of fixed factors. A character vector. If you have more than one fixed factors, please input them as one character element via collapsing them by comma.}
  \item{Re_Factor}{The names of random factors. A character vector. If you have more than one random factors, please input them as one character element via collapsing them by comma.}
  \item{Family}{The distribution family of dependent variable. A character vector. The default is 'gaussian'. }
  \item{criterionPCA}{The criterion to exclude the random slopes. The percentage of each remaining slopes should be greater the criterion. The default is 0.01}
  \item{MatrixDesign}{The way to generate dummy variable. It should be either '*' or '/'. The former means to generate the main effects and interactions, while the latter means to generate the main effect and simple effects}
  \item{REML}{Same with that in lmer function of lmerTest package}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\examples{
## Example :
MixedModelOpt(Data = DemoData, DV = 'DV', Fix_Factor = 'CondA, CondB', Re_Factor = 'subj, item')
}
\seealso{
\code{\link{MixedModelDummy}}, \code{\link{MixedModelOptPower}}
}
