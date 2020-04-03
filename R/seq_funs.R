seq_space = function(x, Ordered = F, Decrease = F){
  if(isTRUE(Ordered)) x = sort(x, decreasing = Decrease)
  space = numeric(length = length(x)-1)
  for(ii in 2:length(x)){
    space[ii-1] = x[ii]-x[ii-1]
  }
  return(space)
}

seq_reverse = function(x){
  return(tibble(x, seq = 1:length(x)) %>% arrange(-seq) %>% .[[1]])
}

