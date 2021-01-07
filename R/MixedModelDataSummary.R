MixedModelDataSummary = function(Data, DV = 'DV',Cond = 'CondA', Group = NA){
  cat('please cite: \n')
cat('Zhang, G., Li, X., & Lin, N. (2020). YawMMF: Effective Mixed Model Functions. Available at: https://github.com/usplos/YawMMF.\n')
  if(!require(tidyverse)) install.packages('tidyverse')


  if(!is.na(Group)){
    DF = eval(parse(text = paste0('Data %>% group_by(',
                                  Cond,',',Group,')')))
    DF = eval(parse(text = paste0('summarise(DF, Mean2 = mean(',DV,'),',
                                  'trialnum = length(',DV,'))')))
    DF = eval(parse(text = paste0('DF %>% group_by(',Cond,')')))
    DF = eval(parse(text = paste0('summarise(DF, TrialNum = sum(trialnum), Mean = mean(Mean2), SD = sd(Mean2), SE = sd(Mean2)/sqrt(length(Mean2)))')))
    names(DF)[which(names(DF) == 'SD')] = paste(DV, '_SD',sep = '')
    names(DF)[which(names(DF) == 'TrialNum')] = paste(DV, '_TrialNum',sep = '')
    names(DF)[which(names(DF) == 'Mean')] = paste(DV, '_Mean',sep = '')
    names(DF)[which(names(DF) == 'SE')] = paste(DV, '_SE',sep = '')
  }else{
    DF = eval(parse(text = paste0('Data %>% group_by(',
                                  Cond,')')))
    DF = eval(parse(text = paste0('summarise(DF, Mean = mean(',DV,'),',
                                  'Trialnum = length(',DV,'), SD = sd(',DV,'), SE = sd(',DV,')/sqrt(length(',DV,')))')))
  }
  return(DF)
}
