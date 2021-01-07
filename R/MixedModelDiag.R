#### simplecoding() ####
Simplecoding = function(data, Factor){
  
cat('please cite: \n')
cat('Zhang, G., Li, X., & Lin, N. (2020). YawMMF: Effective Mixed Model Functions. Available at: https://github.com/usplos/YawMMF.\n')

  Factors = Factor %>% strsplit(split = ' ',fixed = T) %>% unlist() %>%
    paste(sep = '') %>% strsplit(split = ',',fixed = T) %>% unlist()
  data[Factors] = lapply(data[Factors],FUN = factor)
  for (ff in 1:length(Factors)) {
    contrasts(data[[Factors[[ff]]]]) = contr.simple(n = length(levels(data[[Factors[[ff]]]])))
  }
  return(data)
}

#### VarCorr2df() ####
VarCorr2df = function(Model){
  Var = VarCorr(Model)
  df = data.frame()
  for (ss in 1:length(Var)) {
    Refactor = names(Var)[[ss]] %>% strsplit(split = '.',fixed = T) %>% unlist() %>% .[[1]]
    Reeffect = Var[[ss]] %>% attributes() %>% .$std %>% names() %>% ifelse(. == '(Intercept)',yes = 'Intercept',no = .)
    Std = Var[[ss]] %>% attributes() %>% .$std %>% .[[1]]
    df = rbind(df,
               data.frame(Refactor, Reeffect, Std))
  }
  df %>% arrange(Refactor, Std)
}

#### rePCA2df() ####
rePCA2df = function(Model){
  PCA = summary(rePCA(Model))
  PCAdf = data.frame()
  for (ff in 1:length(PCA)) {
    Refactor = names(PCA)[[ff]] %>% rep(times = PCA[[ff]]$importance %>% ncol())
    Prop = PCA[[ff]]$importance[2,]
    PCAdf = rbind(PCAdf, data.frame(Refactor, Prop))
  }
  PCAdf %>% arrange(Refactor, Prop)
}

#### MixedModelDiag() ####
MixedModelDiag = function(data, DV, IV, randomfactor, randomeffect, PCAdeletecriterion = 0, Family = 'gaussian'){
  cat('please cite: \n')
cat('Zhang, G., Li, X., & Lin, N. (2020). YawMMF: Effective Mixed Model Functions. Available at: https://github.com/usplos/YawMMF.\n')
  randomfactor = randomfactor %>% strsplit(split = ',',fixed = T) %>% unlist()
  randomeffect = randomeffect %>% strsplit(split = ',',fixed = T) %>% unlist()
  FormulaREmax = c()
  for (ii in 1:length(randomfactor)) {
    FormulaREmax[[ii]] = paste0('(',randomeffect[[ii]],'|',randomfactor[[ii]],')')
  }
  FormulaREmax = paste0(FormulaREmax,collapse = ' + ')
  Formulamax = paste(DV,'~',IV,'+',FormulaREmax,sep = ' ')
  if(Family == 'gaussian'){
    Modelmax = lmer(data = data, formula = as.formula(Formulamax), control = lmerControl(optimizer = 'bobyqa'))
  }else{
    Modelmax = glmer(data = data, formula = as.formula(Formulamax), family = Family)
  }
  cat('Based on your parameters, the formula of the max model is:\n',Formulamax,'\n\n')
  Errorchk = F
  if(isSingular(Modelmax)){
    cat('However, the max model is of singular covariance matrics. \nYou can use \'isSingular()\' function to check it.\n\n')
    Errorchk = T
  }
  if(length(Modelmax@optinfo$warnings) > 0){
    cat('However, there are some warnings for the max model:\n',Modelmax@optinfo$warnings,'\n\n')
    Errorchk = T
  }
  if(isTRUE(Errorchk)){
    cat('The max model should be optimized.\n\n')

    FormulaREZCP = c()
    for (ii in 1:length(randomfactor)) {
      FormulaREZCP[[ii]] = paste0('(',randomeffect[[ii]],'||',randomfactor[[ii]],')')
    }
    FormulaREZCP = paste0(FormulaREZCP,collapse = ' + ')
    FormulaZCP = paste(DV,'~',IV,'+',FormulaREZCP,sep = ' ')
    if(Family == 'gaussian'){
      ModelZCP = lmer(data = data, formula = as.formula(FormulaZCP), control = lmerControl(optimizer = 'bobyqa'))
    }else{
      ModelZCP = glmer(data = data, formula = as.formula(FormulaZCP), family = Family)
    }

    cat('The formula of zero-coefficient-parameter(ZCP) model is: \n',FormulaZCP,'\n\n')
    Errorchk2 = F
    if(isSingular(ModelZCP)){
      cat('The ZCP model is also of singular covariance matrics.\n\n')
      Errorchk2 = T
    }
    if(length(ModelZCP@optinfo$warnings) > 0){
      cat('There are some warnings for the ZCP model:\n',ModelZCP@optinfo$warnings[[1]],'\n\n')
      Errorchk2 = T
    }

    if(isTRUE(Errorchk2)){
      Vardf = VarCorr2df(ModelZCP)
      Vardf['Prop'] = rePCA2df(ModelZCP)[[2]]
      Vardf['Suggestion'] = ifelse(Vardf$Prop > PCAdeletecriterion,'Remain','Delete')

      cat('    For each random effect on each random factor,',
          'the standard deviation (reflected by the \'Std\' column) and the accounted variance (reflected by the \'Prop\' column) are shown in the following table:\n\n')
      print(Vardf)
      cat('\n    The \'Suggestions\' column shows the suggestion that whether the random effect should be remained or deleted, according to the delete-criterion you set.\n\n')

      Vardf['Reeffectnew']=ifelse(Vardf$Reeffect != 'Intercept', Vardf$Reeffect %>% as.character(),
                                  ifelse(Vardf$Suggestion == 'Remain','1','-1'))
      FormulaRenew = Vardf %>% filter(Suggestion == 'Remain') %>% group_by(Refactor) %>% summarise(Re = paste0(Reeffectnew,collapse = ' + ')) %>% mutate(Formulanew = paste('(',Re,'||',Refactor,')',sep = '')) %>% .[[3]] %>% paste0(collapse = ' + ')
      Formulanew = paste0(DV,' ~ ',IV,' + ',FormulaRenew)

      cat('  According to the results, the following formula was suggested:\n  ',Formulanew,'\n\n')
    }

  }else{
    cat('The max model needs no optimization. You can use it directly.\n\n')
  }
}
