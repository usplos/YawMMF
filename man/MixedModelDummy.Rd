\name{MixedModelDummy}
\alias{MixedModelDummy}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Dummy vairable generator}
\description{
To generate the dummy variable for the fixed factor
}
\usage{
MixedModelDummy(Data, FixEffects)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Data}{Data in which dummy variables will be generated. This data should contain the variables for which the dummy variables are built.}
  \item{FixEffects}{The fixed effects to be investigated. A character parameter, like 'CondA+CondB' or 'CondA*CondB'.}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\examples{
## Example :
  data = Simplecoding(data = DemoData, Factor = 'CondA,CondB')
  MixedModelDummy(Data = data, FixEffects = 'CondA*CondB')
}
