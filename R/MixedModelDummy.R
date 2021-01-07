MixedModelDummy = function(Data, FixEffects){
  
cat('please cite: \n')
cat('Zhang, G., Li, X., & Lin, N. (2020). YawMMF: Effective Mixed Model Functions. Available at: https://github.com/usplos/YawMMF.\n')

  eval(parse(text = paste0('mmff = model.matrix(~ ',FixEffects,', Data)')))
  IVName = gsub(pattern = ':',replacement = '_',x = colnames(mmff)[2:ncol(mmff)]) %>%
    substr(x = ., start = 1, stop = nchar(.))
  Data[IVName] = mmff[,2:ncol(mmff)]

  return(Data)
}
