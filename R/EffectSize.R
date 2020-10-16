EffectSize = function(Model, Type, GLMM=F){
  library(effectsize)
  if(isTRUE(GLMM)){
    z = summary(Model)$coef[,3]
    n = Model@frame %>% nrow()
    if(Type == 'd'){
      convert_z_to_d(z = z,n = n)
    }else if(Type == 'r'){
      convert_z_to_r(z = z,n = n)
    }else{
      print('Please define the correct Type')
    }
  }else{
    t = summary(Model)$coef[,4]
    df = summary(Model)$coef[,3]

    if(Type == 'd'){
      convert_t_to_d(t = t, df_error = df,pooled = T)
    }else if(Type == 'r'){
      convert_t_to_r(t = t, df_error = df)
    }else{
      print('Please define the correct Type')
    }
  }

}
