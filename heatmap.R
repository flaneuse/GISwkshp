drawHeatmap = function(df, y, 
                       asPct = FALSE,
                       colorPalette = brewer.pal(9, 'PuBu')){
  
  grey90K = "#414042"
  
  "%w/o%" <- function(x, y) x[!x %in% y]
  
  # y is a variable name within df
  vars = colnames(df) %w/o% c('grp', 'colour', y)
  
  freq2Plot = NULL
  
  for (variable in vars) {
    temp = table(df  %>% select_(variable, y))
    
    if(asPct == TRUE){
      temp = data.frame(prop.table(temp,2), categ = variable)
    } else{
      temp = data.frame(temp, categ = variable)
    }
    colnames(temp) = c('corr', 'gender', 'freq', 'categ')
    
    freq2Plot = rbind(freq2Plot, temp)
  }
  
  freq2Plot$corr = factor(freq2Plot$corr, 
                          levels = rev(levels(freq2Plot$corr)))
                          
  ggplot(freq2Plot, aes(x = gender, y = corr, fill = freq)) +
    geom_tile() +
    ggtitle(paste0('Correlations with ', y)) +
    scale_fill_gradientn(colours = c('white', colorPalette)) +
    facet_wrap(~ categ, scales = 'free_y', ncol = 1) +
    theme_bw() +
    theme(
      text = element_text(family = 'Segoe UI Light', colour = grey60K),
      rect = element_blank(),
      plot.background = element_blank(),
      axis.text = element_text(size = 10, color = grey60K),
      title =  element_text(size = 13.5, family = "Segoe UI", hjust = -0.75, color = colorPalette[7]),
      axis.title =  element_blank(),
      strip.text = element_text(size=12, family = "Segoe UI Semilight", hjust = 0.05, vjust = -2.5, color = grey90K),
      legend.position = 'none',
      strip.background = element_blank(),
      axis.ticks = element_blank(),
      panel.margin = unit(1, 'lines'),
      panel.grid.major.y = element_blank(),
      panel.grid.minor.y = element_blank(),
      panel.grid.minor.x = element_blank(),
      panel.grid.major.x = element_blank())
}