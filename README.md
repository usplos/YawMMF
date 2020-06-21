# YawMMF
Effective **M**ixed **M**odel **F**unctions 


![](https://img.shields.io/badge/R-package-success)
![](https://img.shields.io/badge/Version-0.1.0-success)
![](https://img.shields.io/github/license/usplos/YawMMF?label=License&color=success)
[![](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![](https://img.shields.io/github/stars/usplos/YawMMF?style=social)](https://github.com/usplos/YawMMF/stargazers)


[![](https://img.shields.io/badge/Follow%20me%20on-Zhihu-blue)](https://www.zhihu.com/people/Psych.ZhangGuangyao/ "Personal profile on Zhihu.com")

## Citation
Zhang, G. (2020). *YawMMF: Effective Mixed Model Functions*. Available at: https://github.com/usplos/YawMMF.

## Install
```r
if(!require(devtools)) install.packages("devtools")
devtools::install_github("usplos/YawMMF")
```

**If not necessary, do not update the packages suggested to be updated.**

**If not necessary, do not update the packages suggested to be updated.**

**If not necessary, do not update the packages suggested to be updated.**

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

#### Solution 1

Download and install [Rtools](http://cran.r-project.org/bin/windows/Rtools/).

#### Solution 2

Download and install [Git](https://git-scm.com/downloads).

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

`MixedModelDataExplore()` : to explore the dependent vairable (usually a continuous variable)

`MixedModelDataSummary()` : to summarise your data. (This function is still maturing)

`MixedModelDummy()` : to generate dummy variables for factor variables.

`MixedModelOpt()` : to optimize your model.

`MixedModelPower()` : to perform the power analysis.

`MixedModelOptPower()` : to optimize your model and then perform the power analysis at one time.

`MixedModelPlot()` : to draw bar plot, interaction line plot, violin plus box plot, violin plus rawdata plot.

`MixedModelEmm()` : to compute estimated marginal means (EMMs) for specified factors in a mixed model, 
and comparisons or contrasts among them. (This function is still maturing)

`MixedModelWrite()` : to write the fixed effects of the given model or the descriptive inforamtion of the given dependent variable into yourdisk

`CorrPlot()` : to draw correlation-matrix plot for multiple-variable correlations 

`contr.simple()` : to set the contrast matrix of factor variables as simple contrast.

## Update log

#### 20200621
* The function `MixedModelOpt()` has been removed. There are some potential problems within it, which may cause misleading results.
* A new function named `MixedModelDiag()` has been updated. Unlike 'MixedModelOpt()', this new function does not return the optimized model and corresponse results, but provides more comprehensive and objective information which the users can refer to. Here is an example for using it.
* Several convenient functions have been updated. `Simplecoding()` is able to set the contrast-coding for factors within the data. `rePCA2df()` can help tidy the results of `rePCA()`. `VarCorr2df()` can help tidy the results of `VarCorr()`.

```
library(YawMMF)
DemoData %>% 
    Simplecoding(data = ., Factor = 'CondA,CondB') %>%
    MixedModelDummy(data = ., Fix_Factor = 'CondA,CondB',MatrixDesign = '*',ContrastsM = F) %>% 
    MixedModelDiag(data = ., 
                   DV = 'DV', 
                   IV = 'CondA*CondB',
                   randomfactor = 'subj,item',
                   randomeffect = '1+CondA1+CondB1+CondA1_CondB1,1+CondA1+CondB1+CondA1_CondB1',
                   PCAdeletecriterion = 0)
```


#### 20200415
* A new function named `NORM_CLUST()` has been added. This function can seperate a given sample, of which distribution is not normal, into a limited number of sub-sample of which distributions are all normal, and then return the numeric category labels.


#### 20200404
* A new function named `seq_space()` has been added. This function is similiar to `diff()`, supporting calculated the lagged and iterated differences.
* A new function named `seq_reverse()` has been added. This function can return the vector in reversed relative order.
* A new function named `seq_evermax()` has been added. This function can return whether the number is the maximum number in the sub-vector from the beginning to the current position.

#### 20200117
* A new function named `MixedModelWrite()` has been added. This function support writing the fixed effects of a given model and the descriptive information of a given data into your disk. This will help you tidy the results in your paper. In addition, it will generate the qqplot of the residuals of the model.
* A new function named `MixedModelExplore()` has been added. This function can offer the information about the distribution of the dependent variable. This will help you detect whether it is needed to delete some value (e.g. outliers) or to transform the dependent vaiable (e.g. log-transformed).

#### 20200110
* `MixedModelOpt()` Can offer suggestions if the there is any redundant random factor. Users can choose whether the contrasts manner of the fixed factors has been set via parameter `ContrastsM`; set it TRUE means the contrasts manner has been set mannually; otherwise, the function will use `contr.simple()` to set. Remember that the output will only report the existence of the redundant random factor rather than point out it/them for now. So which random factor(s) is/are redundant should be checked further.

* `MixedModelPlot()` For violin-plus-raw-data plot, users can choose whether to use the mean of DV across any group variable such as subject or item rather than use the raw observations via set the parameter `Group`; if the parameter is set `NULL` (this is also the default value), raw observations will be used to plot; otherwise, if users set it as the name of a given group variable, the mean values of raw observations on each unit in this group will be first calculated, and then the mean values are used to plot.
