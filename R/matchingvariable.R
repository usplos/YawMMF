matchingvariable = function(y, by){
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

  largestsamplesize = ifequal %>% filter(t < 1) %>% arrange(-samplesize) %>% .[[1]] %>% .[[1]]

  full_join(tibbleyAll,
            bind_rows(y1[1:largestsamplesize,],
                      y2[1:largestsamplesize,])) %>% arrange(seq) %>%
    mutate(label = ifelse(is.na(distance), 0,1)) %>% .[['label']]
}
