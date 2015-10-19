plotFreq = function(var,
                    data = df){ 
  grey90K = "#414042"
  
  
  ggplot(data, aes_string(x = var)) +
  geom_bar(fill = '#08519c') + 
  coord_flip() + 
  geom_text(stat = 'bin', aes(label=..count..), 
            colour = 'white', binwidth = 1,
            size = 3.5, family = "Segoe UI", hjust = 1.05) +
    ggtitle(var) +
  theme(
    title = element_text(size = 8.5, family = "Segoe UI", 
                         hjust = -0.35, color = grey90K),
    axis.title = element_blank(),
    axis.text.y = element_text(size = 7, family = "Segoe UI", 
                               hjust = 1, color = grey90K),
    axis.text.x = element_blank(),
    axis.ticks = element_blank(),
    axis.ticks.length = unit(0, units = 'points'),
    panel.border = element_blank(),
    plot.margin = rep(unit(0, units = 'points'),4),
    panel.grid = element_blank(),
    panel.background = element_blank(), 
    plot.background = element_rect(fill = '#ecf0f5', size = 0), 
    legend.position="none"
  )}