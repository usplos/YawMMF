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

seq_evermax = function(x){
  Log = logical(length = length(x))
  Log[1] = T
  if(length(x) > 1){
    for (ii in 2:length(x)) {
      Log[ii] = ifelse(x[ii] > max(x[1:(ii-1)]), T, F)
    }
  }
  return(Log)
}

p.sig = function(p, numcontrasts = 1){
  ifelse(p > .05/numcontrasts,'',
         ifelse(p > .01/numcontrasts,'*',
                ifelse(p > .001/numcontrasts,'**','***')))
}
