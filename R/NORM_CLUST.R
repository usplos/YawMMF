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
  BREAK = F
  while (NROW >= 10) {
    G = 1;p = 0;while (p < pvalue) {
      Model = Mclust(DF$N, G = G)
      if(is.null(Model)){
        BREAK = T;break
      }
      CLASS = table(Model$classification)[table(Model$classification) > 3]
      ps = numeric(length = length(CLASS))
      for(cc in 1:length(CLASS)){
        ps[cc] = ifelse(length(unique(DF$N[Model$classification == as.numeric(names(CLASS))[cc]])) == 1,
                        0,shapiro.test(DF$N[Model$classification == as.numeric(names(CLASS))[cc]])$p.value)
      }
      p = ps[which(ps == max(ps))]
      Class = names(CLASS)[which(ps == max(ps))]
      G = G+1

      if(G >= length(unique(DF$N))){
        BREAK = T;break
      }
    }
    if(isTRUE(BREAK)){
      DF$C = -1
      DFs = rbind(DFs, DF %>% filter(C != 0))
      DF = DF %>% filter(C == 0)
      NROW = nrow(DF)
    }else{
      DF$C[Model$classification == Class] = start
      DFs = rbind(DFs, DF %>% filter(C != 0))
      DF = DF %>% filter(C == 0)
      NROW = nrow(DF)
      start = start+1
    }
  }
  if(nrow(DF) > 0){
    DF$C = start
    DFs = rbind(DFs, DF)
  }
  return(DFs %>% arrange(label) %>% .$C)
}
