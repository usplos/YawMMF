PCOR = function(X,Y,...){
  COV = list(...)
  df = cbind(X,Y)
  for(ii in 1:length(COV)) df = cbind(df, COV[[ii]])
  df = as.data.frame(df)
  names(df) = c('X','Y',paste0('Z',1:(ncol(df)-2)))
  formula1 = paste0('X~',paste0(names(df)[3:ncol(df)],collapse = '+'))
  formula2 = paste0('Y~',paste0(names(df)[3:ncol(df)],collapse = '+'))
  Xe = residuals(lm(data = df, as.formula(formula1)))
  Ye = residuals(lm(data = df, as.formula(formula2)))
  cor.test(Xe,Ye)
}
