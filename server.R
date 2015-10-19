library(shiny)

widthPlot = 'auto'
heightPlot = 'auto'
grey60K = "#808285"
grey90K = "#414042"

# Read in data
source('importData.R')
source('plotFreq.R')
source('heatmap.R')

#Color
df2Plot = tidy4PC(df, 'sing', c('today', ''))



# Shiny server function ---------------------------------------------------


shinyServer(function(input, output, session) {
  
  
output$geoFreq = renderPlot({
  plotFreq('geo')},
  width = 75, 
  height = 150
)
  

# Plot with variable width ------------------------------------------------

output$varwidth = renderPlot({
  source('ggplotGIS.R')
  
  lastPts = dfGGplot %>% 
    filter(cat2 == 'rather')
  
  ggplot(dfGGplot, aes(x = cat1, xend = cat2, 
                            size = nObs * 2,
                            y = y1, yend = y2)) +
    geom_segment(lineend = 'round',
                 colour = '#367fa9',
                 alpha = 0.5) +
    geom_point(aes(size = buffer * 30), 
               colour = '#FFFFFF') +
    annotate(x = 'rather', y = lastPts$y2, geom = 'point',
             size = lastPts$buffer * 6, fill = 'white',
             colour = 'white') +
    annotate(x = 'rather', y = lastPts$y2, 
             label = lastPts$val2,
             geom = 'text',
             size = 5,
             colour =  grey90K,
             family = 'Segoe UI') +
    geom_text(aes(label = val1),
              size = 5,
              colour =  grey90K,
              family = 'Segoe UI') +
    coord_cartesian(ylim = c(1,7)) + 
    scale_x_discrete(drop=FALSE) +
    scale_size(range = c(1, 30)) +
    theme_bw() +
    theme(
      text = element_text(family = 'Segoe UI Light', colour = grey60K),
      rect = element_blank(),
      plot.background = element_blank(),
      axis.text = element_text(size = 12,  color = grey60K),
      axis.text.y = element_blank(),
      title =  element_text(size = 15, family = "Segoe UI", hjust = 0, color = grey90K),
      axis.title =  element_blank(),
      strip.text = element_text(size=14, family = "Segoe UI Semilight", hjust = 0.05, vjust = -2.5, color = grey90K),
      legend.position = 'none',
      strip.background = element_blank(),
      axis.ticks = element_blank(),
      panel.margin = unit(1, 'lines'),
      panel.grid.major.y = element_blank(),
      panel.grid.minor.y = element_blank(),
      panel.grid.minor.x = element_blank(),
      panel.grid.major.x = element_blank())
  
})

# mini frequency plots ----------------------------------------------------

output$expFreq = renderPlot({
  plotFreq('experience')},
  width = 75, 
  height = 125
)

output$genderFreq = renderPlot({
  plotFreq('gender')},
  width = 75, 
  height = 50
)



output$moodFreq = renderPlot({
  plotFreq('mood')},
  width = 75, 
  height = 125
)

output$danceFreq = renderPlot({
  plotFreq('dance')},
  width = 75, 
  height = 50
)


output$singFreq = renderPlot({
  plotFreq('sing')},
  width = 75, 
  height = 125
)

output$ratherFreq = renderPlot({
  plotFreq('rather')},
  width = 75, 
  height = 100
)


# heat plots — correlation ------------------------------------------------


output$geoHeat = renderPlot({
  drawHeatmap(df, 'geo',
              asPct = input$pct)}, 
  width = 275,
  height = 650)


output$expHeat = renderPlot({
  drawHeatmap(df, 'experience',
              asPct = input$pct)},
  width = 275,
  height = 650)

output$genderHeat = renderPlot({
  drawHeatmap(df, 'gender',
              asPct = input$pct)},
  width = 275,
  height = 650)


output$moodHeat = renderPlot({
  drawHeatmap(df, 'mood',
              asPct = input$pct)},
  width = 275,
  height = 650)


output$singHeat = renderPlot({
  drawHeatmap(df, 'sing',
              asPct = input$pct)},
  width = 275,
  height = 650)


output$danceHeat = renderPlot({
  drawHeatmap(df, 'dance',
              asPct = input$pct)},
  width = 275,
  height = 650)

output$ratherHeat = renderPlot({
  drawHeatmap(df, 'rather',
              asPct = input$pct)},
  width = 275,
  height = 650)



# main ggvis plot ---------------------------------------------------------
plot_tooltip = function(x) {
        if(is.null(x)) return(NULL)
            paste0(x)
            
        
}


  df2Plot %>% 
    group_by(grp) %>% 
    ggvis(~cat, ~y) %>% 
    set_options(height = heightPlot, width = widthPlot) %>% 
    filter(cat %in% eval(input_checkboxgroup(c('geo', 'gender', 'experience', 'mood', 'dance', 'sing', 'rather'),
                                             label = 'turn on or off different questions',
                                             selected = c('geo', 'gender', 'experience', 'mood', 'dance', 'sing', 'rather')))) %>% 
    layer_lines(stroke := ~colour,
                # strokeWidth.hover := 16,
                strokeWidth := input_slider(1, 30, 
                                            label = 'line thickness', value = 5),
                opacity := input_slider(0, 1, 
                                            label = 'line opacity', value = 0.15)
    ) %>% 
    layer_points(fill := '#ecf0f5',
                 size := ~buffer * 310,
                 shape := 'circle') %>%
    # add_tooltip(plot_tooltip, "hover") %>%
    # handle_click(position) %>% 
    layer_text(text := ~value, fontSize := 16,
               fontWeight := 300,
               fill := grey90K,
               align := 'center',
               baseline:="middle",
               font := 'Segoe UI') %>% 
    add_axis(type = 'y',
             title = '',
             tick_size_major = 0,
             properties = axis_props(
               axis = list(strokeWidth = 0),
               labels = list(fontSize = 0),
               grid = list(
                 strokeWidth = 0)
             )) %>% 
    add_axis(type = 'x', 
             tick_size_major = 0,
             orient = "top",
             title = "",
             properties = axis_props(
               axis = list(strokeWidth = 0),
               labels = list(fontSize = 16,
                             fill = grey60K,
                             fontWeight = 200,
                             font = 'Segoe UI'),
               grid = list(strokeWidth = 0))) %>% 
    scale_numeric("y", domain = c(1, 7)) %>% 
    bind_shiny('parallelCoords', 'selectCats', 
               'selectWidth', 'selectOpacity')
  
  
  # filtered ----------------------------------------------------------------
  
  iFiltered = df2Plot %>% 
    filter(value == 'sleepy zzz')
  
  df2Plot %>% 
    filter(grp %in% iFiltered$grp) %>% 
    group_by(grp) %>% 
    ggvis(~cat, ~y) %>% 
    filter(cat %in% eval(input_checkboxgroup(c('geo', 'gender', 'experience', 'mood', 'dance', 'sing', 'rather'),
                                             label = 'turn on or off different questions',
                                             selected = c('geo', 'gender', 'experience', 'mood', 'dance', 'sing', 'rather')))) %>% 
    layer_lines(stroke := ~colour, 
                opacity := 0.2,
                strokeWidth := 6) %>% 
    layer_points(fill := 'white',
                 size := ~buffer * 310,
                 shape := 'circle'
    ) %>% 
    layer_text(text := ~value, fontSize := 16,
               fontWeight := 300,
               fill := grey90K,
               align := 'center',
               baseline := 'middle',
               font := 'Segoe UI') %>% 
    add_axis(type = 'y',
             title = '',
             tick_size_major = 0,
             properties = axis_props(
               axis = list(strokeWidth = 0),
               labels = list(fontSize = 0),
               grid = list(
                 strokeWidth = 0)
             )) %>% 
    add_axis(type = 'x', 
             tick_size_major = 0,
             orient = "top",
             title = "",
             properties = axis_props(
               axis = list(strokeWidth = 0),
               labels = list(fontSize = 14,
                             fill = grey60K,
                             fontWeight = 200,
                             font = 'Segoe UI'),
               grid = list(strokeWidth = 0))) %>% 
    scale_numeric("y", domain = c(1, 7)) %>% 
    bind_shiny('filtered', 'selectedCats2')
  
})




# 
# 
# 
# ggplot(df, aes(colour = locale)) +
#   geom_segment(aes(y = geo, yend = gender, x = 'home', xend = 'gender')) +
#   theme_classic()
# 
# 
# ggplot(df, aes(x = cat, y = y, group = grp)) + 
#   geom_line() +
#   theme_xOnly() +
#   theme(axis.ticks = element_blank(),
#         axis.line = element_blank(),
#         axis.title = element_blank()) +
#   coord_cartesian(ylim = c(1,5)) +
#   geom_point(size = 20, color = 'white', shape = 15) +
#   geom_text(aes(label = raw), family = 'Segoe UI')
# 
# grey20K =  '#D1D3D4'

