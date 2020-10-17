EffectSize = function(Model, Type, GLMM=F){
  library(effectsize)
  if(isTRUE(GLMM)){
    z = summary(Model)$coef[,3]
    n = Model@frame %>% nrow()

    if(Type == 'd'){
      cat('Notion that the calculation:\n')
      cat('   d = 2*z / sqrt(SampleSize)\n')

      z_to_d(z = z,n = n) %>% as.matrix()
    }else if(Type == 'r'){
      cat('Notion that the calculation:\n')
      cat('   r = z / sqrt(z * z + SampleSize)\n')

      z_to_r(z = z,n = n) %>% as.matrix()
    }else{
      print('Please define the correct Type')
    }
  }else{
    t = summary(Model)$coef[,4]
    df = summary(Model)$coef[,3]

    if(Type == 'd'){
      cat('Notion that the calculation:\n')
      cat('   d = 2*t / sqrt(df_Error)\n')

      t_to_d(t = t, df_error = df,paired = F) %>% as.matrix()
    }else if(Type == 'r'){
      cat('Notion that the calculation:\n')
      cat('   r = t / sqrt(t * t + df_Error)\n')

      t_to_r(t = t, df_error = df) %>% as.matrix()
    }else{
      print('Please define the correct Type')
    }
  }

}
