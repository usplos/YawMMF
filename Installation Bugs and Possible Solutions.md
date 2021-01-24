

## Bug 01
```
> install.packages("YawMMF")
Warning in install.packages :
  package ‘YawMMF’ is not available (for R version 3.6.1)
```

`YawMMF` package should be installed from Github instead of [`CRAN`](https://cran.r-project.org/web/packages/index.html)

### Solution

Please use the command `devtools::install_github('usplos/YawMMF')` instead of  `install.packages("YawMMF")`

## Bug 02

```
WARNING: Rtools is required to build R packages, but is not currently installed.

Please download and install Rtools 3.5 from http://cran.r-project.org/bin/windows/Rtools/
```

### Solution 1

Download and install [Rtools](http://cran.r-project.org/bin/windows/Rtools/).

### Solution 2

Download and install [Git](https://git-scm.com/downloads).

## Bug 03

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

### Solution

Update R to the [latest version](https://cran.r-project.org/), because the latest versions of some packages (e.g., `simr`) also require the latest version of R.

Tips: You can use the `installr` package to copy all your installed packages from the old folder to the new one.
```r
install.packages("installr")
library(installr)
copy.packages.between.libraries(ask=TRUE)
```
