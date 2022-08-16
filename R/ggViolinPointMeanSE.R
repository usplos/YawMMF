ggViolinPointMeanSE = function(data, cond, Y, Group = NULL, Levels = NULL, Labels = NULL, 
                               colors = c('#aa001a','#d35219','dodgerblue4','dodgerblue3')){
  library(ggplot2)
  library(dplyr)
  
  names(data)[which(names(data) == cond)] = 'cond'
  names(data)[which(names(data) == Y)] = 'Y'
  if(is.null(Levels)){
    data$cond = factor(data$cond)
  }else{
    if(is.null(Labels)){
      data$cond = factor(data$cond, levels = Levels)
    }else{
      data$cond = factor(data$cond, levels = Levels, labels = Labels)
    }
  }
  
  if(is.null(Labels)) Labels = levels(data$cond)
  
  if(is.null(Group)){
    dfp = data %>% 
      rename(Ms = Y)
  }else{
    names(data)[which(names(data) == Group)] = 'Group'
    dfp = data %>%
      group_by(Group,cond) %>%
      summarise(Ms = mean(Y))
    
  }
  dfp2 = dfp %>% group_by(cond) %>% 
    summarise(M = mean(Ms),
              SE = sd(Ms)/sqrt(length(Ms)),
              X = (as.numeric(cond)+1)/2)
  
  p = ggplot(data = dfp2,
             aes(y = M,color = factor(cond), fill = factor(cond)))+
    geom_errorbar(aes(ymax = M+SE, ymin = M-SE,x=X+.05),
                  position = position_dodge(0.2), width = .05, show.legend = F)+
    theme_classic()+
    geom_point(aes(x=X+.05),size=1, shape=15,show.legend = F)+
    geom_violin(data = dfp %>%
                  mutate(X = (as.numeric(cond)+1)/2),
                aes(x = X-.1, y = Ms,fill = factor(cond)),color=NA,size=1, alpha=.3,show.legend = F,
                adjust=1.5, trim = F, width=.2)+
    geom_point(data = dfp %>%
                 mutate(X = (as.numeric(cond)+1)/2),
               aes(x = X-.1, y = Ms,color = factor(cond)),size=1, alpha=.3,show.legend = F,
               position = position_beeswarm())+
    labs(y = Y,x='')+
    scale_x_continuous(breaks = unique(dfp2$X),
                       labels = Labels)+
    theme(axis.text.x = element_text(face = 'bold',size=10),
          axis.line.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.title.y = element_text(size=12,face = 'bold'),
          axis.text.y = element_text(face = 'bold'))
  if(length(colors) >= length(Labels)){
    p = p+
      scale_color_manual(values = colors[1:length(Labels)])+
      scale_fill_manual(values = colors[1:length(Labels)])
  }else{
    cat("\n\n## ## ## ## ## ## ## ## ## ## \n",
        "Since the number of colors that your set is less than that of levels of your condition, the function will use the default color palette of ggplot2.",
        '\n## ## ## ## ## ## ## ## ## ## \n\n')
  }
  return(p)
}

#ggViolinPointMeanSE(data = DemoData %>% mutate(Cond = paste(CondA, CondB,sep = '')),
#                    cond = 'Cond',
#                    Y = 'DV',
#                    Group = 'subj',
#                    Levels = c('A1B1','A2B1','A1B2','A2B2'),
#                    Labels = c('Condition1','Condition2','Condition3','Condition4'),
#                    colors = c('#aa001a','#d35219','dodgerblue4','dodgerblue3'))









