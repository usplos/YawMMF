MixedModelWrite = function(Model = NULL, Data = NULL, Prefix = 'DV',...){
  if(!is.null(Data)){
    Datas = list(...)
    Dataout = MixedModelDataSummary(Data = Data, DV = Datas$DV, Cond = Datas$Cond, Group = Datas$Group)
    write.csv(Dataout, paste0(Prefix,'_Description.csv'))
  }

  if(!is.null(Model)){
    Modelinfo = summary(Model)$coef %>% round(x = ., digits = 3) %>% as.data.frame()
    write.csv(Modelinfo, paste0(Prefix, '_Modelinfo.csv'))
  }
}
