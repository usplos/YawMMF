StrInsertSpace = function(X){
  xs = c()
  for (ii in X) {
    X1 = unlist(strsplit(ii,split = '',fixed = T))
    xs = c(xs,paste0(as.vector(matrix(c(X1,rep(' ',times = length(X1))), byrow = T,nrow = 2)),
                     collapse = ''))
  }
  xs
}

StrDeletePosition = function(X,position){
  X %>% strsplit(x = .,split = '',fixed = T) %>% unlist() %>%
    .[-c(position)] %>% paste0(collapse = '')
}

StrSubPosition = function(X,position){
  X %>% strsplit(x = .,split = '',fixed = T) %>% unlist() %>%
    .[c(position)] %>% paste0(collapse = '')
}

StrUniqueChar = function(X){
  X %>% strsplit(x = .,split = '',fixed = T) %>% unlist() %>% unique() %>% length()
}
