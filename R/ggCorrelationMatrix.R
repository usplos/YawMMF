ggCorrelationMatrix = function(data, Arrange = 'full',
                               color_low = 'dodgerblue4', color_mid = 'white',color_high = 'red',midpoint = 0,
                               gridgap = 0,
                               x_lab = NULL, y_lab = NULL, x_title = '', y_title = '', legend_title = 'Correlations',
                               value_labeled = F){
  library(ggplot2)
  library(dplyr)
  library(tibble)
  
  if(is.null(x_lab)){
    if(Arrange == 'full') x_lab = colnames(data)
    if(Arrange == 'leftlow') x_lab = colnames(data)[-length(colnames(data))]
    if(Arrange == 'leftup') x_lab = colnames(data)[-1]
  } 
  
  if(is.null(y_lab)){
    if(Arrange == 'full') y_lab = rownames(data)
    if(Arrange == 'leftlow') y_lab = rownames(data)[-1]
    if(Arrange == 'leftup') y_lab = rownames(data)[-length(colnames(data))]
  } 
    
  dfp = tibble()
  Rname = rownames(data)
  Cname = colnames(data)
  
  if(Arrange == 'full'){
    for(x in 1:length(Cname)){
      for(y in 1:length(Rname)){
        if(x != y){
          x_p = x
          y_p = length(Rname)-y+1
          dfp = bind_rows(dfp,
                          tibble(x_p, y_p, value = data[x,y]))
        }
      }
    }
  }
  
  if(Arrange == 'leftlow'){
    for(x in 1:(length(Cname)-1)){
      for(y in (x+1):length(Rname)){
        if(x != y){
          x_p = x
          y_p = length(Rname)-y+1
          dfp = bind_rows(dfp,
                          tibble(x_p, y_p, value = data[x,y]))
        }
      }
    }
  }
  
  if(Arrange == 'leftup'){
    for(x in 2:length(Cname)){
      for(y in 1:(x-1)){
        if(x != y){
          x_p = x
          y_p = length(Rname)-y
          dfp = bind_rows(dfp,
                          tibble(x_p, y_p, value = data[x,y]))
        }
      }
    }
  }
  
  p = ggplot(data = dfp, aes(x = x_p, y = y_p))+
    geom_rect(aes(fill = value,xmin = x_p - (.5 - gridgap/2), xmax = x_p + (.5 - gridgap/2), ymin = y_p-(.5 - gridgap/2), ymax = y_p+(.5 - gridgap/2)))+
    scale_fill_gradient2(low = 'blue',mid = 'white',high = 'red',midpoint = 0)+
    theme_minimal()+
    theme(panel.grid = element_blank())+
    scale_x_continuous(breaks = unique(dfp$x_p) %>% sort(),labels = x_lab)+
    scale_y_continuous(breaks = unique(dfp$y_p) %>% sort(), labels = y_lab[length(y_lab):1])+
    labs(x = x_title,
         y = y_title,
         fill = legend_title)+
    theme(axis.title = element_text(size=14, face = 'bold'),
          axis.text.y = element_text(size=12, face = 'bold'),
          axis.text.x = element_text(size=12, face = 'bold',angle = 45,vjust = 0.9))
  if(isTRUE(value_labeled)){
    p = p + geom_text(data = dfp %>% mutate(value2 = round(value,3) %>% as.character(),
                                            value_label = ifelse(value > 0, 
                                                                 substr(value2,2,5),
                                                                 paste0('-',substr(value2,3,6)))),
                      aes(x = x_p, y = y_p, label = value_label))
  }
  return(p)
}



# ggCorrelationMatrix(data = cor(USJudgeRatings),Arrange = 'full',
#                     color_low = 'dodgerblue',
#                     color_mid = 'white',color_high = 'red',midpoint = 0,
#                     x_lab = NULL,y_lab = NULL,
#                     x_title = '',y_title = '',legend_title = 'Correlation',
#                     gridgap = 0.05, value_labeled = T)
