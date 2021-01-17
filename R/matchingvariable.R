# 函数名为matchingvariable()，
# 功能是对给定的两组观测值，
# 从两组观测值中抽取相同数量的样本，
# 找到可以使两组样本差异不显著(t < 1)时的最大样本量
# 函数共两个参数，y为总体观测值，by为两组组别的标记
# 函数将返回一组1-0形式的向量，1表示对应位置的观测值符合要求，同理，0表示不符合要求

matchingvariable = function(y, by, type = 't', threshold = 1){
  

  tibbleyAll = tibble(y, by, seq = 1:length(y))
  AverageAll = mean(y)
  uniqueby = unique(by)
  y1 = tibbleyAll %>% filter(by == uniqueby[1])
  y2 = tibbleyAll %>% filter(by == uniqueby[2])
  y1 = y1 %>% mutate(distance = y - AverageAll,
                     absdistance = abs(distance),
                     direction = ifelse(distance > 0,1,-1)) %>%
    arrange(absdistance) %>%
    group_by(direction) %>%
    mutate(order = 1:length(y)) %>%
    arrange(order, direction)
  y2 = y2 %>% mutate(distance = y - AverageAll,
                     absdistance = abs(distance),
                     direction = ifelse(distance > 0,1,-1)) %>%
    arrange(absdistance) %>%
    group_by(direction) %>%
    mutate(order = 1:length(y)) %>%
    arrange(order, direction)

  ifequal = tibble()
  for(rr in 2:min(c(nrow(y1), nrow(y2)))){
    samplesize = rr
    fit = t.test(y1$y[1:rr],y2$y[1:rr])
    t = fit$statistic %>% abs()
    p = fit$p.value
    ifequal = bind_rows(ifequal,tibble(samplesize, t, p))
  }

  if(type == 't'){
    largestsamplesize = ifequal %>% filter(t < threshold) %>% arrange(-samplesize) %>% .[[1]] %>% .[[1]]
  }else if(type == 'p'){
    largestsamplesize = ifequal %>% filter(p > threshold) %>% arrange(-samplesize) %>% .[[1]] %>% .[[1]]
  }else{
    print('selecting can only be performed via t value or p value. Please set correct \'type\'')  
  }
  

  full_join(tibbleyAll,
            bind_rows(y1[1:largestsamplesize,],
                      y2[1:largestsamplesize,])) %>% arrange(seq) %>%
    mutate(label = ifelse(is.na(distance), 0,1)) %>% .[['label']]
}

#rm(list = ls())
#set.seed(1234)
#y = rnorm(n = 200, mean = 0.5)
#value = 0
#type='t';
#threshold=1
matchingvalue = function(y, value, type='t', threshold=1){
  by = ifelse(y > value, 1, 0)
  
  tibbleyAll = tibble(y, by, seq = 1:length(y))
  AverageAll = mean(y)
  uniqueby = unique(by)
  y1 = tibbleyAll %>% filter(by == uniqueby[1])
  y2 = tibbleyAll %>% filter(by == uniqueby[2])
  y1 = y1 %>% mutate(distance = y - AverageAll,
                     absdistance = abs(distance),
                     direction = ifelse(distance > 0,1,-1)) %>%
    arrange(absdistance) %>%
    group_by(direction) %>%
    mutate(order = 1:length(y)) %>%
    arrange(order, direction)
  y2 = y2 %>% mutate(distance = y - AverageAll,
                     absdistance = abs(distance),
                     direction = ifelse(distance > 0,1,-1)) %>%
    arrange(absdistance) %>%
    group_by(direction) %>%
    mutate(order = 1:length(y)) %>%
    arrange(order, direction)
  
  ifequal = tibble()
  for(rr in 2:min(c(nrow(y1), nrow(y2)))){
    samplesize = rr
    fit = t.test(c(y1$y[1:rr],y2$y[1:rr]),mu = value)
    t = fit$statistic %>% abs()
    p = fit$p.value
    ifequal = bind_rows(ifequal,tibble(samplesize, t, p))
  }
  
  if(type == 't'){
    largestsamplesize = ifequal %>% filter(t < threshold) %>% arrange(-samplesize) %>% .[[1]] %>% .[[1]]
  }else if(type == 'p'){
    largestsamplesize = ifequal %>% filter(p > threshold) %>% arrange(-samplesize) %>% .[[1]] %>% .[[1]]
  }else{
    print('selecting can only be performed via t value or p value. Please set correct \'type\'')  
  }
  
  
  full_join(tibbleyAll,
            bind_rows(y1[1:largestsamplesize,],
                      y2[1:largestsamplesize,])) %>% arrange(seq) %>%
    mutate(label = ifelse(is.na(distance), 0,1)) %>% .[['label']]
}

matchingvariablegeneralized = function(y, by, type = 'F', threshold = 1){
  cond = by
  by=c()
  for(ii in 1:length(cond)){
    by = cbind(by, cond[[ii]])
  }
  bydf = by %>% as_tibble()
  names(bydf) = paste0('V',1:ncol(bydf))
  CondUnq = character(length = nrow(bydf))
  for(rr in 1:nrow(bydf)){
    CondUnq[rr] = paste(bydf[rr,],collapse = '_')
  }
  bydf['CondUnq'] = CondUnq
  
  tibbleyAll = bind_cols(tibble(y), bydf, tibble(seq = 1:length(y)))
  AverageAll = mean(y)
  
  uniqueby = unique(by)
  ylist = list()
  for(ii in 1:length(unique(CondUnq))){
    ylist[[ii]] = tibbleyAll %>% filter(CondUnq == unique(CondUnq)[ii]) %>%
      mutate(distance = y - AverageAll,
             absdistance = abs(distance),
             direction = ifelse(distance > 0,1,-1)) %>%
      arrange(absdistance) %>%
      group_by(direction) %>%
      mutate(order = 1:length(y)) %>%
      arrange(order, direction)
  }
  
  
  ifequal = tibble()
  for(rr in 2:min(table(CondUnq))){
    samplesize = rr
    testdf = tibble()
    for(ii in 1:length(ylist)){
      testdf = bind_rows(tibble(ylist[[ii]] %>% .[1:rr,]),
                         testdf)
    }
    
    
    fit = lm(data = testdf, 
             as.formula(paste0('y~',
                               paste0(names(bydf) %>% .[-length(bydf)],collapse = '*')))) %>% anova()
    Fvalue = fit$`F value` %>% .[!is.na(.)]
    Fvalue = (sum(Fvalue < threshold) == length(Fvalue))*1
    p = fit$`Pr(>F)` %>% .[!is.na(.)]
    p = (sum(p > threshold) == length(p))*1
    ifequal = bind_rows(ifequal,tibble(samplesize, Fvalue, p))
  }
  
  if(type == 'F'){
    largestsamplesize = ifequal %>% filter(Fvalue == 1) %>% arrange(-samplesize) %>% .[[1]] %>% .[[1]]
  }else if(type == 'p'){
    largestsamplesize = ifequal %>% filter(p == 1) %>% arrange(-samplesize) %>% .[[1]] %>% .[[1]]
  }else{
    print('selecting can only be performed via t value or p value. Please set correct \'type\'')  
  }
  
  yselected = tibble()
  for(ii in 1:length(ylist)){
    yselected = bind_rows(yselected,
                          ylist[[ii]][1:largestsamplesize,])
  }
  
  full_join(tibbleyAll,
            yselected) %>% arrange(seq) %>%
    mutate(label = ifelse(is.na(distance), 0,1)) %>% .[['label']]
}


