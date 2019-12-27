# YawMMF
Effective **M**ixed **M**odel **F**unctions 


![](https://img.shields.io/badge/R-package-success)
![](https://img.shields.io/badge/Version-0.1.0-success)
![](https://img.shields.io/github/license/usplos/YawMMF?label=License&color=success)
[![](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![](https://img.shields.io/github/stars/usplos/YawMMF?style=social)](https://github.com/usplos/YawMMF/stargazers)


[![](https://img.shields.io/badge/Follow%20me%20on-Zhihu-blue)](https://www.zhihu.com/people/Psych.ZhangGuangyao/ "Personal profile on Zhihu.com")

## Citation
Zhang, G. -Y. (2020). YawMMF: Effective Mixed Model Functions. Retrieved from https://github.com/usplos/YawMMF

## Install
```r
if(!require(devtools)) install.packages("devtools")
devtools::install_github("usplos/YawMMF")
```

## Brief introduction 
This package offers convenient and effective functions for mixed model.

`MixedModelDataSummary()` : to summarise your data.

`MixedModelDummy()` : to generate dummy variables for factor variables.

`MixedModelOpt()` : to optimize your model.

`MixedModelPower()` : to perform the power analysis.

`MixedModelOptPower()` : to optimize your model and then perform the power analysis at one time.

`MixedModelPlot()` : to draw bar plot, interaction line plot, violin plus box plot, violin plus rawdata plot.

`MixedModelEmm()` : to compute estimated marginal means (EMMs) for specified factors in a mixed model, 
and comparisons or contrasts among them. (This function is still maturing)

`CorrPlot()` : to draw correlation-matrix plot for multiple correlations 

`contr.simple()` : to set the contrast matrix of factor variables as simple contrast.

## Functions that have not been created

...
