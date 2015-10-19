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
            fluidRow(h4(HTML("<div style='padding-left: 4px;'>What in the world is this?</div>"))),
            fluidRow(h5(HTML("<div style='padding-left: 4px;'> At the 2015 GeoCenter GIS Specialists workshop, we wanted to get to know each
                             other a little better &ndash; and what's more fun than playing with some data?</div>"))), 
            fluidRow(HTML("<div style='font-size:14px; padding-left: 4px; color: #565656'> So we decided to collect some data about some 
                          <a target='_blank' href='https://docs.google.com/document/d/174qkZ-XMwxDzRaE0HmU5oMC30-BWxFRVDjeLPhTvu0g/edit'>silly questions</a>
                          and see whether we could see any trends, develop any hypotheses, and learn and share any insights about each other.</div>")),
            fluidRow(HTML("<div style='font-size:14px; padding-left: 4px; color: #565656'> If you want to add your data, please feel free to do so  
                          <a target='_blank' href='https://docs.google.com/spreadsheets/d/1qgm-M9YSdbqFw3UX5ydMTgFKKkIIzYVC6qMMgtFxKW0/edit#gid=0'>here</a>,
                          and please contact <a target='_blank' href = 'mailto:lhughes@usaid.gov'>Laura Hughes</a> with any comments.</div>")),
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
