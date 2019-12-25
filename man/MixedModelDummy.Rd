\name{MixedModelDummy}
\alias{MixedModelDummy}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Dummy vairable generator}
\description{
To generate the dummy variable for the fixed factor
}
\usage{
MixedModelDummy(Data = , Fix_Factor = ,MatrixDesign = )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Data}{Data in which dummy variables will be generated. This data should contain the variables for which the dummy variables are built.}
  \item{Fix_Factor}{The name of variables for which the dummy variables are built.A character vector. If you have more than one fixed factor, please input them as one character element via collapsing them by comma.}
  \item{MatrixDesign}{The way to generate dummy variable. It should be either '*' or '/'. The former means to generate the main effects and interactions, while the latter means to generate the main effect and simple effects}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\examples{
## Example :
MixedModelDummy(Data = DemoData_Continuous_2_2_2, Fix_Factor = 'CondA, CondB', MatrixDesign = '*')
}
\seealso{
\code{\link{MixedModelOpt}}, \code{\link{MixedModelOptPower}}
}
