contr.simple = function(n){
  

  if(n == 2){
    return(contr.sum(2)/2*(-1))
  }else{
    firstline = matrix(-1/n, nrow = 1, ncol = n-1)
    restlines = matrix(0, nrow = n-1, ncol = n-1)
    restlines[upper.tri(restlines)] = -1/n
    restlines[lower.tri(restlines)] = -1/n
    restlines[row(restlines)==col(restlines)] = 1-1/n
    return(rbind(firstline, restlines))
  }
}

contr.simpleStd = function(n){
 
cat('please cite: \n')
cat('Zhang, G., Li, X., & Lin, N. (2020). YawMMF: Effective Mixed Model Functions. Available at: https://github.com/usplos/YawMMF.\n')

  X2 = matrix(0,nrow = n-1,ncol = n-1)
  X2[lower.tri(X2)] = -1/sqrt(n-1)
  X2[upper.tri(X2)] = -1/sqrt(n-1)
  diag(X2) = sqrt(n-1)
  rbind(-1/sqrt(n-1) %>% rep(n-1),X2)
}
