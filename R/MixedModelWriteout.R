MixedModelWriteout = function(Model = NULL, Data = NULL, Prefix = 'DV'){
  if(!require(export)) {devtools::install_github("tomwenseleers/export")}
  if(!is.null(Data)){
    for(dd in 1:length(Data)){
      export::table2office(x = Data[[dd]], file = paste0(Prefix,'_Description.doc'),
                           type = 'DOC',digits = 3,font = 'Times',
                           append = T)
    }

    #write.csv(Dataout, paste0(Prefix,'_Description.csv'))
  }

  if(!is.null(Model)){
    for(mm in 1:length(Model)){
      Modelinfo = summary(Model[[mm]])$coef %>%
        round(x = ., digits = 3) %>%
        as.data.frame()
      export::table2office(x = Modelinfo,
                           file = paste0(Prefix,'_Modelinfo.doc'),
                           type = 'DOC',digits = 3,font = 'Times',
                           append = T)

      qqp = ggplot(as_tibble(residuals(Model[[mm]])), aes(sample = value))+
        stat_qq(alpha = 0.2) + stat_qq_line()+
        labs(title = 'QQPlot of the residual')+
        theme(plot.title = element_text(hjust = 0.5))
      denp = qplot(x = residuals(Model[[mm]]), geom = 'density',
                   xlab = 'residuals', ylab = 'prop. density')+
        labs(title = 'Propability density of residuals')+
        theme(plot.title = element_text(hjust = 0.5))
      if(!require(patchwork)) {devtools::install_github("thomasp85/patchwork")}
      library(patchwork)
      ps = qqp|denp
      #ggsave(filename = paste0(Prefix,'_Residual information plot.png'),plot = ps,device = 'png',
      #       units = 'cm',width = 20,height = 10)
      export::graph2office(x = ps,file = paste0(Prefix,'_Residual information plot.ppt'),type = 'PPT')
    }

  }
}
