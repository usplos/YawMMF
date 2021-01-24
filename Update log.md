## 20210119
A new fucntion named `matchingvariablegeneralized(y, by, type = 'F', threshold = 1)` has been updated. `matchingvariable()` can find as many obsearved data as possible that are not significantly different between **only two conditions (or within one condition variable with two levels)**.
However, **sometimes there are more than two levels within one condition variable. In addition, usually there are more than one condition variable**. In these situation, `matchingvariable()` can not satify the users, while `matchingvariablegeneralized()` can.

When using this function, users should set the parameter `by` as a `list` object which include the condition variables of interest.

```
set.seed(1234)
y = c(rnorm(100,0),
      rnorm(120,0.1),
      rnorm(120,0.2),
      rnorm(110,0.3),
      rnorm(110,0.2),
      rnorm(120,0.4))
by = cbind(c(rep('A1',340),rep('A2',340)),
           c(rep('B1',100),rep('B2',120),rep('B3',120),
             rep('B1',110), rep('B2',110), rep('B3',120)))
testdf = tibble(y,V1=by[,1],V2=by[,2])

testdf = testdf %>% 
  mutate(matchingtest = matchingvariablegeneralized(y = y, 
                                                    by = list(V1,V2), 
                                                    type = 'F',
                                                    threshold = 1.5)) %>%
  filter(matchingtest == 1)
```

## 20210117
A new function named `matchingvalue(y, value, type='t', threshold = 1)` has been updated. This function works in a similar way with `matchingvariable()`. It can find as many obsearved data (set using the parameter `y` in the function) as possible of which the mean is not significantly different with a given value (set using the parameter `value` in the function). 

```
set.seed(1234)
y = rnorm(n = 200, mean = 0.5)

matchingvalue(y = y, value, type='t', threshold = 1)
```

## 20210107
A new function named `matchingvariable(y = , by = , type = 't', threshold = 1)` has been updated. It is very common in cognitive experiments that you need two sets of experimental materials that are equal in number and match on a particular attribute. You want to make sure that there is no significant difference between the two groups of materials in the (rating) score for this attribute, and you want to find as many materials as possible that meet this requirement. This function will help you do this efficiently.

This function will return a set of  0-1 vector, in which 1 means qualified, while 0 means unqualified.

You can use statistical `t` value (*e.g.* *`t`* < 1) to select the materials:
```
y1 = rnorm(100,mean = 0, sd = 1)
cond1 = rep('C1', 100)
y2 = rnorm(120,mean = 0.5, sd = 1)
cond2 = rep('C2', 120)
y = c(y1, y2)
by = c(cond1, cond2)
matchingvariable(y = y, by = by, type = 't', threshold = 1)
```

You can also use statistical `p` value (*e.g.* *`p`* > 0.1) to select the materials:
```
matchingvariable(y = y, by = by, type = 'p', threshold = 0.1)
```

## 20201217
A new function named `PCOR(X,Y,...,Method = 'pearson', Alternative='two.sided')` has been updated. It can perfrom the partial correlation analysis. The `X` and 'Y' are the two variables that the partial correlation is perfomed between. `...` are the variables to be controlled. `Method` and `Alternative` parameters can be defined in the same way as the `method` and `alternative` ones in the base `R` function `cor.test()`.

## 20201028
**Critical update:**  A new function named `MixedModelWrite2(Model = NULL, Data = NULL, Prefix = 'DV', compareModel = F, ModelnamesTocompare)` has been created. It can output the information of fixed effects for more than one model in the form of `docx` document. *This function requires [`export` package](https://github.com/tomwenseleers/export) and `texreg` package. But these can be automatically installed.*

The information of parameters is following:

* `Model` - a list of Models;
* `Data` - a list of summarised data;
* `Prefix` - prefix for the name of the output file;
* `compareModel` - whether to compare different models; it only works when the `Model` is not set `NULL`;
* `ModelnamesTocompare` - the names of the models to be compared; it only works when the `compareModel` is set `'T'`.

Here is one example:
```
library(YawMMF)
Model1 = lmer(data = DemoData, 
              DV~CondA+(1|subj)+(1|item))
Model2 = lmer(data = DemoData, 
              log(DV)~CondA+(1|subj)+(1|item))
MixedModelWrite2(Model = list(Model1, Model2),
                 Prefix = 'DV',
                 compareModel = T,
                 ModelnamesTocompare = c('Origin','Log'))
```

## 20201016
* A new function named `EffectSize()` has been added. This function depends on `effectsize` package in R, and can be used to calculate the effect size of the fixed effects for a given mixed model (whether the model is generalized or not). 

*Notion that the parameter `Type` can only be defined as `'d'` or `'r'`.*

*Notion that the function will provide the equation of calculating accordingly, which will help researchers understand and check the results.*

Here is an example:
```
library(YawMMF)
Model1 = lmer(data=DemoData, DV~CondA+(1|subj))
Model2 = glmer(data = DemoData2, DV~CondA+(1|subj),family = 'binomial')

# to calculate the cohen d value
EffectSize(Model = Model1, Type = 'd', GLMM = F)
EffectSize(Model = Model2, Type = 'd', GLMM = T)

# to calculate the r value
EffectSize(Model = Model1, Type = 'r', GLMM = F)
EffectSize(Model = Model2, Type = 'r', GLMM = T)

```



## 20200918
* A new funciton named `StrInsertSpace()` has been added. Using it like `StrInsertSpace(c('AA','AAA','AAAA'))`
* A new function named `StrDeletePosition()` has been added. Using it like `StrDeletePosition(X = 'ABCDEFG', position = c(1,3,5)`
* A new funciton named `StrSubPosition()` has been added. Using it like `StrSubPosition(X = 'ABCDEFG', position = c(1,3,5)`
* A new function named `StrUniqueChar()` has been added. Using it like `StrUniqueChar(X = 'ABCDDEFGG')`

## 20200831
* A new function named `p.sig(p, numcontrasts = 1)` has been updated. This function can return the significance labels for p value. For the parameter `numcontrasts`, the default value is 1, indicating that there is no Bonferroni correction. And if any, by setting this parameter, this function can return the significance labels whether the contrasts have survived the Bonferroni correction.

## 20200621
* The function `MixedModelOpt()` has been removed. There are some potential problems within it, which may cause misleading results.
* A new function named `MixedModelDiag()` has been updated. Unlike `MixedModelOpt()`, this new function does not return the optimized model and corresponse results, but provides more comprehensive and objective information which the users can refer to. Here is an example for using it.
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


## 20200415
* A new function named `NORM_CLUST()` has been added. This function can seperate a given sample, of which distribution is not normal, into a limited number of sub-sample of which distributions are all normal, and then return the numeric category labels.


## 20200404
* A new function named `seq_space()` has been added. This function is similiar to `diff()`, supporting calculated the lagged and iterated differences.
* A new function named `seq_reverse()` has been added. This function can return the vector in reversed relative order.
* A new function named `seq_evermax()` has been added. This function can return whether the number is the maximum number in the sub-vector from the beginning to the current position.

## 20200117
* A new function named `MixedModelWrite()` has been added. This function support writing the fixed effects of a given model and the descriptive information of a given data into your disk. This will help you tidy the results in your paper. In addition, it will generate the qqplot of the residuals of the model.
* A new function named `MixedModelExplore()` has been added. This function can offer the information about the distribution of the dependent variable. This will help you detect whether it is needed to delete some value (e.g. outliers) or to transform the dependent vaiable (e.g. log-transformed).

## 20200110
* `MixedModelOpt()` Can offer suggestions if the there is any redundant random factor. Users can choose whether the contrasts manner of the fixed factors has been set via parameter `ContrastsM`; set it TRUE means the contrasts manner has been set mannually; otherwise, the function will use `contr.simple()` to set. Remember that the output will only report the existence of the redundant random factor rather than point out it/them for now. So which random factor(s) is/are redundant should be checked further.

* `MixedModelPlot()` For violin-plus-raw-data plot, users can choose whether to use the mean of DV across any group variable such as subject or item rather than use the raw observations via set the parameter `Group`; if the parameter is set `NULL` (this is also the default value), raw observations will be used to plot; otherwise, if users set it as the name of a given group variable, the mean values of raw observations on each unit in this group will be first calculated, and then the mean values are used to plot.
