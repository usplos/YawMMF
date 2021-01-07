CorrPlot = function(Data,
                    Cols,
                    Rows,
                    Xlab = NULL, Ylab = NULL,
                    Edit = F){
  cat('please cite: \n')
cat('Zhang, G., Li, X., & Lin, N. (2020). YawMMF: Effective Mixed Model Functions. Available at: https://github.com/usplos/YawMMF.\n')
  Cols = Cols %>% gsub(pattern = ' ',replacement = '', x = .) %>%
    strsplit(x = ., split = ',', fixed = T) %>% unlist()
  Rows = Rows %>% gsub(pattern = ' ',replacement = '', x = .) %>%
    strsplit(x = ., split = ',', fixed = T) %>% unlist()
  DF = tibble()
  for(rr in 1:length(Rows)){
    for(cc in 1:length(Cols)){
      DF0 = Data[c(Rows[rr],Cols[cc])] %>% mutate(Row = Rows[rr], Col = Cols[cc])
      names(DF0)[1:2] = c('Rowvalue','Colvalue')

      DF = rbind(DF, DF0)
    }
  }
  DF$Row = factor(DF$Row, levels = Rows)
  DF$Col = factor(DF$Col, levels = Cols)
  p = ggplot(data = DF, aes(x = Rowvalue, y = Colvalue))+
    geom_point(color = gray(0.6))+
    geom_smooth(method = 'lm', color = 'black')+
    facet_grid(Col~Row)+
    labs(x = ifelse(is.null(Xlab),'',Xlab),
         y = ifelse(is.null(Ylab),'',Ylab))
  if(isTRUE(Edit)){
    return(ggedit(p))
  }else{
    return(p)
  }
}
