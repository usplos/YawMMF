NORM_CLUST = function(N, pvalue = 0.05){
  if(!require(mclust)) install.packages('mclust')
  library(mclust)
  p = 0
  start = 1
  DFs = tibble()
  DF = tibble(N)
  DF['label'] = 1:length(N)
  DF['C'] = 0
  NROW = nrow(DF)
  while (NROW >= 10) {
    G = 1
    p = 0
    while (p < pvalue) {
      Model = Mclust(DF$N, G = G)
      p = shapiro.test(DF$N[Model$classification == 1])$p.value
      G = G+1
    }

    DF$C[Model$classification == 1] = start
    DFs = rbind(DFs, DF %>% filter(C != 0))
    DF = DF %>% filter(C == 0)
    NROW = nrow(DF)
    start = start+1
  }
  if(nrow(DF) > 0){
    DF$C = start
    DFs = rbind(DFs, DF)
  }
  return(DFs %>% arrange(label) %>% .$C)
}

