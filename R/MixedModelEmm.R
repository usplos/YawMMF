MixedModelEmm = function(Model, Specify, By = NULL, Contrast = 'pairwise', Adjust = NULL){
  Command = paste0('emmeans(Model, ',Contrast,' ~ ',Specify,
                   ifelse(is.null(By),'', paste0(' | ',By)),
                   ifelse(is.null(Adjust),')',
                          paste0(', adjust = \'',  Adjust,'\')')))
  EmmList = list()
  EmmList[[1]] = eval(parse(text = Command))

  return(EmmList)
}
