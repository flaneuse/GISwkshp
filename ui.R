library(ggvis)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(RColorBrewer)


sidebar <- dashboardSidebar(
  width = 150,
  sidebarMenu(
    menuItem("plot", tabName = "mainPlot", icon = icon("bar-chart")),
    menuItem("alternate plot", tabName = "widthPlot", icon = icon("line-chart")),
    menuItem("correlations", tabName = "heatMap", icon = icon("th", lib = "glyphicon"))
    # menuItem("filtered view", tabName = "compare", icon = icon("line-chart"))
  ))



header <- dashboardHeader(
  title = "Howdy GIS Specialists!",
  titleWidth = 250)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = 'mainPlot',
            fluidRow(column(7, ggvisOutput('parallelCoords')),
                     column(3,
                            fluidRow(uiOutput('selectCats')),
                            fluidRow(uiOutput('selectWidth')),
                            fluidRow(uiOutput('selectOpacity')))),
            fluidRow(column(1, plotOutput('geoFreq')),
                     column(1, plotOutput('expFreq')),
                     column(1, plotOutput('genderFreq')),
                     column(1, plotOutput('moodFreq')),
                     column(1, plotOutput('singFreq')),
                     column(1, plotOutput('danceFreq')),
                     column(1, plotOutput('ratherFreq')))),
    tabItem(tabName = 'widthPlot',
            fluidRow(plotOutput('varwidth', height = '550px'))),
    tabItem(tabName = 'heatMap',
            fluidRow(helpText("Okay, so this is a bit of a mess.  But, basically, the dark spots within each
                              group show which two responses occur frequently together, like the observation that people that feel happy tend to have sang outloud today.")),
            fluidRow(checkboxInput('pct', width = 400,
                                   'Display data as percent (by column, for each group)?',
                                   value = FALSE)),
            fluidRow(column(3, plotOutput('geoHeat', height = '650px')),
                     column(3, plotOutput('expHeat', height = '650px')),
                     column(3, plotOutput('genderHeat', height = '650px')),
                     column(3, plotOutput('moodHeat', height = '650px'))),
            fluidRow(''),
            fluidRow(
                     column(3, plotOutput('singHeat', height = '650px')),
                     column(3, plotOutput('danceHeat', height = '650px')),
                     column(3, plotOutput('ratherHeat', height = '650px'))
                            )),
    tabItem(tabName = 'filtered',
            fluidRow(column(9, ggvisOutput('filtered')),
                     column(3,uiOutput('selectedCats2'))
            ))))

dashboardPage(
  title = "Welcome, GIS Specialists!",
  header,
  sidebar,
  body
)
