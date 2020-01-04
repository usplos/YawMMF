MixedModelPlot = function(Object = NULL,Data = NULL, DV, SE = NULL, Pred, Modx = NULL, Mod2 = NULL,
                          Geom = 'bar',
                          Barwidth = 0.5, Fill=NULL,DodgeWidth = 0.5,
                          Color = NULL,
                          ErrorBarWidth = 0.2, ErrorBarColor = 'black',
                          ViolinWidth = 0.5, BoxWidth = 0.1, ViolindataBandWidth = 0.5, ViolindataAlpha = 0.5,
                          Xlab = NULL, Ylab = NULL, Title = NULL, Legend = NULL,
                          Edit = F, Fun = T){
  if(!isTRUE(Fun)){
    if(is.null(Object)){
      if(Geom == 'bar'){
        p = eval(parse(text = paste0('ggplot(data = Data, aes(x = ',Pred,', y = ',DV,
                                     ifelse(!is.null(Modx),
                                            paste0(', fill = ',Modx,'))'),
                                            '))'))))
        p = eval(parse(text = paste0('p + geom_bar(stat = \'identity\',',
                                     'width = Barwidth, position = position_dodge(DodgeWidth))')))
        p = eval(parse(text = paste0('p + geom_errorbar(aes(x = ',Pred,
                                     ', ymax = ',DV,' + ', ifelse(!is.null(SE),
                                                                  SE,names(Data)[[length(names(Data))]]),
                                     ', ymin = ',DV,' - ', ifelse(!is.null(SE),
                                                                  SE,names(Data)[[length(names(Data))]]),
                                     '), ,width = ErrorBarWidth, position = position_dodge(DodgeWidth), ',
                                     'color = \'',ErrorBarColor,'\')')))
        if(!is.null(Mod2)){
          p = eval(parse(text = paste0('p + facet_grid(~',Mod2,')')))
        }
        if(!is.null(Fill)){
          Fill = Fill %>% gsub(pattern = ' ',replacement = '',x = .) %>%
            strsplit(x = ., split = ',',fixed = T) %>% unlist()
          p = p + scale_fill_manual(values = Fill)
        }

        p = p + labs(x = ifelse(!is.null(Xlab),
                                Xlab, Pred),
                     y = ifelse(!is.null(Ylab),
                                Ylab, DV),
                     title = ifelse(!is.null(Title),
                                    Title, ''))
        if(!is.null(Title)){
          p = p + theme(plot.title = element_text(hjust = 0.5))
        }
        if(!is.null(Modx)){
          p = p + labs(fill = ifelse(!is.null(Legend),
                                     Legend,Modx))
        }
      }else if(Geom == 'line'){
        p = eval(parse(text = paste0('ggplot(data = Data, aes(x = ',Pred,', y = ',DV,ifelse(!is.null(Modx),
                                                                                            paste0(',color = ',Modx,'))'),
                                                                                            '))'))))
        p = eval(parse(text = paste0('p + geom_point(',
                                     'position = position_dodge(DodgeWidth))')))
        p = eval(parse(text = paste0('p + geom_errorbar(aes(x = ',Pred,
                                     ', ymax = ',DV,' + ', ifelse(!is.null(SE),
                                                                  SE,names(Data)[[length(names(Data))]]),
                                     ', ymin = ',DV,' - ', ifelse(!is.null(SE),
                                                                  SE,names(Data)[[length(names(Data))]]),
                                     '), ,width = ErrorBarWidth, position = position_dodge(DodgeWidth)',
                                     ')')))
        p = eval(parse(text = paste0('p + geom_line(aes(group = ',Modx,'), position = position_dodge(DodgeWidth))')))
        if(!is.null(Mod2)){
          p = eval(parse(text = paste0('p + facet_grid(~',Mod2,')')))
        }
        if(!is.null(Color)){
          Color = Color %>% gsub(pattern = ' ',replacement = '',x = .) %>%
            strsplit(x = ., split = ',',fixed = T) %>% unlist()
          p = p + scale_color_manual(values = Color)
        }

        p = p + labs(x = ifelse(!is.null(Xlab),
                                Xlab, Pred),
                     y = ifelse(!is.null(Ylab),
                                Ylab, DV),
                     title = ifelse(!is.null(Title),
                                    Title, ''))
        if(!is.null(Title)){
          p = p + theme(plot.title = element_text(hjust = 0.5))
        }
        if(!is.null(Modx)){
          p = p + labs(color = ifelse(!is.null(Legend),
                                      Legend,Modx))
        }
      }else if(Geom == 'violin1'){
        p = eval(parse(text = paste0('ggplot(data = Data, aes(x = ',Pred,', y = ',DV,
                                     ifelse(!is.null(Modx),
                                            paste0(', fill = ',Modx,'))'),
                                            '))'))))
        p = eval(parse(text = paste0('p + geom_violin(trim = F,position = position_dodge(DodgeWidth), width = ViolinWidth)')))
        p = eval(parse(text = paste0('p + geom_boxplot(width = BoxWidth, position = position_dodge(DodgeWidth))')))

        if(!is.null(Mod2)){
          p = eval(parse(text = paste0('p + facet_grid(~',Mod2,')')))
        }
        if(!is.null(Fill)){
          Fill = Fill %>% gsub(pattern = ' ',replacement = '',x = .) %>%
            strsplit(x = ., split = ',',fixed = T) %>% unlist()
          p = p + scale_fill_manual(values = Fill)
        }

        p = p + labs(x = ifelse(!is.null(Xlab),
                                Xlab, Pred),
                     y = ifelse(!is.null(Ylab),
                                Ylab, DV),
                     title = ifelse(!is.null(Title),
                                    Title, ''))
        if(!is.null(Title)){
          p = p + theme(plot.title = element_text(hjust = 0.5))
        }
        if(!is.null(Modx)){
          p = p + labs(fill = ifelse(!is.null(Legend),
                                     Legend,Modx))
        }
      }else if(Geom == 'violin2'){
        p = eval(parse(text = paste0('ggplot(data = Data, aes(x = ',Pred,', y = ',DV,
                                     ifelse(!is.null(Modx),
                                            paste0(', fill = ',Modx,''),
                                            ''),
                                     ifelse(!is.null(Modx),
                                            paste0(', color = ',Modx,'))'),
                                            '))'))))
        p = eval(parse(text = paste0('p + geom_violin(trim = F,alpha = 0.2, position = position_dodge(DodgeWidth), width = ViolinWidth)')))
        p = p + geom_quasirandom(dodge.width = DodgeWidth, bandwidth = ViolindataBandWidth, alpha = ViolindataAlpha)

        if(!is.null(Mod2)){
          p = eval(parse(text = paste0('p + facet_grid(~',Mod2,')')))
        }
        if(!is.null(Fill)){
          Fill = Fill %>% gsub(pattern = ' ',replacement = '',x = .) %>%
            strsplit(x = ., split = ',',fixed = T) %>% unlist()
          p = p + scale_fill_manual(values = Fill)
        }
        if(!is.null(Color)){
          Color = Color %>% gsub(pattern = ' ',replacement = '',x = .) %>%
            strsplit(x = ., split = ',',fixed = T) %>% unlist()
          p = p + scale_color_manual(values = Color)
        }
        p = p + labs(x = ifelse(!is.null(Xlab),
                                Xlab, Pred),
                     y = ifelse(!is.null(Ylab),
                                Ylab, DV),
                     title = ifelse(!is.null(Title),
                                    Title, ''))
        if(!is.null(Title)){
          p = p + theme(plot.title = element_text(hjust = 0.5))
        }
        if(!is.null(Modx)){
          p = p + labs(fill = ifelse(!is.null(Legend),
                                     Legend,Modx),
                       color = ifelse(!is.null(Legend),
                                      Legend,Modx))
        }
      }
    }else{
      p = Object
    }

    if(isTRUE(Edit)){
      return(ggedit(p))
    }else{
      return(p)
    }
  }
  if(isTRUE(Fun)){
    cat('Do you agree that data visualization in R is much better than that in Excel? \n(please input 1 or 0)\n',
        '1: Yes I agree\n','0: No, I dont\n');p = scan(nmax = 1)
    if(p == 1){
      cat('Then this function may help you perform data visualization better\n')
      if(is.null(Object)){
        if(Geom == 'bar'){
          p = eval(parse(text = paste0('ggplot(data = Data, aes(x = ',Pred,', y = ',DV,
                                       ifelse(!is.null(Modx),
                                              paste0(', fill = ',Modx,'))'),
                                              '))'))))
          p = eval(parse(text = paste0('p + geom_bar(stat = \'identity\',',
                                       'width = Barwidth, position = position_dodge(DodgeWidth))')))
          p = eval(parse(text = paste0('p + geom_errorbar(aes(x = ',Pred,
                                       ', ymax = ',DV,' + ', ifelse(!is.null(SE),
                                                                    SE,names(Data)[[length(names(Data))]]),
                                       ', ymin = ',DV,' - ', ifelse(!is.null(SE),
                                                                    SE,names(Data)[[length(names(Data))]]),
                                       '), ,width = ErrorBarWidth, position = position_dodge(DodgeWidth), ',
                                       'color = \'',ErrorBarColor,'\')')))
          if(!is.null(Mod2)){
            p = eval(parse(text = paste0('p + facet_grid(~',Mod2,')')))
          }
          if(!is.null(Fill)){
            Fill = Fill %>% gsub(pattern = ' ',replacement = '',x = .) %>%
              strsplit(x = ., split = ',',fixed = T) %>% unlist()
            p = p + scale_fill_manual(values = Fill)
          }

          p = p + labs(x = ifelse(!is.null(Xlab),
                                  Xlab, Pred),
                       y = ifelse(!is.null(Ylab),
                                  Ylab, DV),
                       title = ifelse(!is.null(Title),
                                      Title, ''))
          if(!is.null(Title)){
            p = p + theme(plot.title = element_text(hjust = 0.5))
          }
          if(!is.null(Modx)){
            p = p + labs(fill = ifelse(!is.null(Legend),
                                       Legend,Modx))
          }
        }else if(Geom == 'line'){
          p = eval(parse(text = paste0('ggplot(data = Data, aes(x = ',Pred,', y = ',DV,ifelse(!is.null(Modx),
                                                                                              paste0(',color = ',Modx,'))'),
                                                                                              '))'))))
          p = eval(parse(text = paste0('p + geom_point(',
                                       'position = position_dodge(DodgeWidth))')))
          p = eval(parse(text = paste0('p + geom_errorbar(aes(x = ',Pred,
                                       ', ymax = ',DV,' + ', ifelse(!is.null(SE),
                                                                    SE,names(Data)[[length(names(Data))]]),
                                       ', ymin = ',DV,' - ', ifelse(!is.null(SE),
                                                                    SE,names(Data)[[length(names(Data))]]),
                                       '), ,width = ErrorBarWidth, position = position_dodge(DodgeWidth)',
                                       ')')))
          p = eval(parse(text = paste0('p + geom_line(aes(group = ',Modx,'), position = position_dodge(DodgeWidth))')))
          if(!is.null(Mod2)){
            p = eval(parse(text = paste0('p + facet_grid(~',Mod2,')')))
          }
          if(!is.null(Color)){
            Color = Color %>% gsub(pattern = ' ',replacement = '',x = .) %>%
              strsplit(x = ., split = ',',fixed = T) %>% unlist()
            p = p + scale_color_manual(values = Color)
          }

          p = p + labs(x = ifelse(!is.null(Xlab),
                                  Xlab, Pred),
                       y = ifelse(!is.null(Ylab),
                                  Ylab, DV),
                       title = ifelse(!is.null(Title),
                                      Title, ''))
          if(!is.null(Title)){
            p = p + theme(plot.title = element_text(hjust = 0.5))
          }
          if(!is.null(Modx)){
            p = p + labs(color = ifelse(!is.null(Legend),
                                        Legend,Modx))
          }
        }else if(Geom == 'violin1'){
          p = eval(parse(text = paste0('ggplot(data = Data, aes(x = ',Pred,', y = ',DV,
                                       ifelse(!is.null(Modx),
                                              paste0(', fill = ',Modx,'))'),
                                              '))'))))
          p = eval(parse(text = paste0('p + geom_violin(position = position_dodge(DodgeWidth), width = ViolinWidth)')))
          p = eval(parse(text = paste0('p + geom_boxplot(width = BoxWidth, position = position_dodge(DodgeWidth))')))

          if(!is.null(Mod2)){
            p = eval(parse(text = paste0('p + facet_grid(~',Mod2,')')))
          }
          if(!is.null(Fill)){
            Fill = Fill %>% gsub(pattern = ' ',replacement = '',x = .) %>%
              strsplit(x = ., split = ',',fixed = T) %>% unlist()
            p = p + scale_fill_manual(values = Fill)
          }

          p = p + labs(x = ifelse(!is.null(Xlab),
                                  Xlab, Pred),
                       y = ifelse(!is.null(Ylab),
                                  Ylab, DV),
                       title = ifelse(!is.null(Title),
                                      Title, ''))
          if(!is.null(Title)){
            p = p + theme(plot.title = element_text(hjust = 0.5))
          }
          if(!is.null(Modx)){
            p = p + labs(fill = ifelse(!is.null(Legend),
                                       Legend,Modx))
          }
        }else if(Geom == 'violin2'){
          p = eval(parse(text = paste0('ggplot(data = Data, aes(x = ',Pred,', y = ',DV,
                                       ifelse(!is.null(Modx),
                                              paste0(', fill = ',Modx,''),
                                              ''),
                                       ifelse(!is.null(Modx),
                                              paste0(', color = ',Modx,'))'),
                                              '))'))))
          p = eval(parse(text = paste0('p + geom_violin(alpha = 0.2, position = position_dodge(DodgeWidth), width = ViolinWidth)')))
          p = p + geom_quasirandom(dodge.width = DodgeWidth, bandwidth = ViolindataBandWidth, alpha = ViolindataAlpha)

          if(!is.null(Mod2)){
            p = eval(parse(text = paste0('p + facet_grid(~',Mod2,')')))
          }
          if(!is.null(Fill)){
            Fill = Fill %>% gsub(pattern = ' ',replacement = '',x = .) %>%
              strsplit(x = ., split = ',',fixed = T) %>% unlist()
            p = p + scale_fill_manual(values = Fill)
          }
          if(!is.null(Color)){
            Color = Color %>% gsub(pattern = ' ',replacement = '',x = .) %>%
              strsplit(x = ., split = ',',fixed = T) %>% unlist()
            p = p + scale_color_manual(values = Color)
          }
          p = p + labs(x = ifelse(!is.null(Xlab),
                                  Xlab, Pred),
                       y = ifelse(!is.null(Ylab),
                                  Ylab, DV),
                       title = ifelse(!is.null(Title),
                                      Title, ''))
          if(!is.null(Title)){
            p = p + theme(plot.title = element_text(hjust = 0.5))
          }
          if(!is.null(Modx)){
            p = p + labs(fill = ifelse(!is.null(Legend),
                                       Legend,Modx),
                         color = ifelse(!is.null(Legend),
                                        Legend,Modx))
          }
        }
      }else{
        p = Object
      }

      if(isTRUE(Edit)){
        return(ggedit(p))
      }else{
        return(p)
      }
    }else{
      cat('Then there is no need to use this function.\nUse your excel')
    }
  }
}
