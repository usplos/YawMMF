MixedModelWrite = function(Model = NULL, Data = NULL, Prefix = 'DV',...){
  
cat('please cite: \n')
cat('Zhang, G., Li, X., & Lin, N. (2020). YawMMF: Effective Mixed Model Functions. Available at: https://github.com/usplos/YawMMF.\n')

  if(!is.null(Data)){
    Datas = list(...)
    Dataout = MixedModelDataSummary(Data = Data, DV = Datas$DV, Cond = Datas$Cond, Group = Datas$Group)
    write.csv(Dataout, paste0(Prefix,'_Description.csv'))
  }

  if(!is.null(Model)){
    Modelinfo = summary(Model)$coef %>% round(x = ., digits = 3) %>% as.data.frame()
    write.csv(Modelinfo, paste0(Prefix, '_Modelinfo.csv'))

    qqp = ggplot(as_tibble(residuals(Model)), aes(sample = value))+
      stat_qq(alpha = 0.2) + stat_qq_line()+
      labs(title = 'QQPlot of the residual')+
      theme(plot.title = element_text(hjust = 0.5))
    denp = qplot(x = residuals(Model), geom = 'density',xlab = 'residuals', ylab = 'prop. density')+
      labs(title = 'Propability density of residuals')+
      theme(plot.title = element_text(hjust = 0.5))
    if(!require(patchwork)) {devtools::install_github("thomasp85/patchwork")}
    library(patchwork)
    ps = qqp|denp
    ggsave(filename = paste0(Prefix,'_Residual information plot.tiff'),plot = ps,device = 'tiff',
           units = 'cm',width = 20,height = 10)
  }
}
