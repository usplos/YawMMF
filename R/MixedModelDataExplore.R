MixedModelDataExplore = function(Data, DV, DVLog = F, Cond, DeleteCriterion = c(80,1000)){
  cat('please cite: \n')
cat('Zhang, G., Li, X., & Lin, N. (2020). YawMMF: Effective Mixed Model Functions. Available at: https://github.com/usplos/YawMMF.\n')
  if(!is.null(DeleteCriterion)){
    TrialRaw = eval(parse(text = paste0('with(Data, tapply(',DV,', list(',Cond,')',',length))')))
    Data = eval(parse(text = paste0('subset(Data,',DV,' > ', DeleteCriterion[[1]],' & ',DV,' < ', DeleteCriterion[[2]],')')))
    TrialNew = eval(parse(text = paste0('with(Data, tapply(',DV,', list(',Cond,')',',length))')))
  }

  Cond2 = Cond %>% gsub(pattern = ' ',replacement = '',x = .) %>%
    strsplit(x = .,split = ',',fixed = T) %>% unlist()

  pdf(paste0(DV,'_Explore.pdf'))
  print(hist(Data[[DV]], main = paste0('Histogram of ',DV)))

  eval(parse(text = paste0('print(boxplot(data = Data, ',DV,'~',paste0(Cond2,collapse = '*'),
                           ', main = \'Boxplot of ',DV,'\'))')))

  eval(parse(text = paste0('print(qqPlot(Data$',DV,'))')))
  if(isTRUE(DVLog)){
    cat('The Log-transformed QQ plot was shown:\n\n')
    eval(parse(text = paste0('print(qqPlot(log(Data$',DV,')))')))
  }
  dev.off()

  cat('\014')
  if(!is.null(DeleteCriterion)){
    cat('The Number of original trials is:\n');print(TrialRaw);cat('\n\n')
    cat('The number of left trials is: \n');print(TrialNew);cat('\n\n')
    cat('The proportion of the trials left:\n');print(round(TrialNew/TrialRaw,digits = 3));cat('\n\n')
  }
  cat('The skewness of ',DV,' was:\n');print(skewness(Data[[DV]]));cat('\n\n')
  if(isTRUE(DVLog)){
    cat('The skewness of log-transformed ',DV,' was:\n');print(skewness(log(Data[[DV]])));cat('\n\n')
  }

  cat('Normal distribution test for ',DV,' was shown:\n');print(agostino.test(Data[[DV]], alternative ="two.sided"));cat('\n\n')
  if(isTRUE(DVLog)){
    cat('Normal distribution test for log-transformed ',DV,' was shown:\n');print(agostino.test(log(Data[[DV]]), alternative ="two.sided"));cat('\n\n')
  }
  cat('There is one pdf file named ', paste0('\'',DV,'_Explore.pdf\''), ' in your working space')

  if(!is.null(DeleteCriterion)){
    return(Data)
  }
}
