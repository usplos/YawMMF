EffectSizeLmm = function(Model, Type){
  #Type = 'd'
  t = summary(Model)$coef[,4]
  df = summary(Model)$coef[,3]
  library(effectsize)
  if(Type == 'd'){
    convert_t_to_d(t = t, df_error = df,pooled = T)
  }else if(Type == 'r'){
    convert_t_to_r(t = t, df_error = df)
  }else{
    print('Please define the correct Type')
  }

}
