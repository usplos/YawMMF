# YawMMF
Effective **M**ixed **M**odel **F**unctions 


![](https://img.shields.io/badge/R-package-success)
![](https://img.shields.io/badge/Version-0.1.0-success)
![](https://img.shields.io/github/license/usplos/YawMMF?label=License&color=success)
[![](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![](https://img.shields.io/github/stars/usplos/YawMMF?style=social)](https://github.com/usplos/YawMMF/stargazers)


[![](https://img.shields.io/badge/Follow%20me%20on-Zhihu-blue)](https://www.zhihu.com/people/Psych.ZhangGuangyao/ "Personal profile on Zhihu.com")

## Citation
Zhang, G. (2020). *YawMMF: Effective Mixed Model Functions*. Available at: https://github.com/usplos/YawMMF

## Install
```r
if(!require(devtools)) install.packages("devtools")
devtools::install_github("usplos/YawMMF")
```

## Installation Bugs and Possible Solutions

### Bug 01
```
> install.packages("YawMMF")
Warning in install.packages :
  package ‘YawMMF’ is not available (for R version 3.6.1)
```

`YawMMF` package should be installed from Github instead of [`CRAN`](https://cran.r-project.org/web/packages/index.html)

#### Solution

Please use the command `devtools::install_github('usplos/YawMMF')` instead of  `install.packages("YawMMF")`

### Bug 02

```
WARNING: Rtools is required to build R packages, but is not currently installed.

Please download and install Rtools 3.5 from http://cran.r-project.org/bin/windows/Rtools/
```

#### Solution

Download and install [Rtools](http://cran.r-project.org/bin/windows/Rtools/).

### Bug 03

```
* installing *source* package 'YawMMF' ...
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** byte-compile and prepare package for lazy loading
错误: (由警告转换成)程辑包'simr'是用R版本3.6.2 来建造的
停止执行
ERROR: lazy loading failed for package 'YawMMF'
Error: Failed to install 'YawMMF' from GitHub:
  (converted from warning) installation of package ‘YawMMF’ had non-zero exit status
```

#### Solution

Update R to the [latest version](https://cran.r-project.org/), because the latest versions of some packages (e.g., `simr`) also require the latest version of R.

Tips: You can use the `installr` package to copy all your installed packages from the old folder to the new one.
```r
install.packages("installr")
library(installr)
copy.packages.between.libraries(ask=TRUE)
```

## Brief introduction 
This package offers convenient and effective functions for mixed model.

`MixedModelDataSummary()` : to summarise your data. (This function is still maturing)

`MixedModelDummy()` : to generate dummy variables for factor variables.

`MixedModelOpt()` : to optimize your model.

`MixedModelPower()` : to perform the power analysis.

`MixedModelOptPower()` : to optimize your model and then perform the power analysis at one time.

`MixedModelPlot()` : to draw bar plot, interaction line plot, violin plus box plot, violin plus rawdata plot.

`MixedModelEmm()` : to compute estimated marginal means (EMMs) for specified factors in a mixed model, 
and comparisons or contrasts among them. (This function is still maturing)

`CorrPlot()` : to draw correlation-matrix plot for multiple-variable correlations 

`contr.simple()` : to set the contrast matrix of factor variables as simple contrast.

## Functions that have not been created

...
