\name{MixedModelPlot}
\alias{MixedModelPlot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Plot for category variables}
\description{
To plot for experimental data in which the indepdent variables are factor variables.
}
\usage{
MixedModelPlot(Data = NULL, DV, SE = NULL, Pred, Modx = NULL, Mod2 = NULL,
            Geom = 'bar',
            Barwidth = 0.5, Fill=NULL,DodgeWidth = 0.5,
            Color = NULL,
            ErrorBarWidth = 0.2, ErrorBarColor = 'black',
            ViolinWidth = 0.5, BoxWidth = 0.1,
            ViolindataBandWidth = 0.5, ViolindataAlpha = 0.5,
            Xlab = NULL, Ylab = NULL, Title = NULL, Legend = NULL,
            Edit = F)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Data}{The data used to plot}
  \item{DV}{Dependent variable. A character element}
  \item{SE}{Name of standard error in data, useful for bar plot and interaction plot}
  \item{Pred}{The variable of the x axis}
  \item{Modx}{The first modulator}
  \item{Mod2}{The second modulator}
  \item{Geom}{Can be one of the four options: 'bar','line','violin1','violin2'}
  \item{Barwidth}{The width of bar}
  \item{Fill}{The color to fill}
  \item{DodgeWidth}{Set the position_dodge}
  \item{Color}{The color of line and point}
  \item{ErrorBarWidth}{Width of errorbar}
  \item{ErrorBarColor}{Color of errorbar, only useful for bar plot}
  \item{ViolinWidth}{Width of one violin bar in violin plot}
  \item{Group}{Whether there is special group on which the mean should be calculate for violin plot, ususally the subject variable. The default value is NULL, i.e. no such group. Otherwise, set this parameter the group variable. A character variable}
  \item{BoxWidth}{Width of one box in violin plot}
  \item{ViolindataBandWidth}{Width of raw data band in violin plot}
  \item{ViolindataAlpha}{Transparency of raw data in violin plot}
  \item{Xlab}{X axis label}
  \item{Ylab}{Y axis label}
  \item{Title}{Title of plot}
  \item{Legend}{Label of legend}
  \item{Edit}{Whether to edit the plot using ggedit package}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\examples{
## Example : Bar plot

MixedModelPlot(Data = MixedModelDataSummary(DemoData,DV = 'DV',Cond = 'CondA,CondB',Group = 'subj'),
               DV = 'DV_Mean',SE = 'DV_SE',
               Pred = 'CondA',Modx = 'CondB',
               Geom = 'bar',Barwidth = 0.9,Fill = gray(c(0.2,0.5)),
               DodgeWidth = 0.9, ErrorBarWidth = 0.2, ErrorBarColor = 'red')

## Example : Line plot
MixedModelPlot(Data = MixedModelDataSummary(DemoData,DV = 'DV',Cond = 'CondA,CondB',Group = 'subj'),
               DV = 'DV_Mean',SE = 'DV_SE',
               Pred = 'CondA',Modx = 'CondB',Geom = 'line',
               DodgeWidth = 0.9,
               ErrorBarWidth = 0.2,
               Color = gray(c(0.2,0.5)),Xlab = 'X axis',Ylab = 'Y axis',Title = 'This is title',Legend = 'Condition B')

## Example: Violine and boxplot
MixedModelPlot(Data = DemoData,
               DV = 'DV',Pred = 'CondA',Modx = 'type',Mod2 = 'CondB',
               Geom = 'violin1',Fill = gray(c(0.5, 0.8)),
               DodgeWidth = 0.9, ViolinWidth = 0.9, BoxWidth = 0.1, Legend = 'Type')

## Example : Violine and Raw data
MixedModelPlot(Data = DemoData,
               DV = 'DV',Pred = 'CondA',Modx = 'type',Mod2 = 'CondB',
               Geom = 'violin2',Fill = gray(c(0.5, 0.8)), Group = 'subj',
               DodgeWidth = 1, ViolinWidth = 1, ViolindataBandWidth = 0.5, ViolindataAlpha = 0.6,
               Legend = 'XXX')

}
