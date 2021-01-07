MixedModelDummy = function(Data, FixEffects){
  

  eval(parse(text = paste0('mmff = model.matrix(~ ',FixEffects,', Data)')))
  IVName = gsub(pattern = ':',replacement = '_',x = colnames(mmff)[2:ncol(mmff)]) %>%
    substr(x = ., start = 1, stop = nchar(.))
  Data[IVName] = mmff[,2:ncol(mmff)]

  return(Data)
}
