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

You can use `MixedModelDataSummary()` to summarise your data.

You can use `MixedModelDummy()` to generate dummy variables for factor variables.

You can use `MixedModelOpt()` to optimize your model.

You can use `MixedModelPower()` to perform the power analysis.

You can use `MixedModelOptPower()` to optimize your model and then perform the power analysis at one time.

You can use `contr.simple()` to set the contrast matrix of factor variables as simple contrast.
