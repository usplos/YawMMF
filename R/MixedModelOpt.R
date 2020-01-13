MixedModelOpt = function(FormulaManual = NULL,Data, DV, Fix_Factor, Re_Factor,ContrastsM = F,
                         Family = 'gaussian', criterionPCA = 0.01, MatrixDesign = '*'){


  if(is.null(FormulaManual)){
    Fix_Factor = Fix_Factor %>% gsub(pattern = ' ',replacement = '',x = .) %>% strsplit(split = ',', fixed = T) %>% unlist()
    Re_Factor = Re_Factor %>% gsub(pattern = ' ',replacement = '',x = .) %>% strsplit(split = ',', fixed = T) %>% unlist()
    if(!isTRUE(ContrastsM)){
      Data[Fix_Factor] = lapply(Data[Fix_Factor], factor)
      Data[Re_Factor] = lapply(Data[Re_Factor], factor)
    }

    for(ff in Fix_Factor){
      if(!isTRUE(ContrastsM)){
        contrasts(Data[[ff]]) = contr.simple(length(levels(Data[[ff]])))
      }
      cat('For the fixed factor of ', ff, ', the contrasts matrix is:\n')
      print(contrasts(Data[[ff]]))
      cat('\n')
    }

    eval(parse(text = paste0('mmff = model.matrix(~ ',paste0(Fix_Factor,collapse = MatrixDesign),', Data)')))

    IVName = gsub(pattern = ':',replacement = '_',x = colnames(mmff)[2:ncol(mmff)]) %>%
      substr(x = ., start = 1, stop = nchar(.))
    Data[IVName] = mmff[,2:ncol(mmff)]
    RandomSlope = paste('(1 + ',paste(IVName,collapse = ' + '),'|',Re_Factor,')',sep = '')
    Formula = paste0(DV,' ~ 1 + ', paste(IVName,collapse = ' + '),' + ',
                     paste(RandomSlope,collapse = ' + '))
  }else{
    Formula = FormulaManual
  }


  if(Family == 'gaussian'){
    ModelAll = eval(parse(text = paste0('lmer(formula = ',Formula,', data = Data,',
                                        'control = lmerControl(optimizer = \'bobyqa\'))')))
  }else{
    ModelAll = eval(parse(text = paste0('glmer(formula = ',Formula,', data = Data,',
                                        'control = glmerControl(optimizer = \'bobyqa\'), family = Family)')))
  }

  if(!is.null(FormulaManual)){
    IVName = summary(ModelAll)$coef %>% row.names() %>% .[2:length(.)]
    DV = strsplit(x = FormulaManual, split = '~',fixed = T,) %>% unlist() %>% .[[1]]
  }

  PCA_All = summary(rePCA(ModelAll))
  k = 0;
  for (ii in 1:length(PCA_All)) {
    k = k + ifelse(length(PCA_All[[ii]]$importance[2,]) > 1,
                   sum(PCA_All[[ii]]$importance[2,][!is.na(PCA_All[[ii]]$importance[2,])]< criterionPCA) + sum(is.na(PCA_All[[ii]]$importance[2,])),
                   0)
  }

  ZPCModel = 0
  if(k > 0 & is.null(FormulaManual)){
    RandomSlope = paste('(1 + ',paste(IVName,collapse = ' + '),'||',Re_Factor,')',sep = '')
    FormulaNew = paste0(DV,' ~ 1 + ', paste(IVName,collapse = ' + '),' + ',
                        paste(RandomSlope,collapse = ' + '))

    if(Family == 'gaussian'){
      ModelAll2 = eval(parse(text = paste0('lmer(formula = ',FormulaNew,', data = Data,',
                                          'control = lmerControl(optimizer = \'bobyqa\'))')))
    }else{
      ModelAll2 = eval(parse(text = paste0('glmer(formula = ',FormulaNew,', data = Data,',
                                          'control = glmerControl(optimizer = \'bobyqa\'), family = Family)')))
    }

    PCA_All = summary(rePCA(ModelAll2))
    k = 0;
    for (ii in 1:length(PCA_All)) {
      k = k + ifelse(length(PCA_All[[ii]]$importance[2,]) > 1,
                     sum(PCA_All[[ii]]$importance[2,][!is.na(PCA_All[[ii]]$importance[2,])]< criterionPCA) + sum(is.na(PCA_All[[ii]]$importance[2,])),
                     0)
    }
    ZPCModel = 1
  }

  if(ZPCModel == 0){
    ModelOpt = ModelAll
  }else{
    ModelOpt = ModelAll2
  }

  NumLoop = 0
  while (k != 0) {
    VarM = VarCorr(ModelOpt)
    NamesVarM = names(VarM)
    Group = names(VarM) %>% strsplit(x = ., split = '.', fixed = T) %>% unlist() %>% .[is.na(as.double(.))]
    Effect = c()
    Std = c()
    for(nn in 1:length(Group)){
      #nn=1
      Matrix = eval(parse(text = paste0('VarM$',NamesVarM[[nn]])))
      Effect[[nn]] = attributes(Matrix)$dimnames[[1]] %>% ifelse(test = .=='(Intercept)','1',.)
      Std[[nn]] = attributes(Matrix)$std
    }

    StdMatrix = data.frame(Group, Effect, Std)
    StdMatrixIntercept = subset(StdMatrix, Effect == '1')
    StdMatrixSlope = subset(StdMatrix, Effect != '1')
    StdMatrixSlope = StdMatrixSlope %>% arrange(-Std) %>% .[-c(nrow(.)),]
    StdMatrix = bind_rows(StdMatrixIntercept, StdMatrixSlope)

    RandomSlopeNew = StdMatrix %>% split(.$Group) %>% map_chr(function(df) {
      df = arrange(df, Effect);paste0('(',paste0(df$Effect, collapse = ' + '), ifelse(length(df$Effect) == 1,' | ',' || '), unique(df$Group),')')
    }) %>% unlist() %>% paste0(collapse = ' + ')

    FormulaNew = paste0(DV,' ~ 1 + ', paste(IVName,collapse = ' + '),' + ',
                        paste(RandomSlopeNew,collapse = ' + '))


    if(Family == 'gaussian'){
      ModelOpt = eval(parse(text = paste0('lmer(formula = ',FormulaNew,', data = Data,',
                                          'control = lmerControl(optimizer = \'bobyqa\'))')))
    }else{
      ModelOpt = eval(parse(text = paste0('glmer(formula = ',FormulaNew,', data = Data,',
                                          'control = glmerControl(optimizer = \'bobyqa\'), family = Family)')))
    }

    PCA_All = summary(rePCA(ModelOpt))
    k = 0;
    for (ii in 1:length(PCA_All)) {
      k = k + ifelse(length(PCA_All[[ii]]$importance[2,]) > 1,
                     sum(PCA_All[[ii]]$importance[2,][!is.na(PCA_All[[ii]]$importance[2,])]< criterionPCA) + sum(is.na(PCA_All[[ii]]$importance[2,])),
                     0)
    }
    NumLoop = NumLoop+1
    if(nrow(StdMatrixSlope) == 0){
      k=0
    }
  }

  NumNA = 0
  for (ii in 1:length(PCA_All)) {
    if(length(PCA_All[[ii]]$importance[2,]) == 1 & is.na(PCA_All[[ii]]$importance[2,1])){
      NumNA = 1
    }
  }

  if(NumLoop > 0){
    if(is.null(FormulaManual)){
      cat('\n\n####################\n\nThe formula of the maximum model was below:\n\n',
          Formula,'\n\n')
      cat('The variance correlation matrix of the maximum model was:\n\n')
      print(VarCorr(ModelAll))
      cat('\n\n####################\n\n')

      cat('HOWEVER, under the criterion you have set, we suggest you use the model with the following formula:\n\n',
          FormulaNew,
          ifelse(NumNA == 1,
                 '\n\nThere is at least one random factor which was redundant, We suggest the deletion of it should be in your consideration. \n\nPlease check the PCA results of the optimised model.\n\n',
                 '\n\n'),
          ifelse(isSingular(ModelOpt,tol = 10e-4),
                 'There still is some singular variance matrix for the optimized model. More stricter criterion for variation-components-deletion should be considered.\n\n',
                 '\n\n'),
          '####################\n\n')

      cat('The differences between the maximum model and the optimized model was calculated with anova() function, and the results were shown:\n\n')
      AnovaModels  = anova(ModelAll, ModelOpt)
      print(AnovaModels)
      cat('\n\n')

      return(list(DataNew = Data,
                  Formula_All = Formula,
                  Formula_Opt = FormulaNew,
                  VarCorr_All = VarCorr(ModelAll),
                  rePCA_All = summary(rePCA(ModelAll)),
                  VarCorr_Opt = VarCorr(ModelOpt),
                  rePCA_Opt = summary(rePCA(ModelOpt)),
                  Model_Compare = AnovaModels,
                  ModelOpt = ModelOpt,
                  Summary_ModelOpt = summary(ModelOpt),
                  ANOVA_ModelOpt = Anova(ModelOpt)))
    }else{
      cat('\n\n####################\n\nThe formula of the model that you input was below:\n\n',
          Formula,'\n\n')
      cat('The variance correlation matrix of the given model was:\n\n')
      print(VarCorr(ModelAll))
      cat('\n\n####################\n\n')

      cat('HOWEVER, under the criterion you have set, we suggest you use the model with the following formula:\n\n',
          FormulaNew,
          ifelse(NumNA == 1,
                 '\n\nThere is at least one random factor which was redundant, We suggest the deletion of it should be in your consideration. \n\nPlease check the PCA results of the optimised model.\n\n',
                 '\n\n'),
          ifelse(isSingular(ModelOpt,tol = 10e-4),
                 'There still is some singular variance matrix for the optimized model. More stricter criterion for variation-components-deletion should be considered.\n\n',
                 '\n\n'),
          '####################\n\n')

      cat('The differences between the given model and the optimized model was calculated with anova() function, and the results were shown:\n\n')
      AnovaModels  = anova(ModelAll, ModelOpt)
      print(AnovaModels)
      cat('\n\n')

      return(list(DataNew = Data,
                  Formula_Giv = Formula,
                  Formula_Opt = FormulaNew,
                  VarCorr_Giv = VarCorr(ModelAll),
                  rePCA_Giv = summary(rePCA(ModelAll)),
                  VarCorr_Opt = VarCorr(ModelOpt),
                  rePCA_Opt = summary(rePCA(ModelOpt)),
                  Model_Compare = AnovaModels,
                  ModelOpt = ModelOpt,
                  Summary_ModelOpt = summary(ModelOpt),
                  ANOVA_ModelOpt = Anova(ModelOpt)))
    }


  }else{
    if(is.null(FormulaManual)){
      cat('\n\n####################\n\nThe maximum model was the most suggested:\n\n',
          Formula,'\n\n')
      cat(ifelse(NumNA == 1,
                 '* There is at least one random factor which was redundant, We suggest the deletion of it should be in your consideration. \n\nPlease check the PCA results of the optimised model.\n\n',
                 ''),
          ifelse(isSingular(ModelOpt,tol = 10e-4),
                 '* There still is some singular variance matrix for the optimized model. More stricter criterion for variation-components-deletion should be considered.\n\n',
                 '\n\n'))
      cat('The variance correlation matrix of the maximum model was:\n\n')
      print(VarCorr(ModelAll))
      cat('\n\n')

      return(list(DataNew = Data,
                  Formula_All = Formula,
                  VarCorr_All = VarCorr(ModelOpt),
                  rePCA_All = summary(rePCA(ModelOpt)),
                  ModelOpt = ModelOpt,
                  Summary_ModelAll = summary(ModelOpt),
                  ANOVA_ModelOpt = Anova(ModelOpt)))
    }else{
      cat('\n\n####################\n\nThe model that you input was the most suggested:\n\n',
          Formula,'\n\n')
      cat(ifelse(NumNA == 1,
                 '* There is at least one random factor which was redundant, We suggest the deletion of it should be in your consideration. \n\nPlease check the PCA results of the optimised model.\n\n',
                 ''),
          ifelse(isSingular(ModelOpt,tol = 10e-4),
                 '* There still is some singular variance matrix for the optimized model. More stricter criterion for variation-components-deletion should be considered.\n\n',
                 '\n\n'))
      cat('The variance correlation matrix of the given model was:\n\n')
      print(VarCorr(ModelAll))
      cat('\n\n')

      return(list(DataNew = Data,
                  Formula_Giv = Formula,
                  VarCorr_Giv = VarCorr(ModelOpt),
                  rePCA_Giv = summary(rePCA(ModelOpt)),
                  ModelOpt = ModelOpt,
                  Summary_ModelAll = summary(ModelOpt),
                  ANOVA_ModelOpt = Anova(ModelOpt)))
    }
  }
}
