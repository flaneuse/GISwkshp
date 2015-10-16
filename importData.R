
genderOrder = rev(c('male', 'female'))
expOrder = rev(c('0 - 2', '2 - 5', '5 - 10', '10 - 20', '20+'))
danceOrder = c('no', 'yes')
singOrder = rev(tolower(c('Today',
                  'Yesterday',
                  'This week',
                  'This Month',
                  'This Year')))
ratherOrder = c('drink', 'sleep', 'eat',  'work')


# colors ------------------------------------------------------------------
colorSpecial = '#AD0C0C'
grey60K = "#808285"

# Import data from a Google spreadsheet.
library(googlesheets)
library(tidyr)
library(dplyr)


# Read in data ------------------------------------------------------------
url ='https://docs.google.com/spreadsheets/d/1DYzbBlSL0Jc6ybJTvVZSl_CFQZNcukVdaXyMqO34pJU/pub?gid=0&single=true&output=csv'



gap = url %>% gs_url()

rawData = gap %>% gs_read()

df = rawData %>% 
  select(-Dominant.hand) %>% 
  filter(!is.na(geo), !is.na(experience),
         !is.na(mood), !is.na(dance), !is.na(sing), !is.na(gender)) %>% 
  mutate(sing = tolower(sing),
         rather = tolower(rather))

# Factorise data ----------------------------------------------------------
df$geo = factor(df$geo, levels = c('Europe / Eurasia',
                                   'Middle East',
                                   'Asia', 
                                   'North America',
                                   'Africa',
                                   'Latin America & Caribbean'),
                labels = c('Europe / Eurasia',
                           'Middle East',
                           'Asia', 
                           'N. America',
                           'Africa',
                           'LAC'))
df$experience = factor(df$experience, expOrder)
df$gender = factor(df$gender, genderOrder)
df$mood = factor(df$mood, 
                 levels = rev(c('e', 'd', 'a', 'c', 'b')), 
                 labels = rev(c('sad :(', 'crazy eyes',  'happy!', 'meh', 'sleepy')))
df$dance = factor(df$dance, danceOrder)
df$sing = factor(df$sing, singOrder)
df$rather = factor(df$rather, ratherOrder)




# Convert to long db for plotting -----------------------------------------
tidy4PC = function(df, colorVar, colorVals){
  
mutateCondit = paste0('ifelse(', colorVar, '%in% c(', list(colorVals), '),"',colorSpecial, '","', grey60K, '")')
 
 df = mutate_(df, .dots= setNames(list(mutateCondit), 'colour'))

df2 = df %>% 
  gather(cat, value, -grp, -colour)

# Calculate numeric position for ggvis.
df3 = df %>% 
  mutate(geo = as.numeric(geo),
         gender = as.numeric(gender) * 6/3 + 0.5,
         experience = as.numeric(experience) * 6/5 + 0.5,
         mood = as.numeric(mood)* 6/5 + 0.5,
         dance = as.numeric(dance)* 6/3 + 0.5,
         sing = as.numeric(sing) * 6/5 + 0.5,
         rather = as.numeric(rather) * 6/4 + 0.5) %>% 
  gather(cat, y, -grp, -colour)

df2Plot = full_join(df2, df3) %>% 
  mutate(buffer = nchar(value))
}
