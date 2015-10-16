df2 = df %>% 
  mutate(geoY = as.numeric(geo),
         genderY = as.numeric(gender) * 6/3 + 0.5,
         experienceY = as.numeric(experience) * 6/5 + 0.5,
         moodY = as.numeric(mood)* 6/5 + 0.5,
         danceY = as.numeric(dance)* 6/3 + 0.5,
         singY = as.numeric(sing) * 6/5 + 0.5,
         ratherY = as.numeric(rather) * 6/4 + 0.5) %>% 
  group_by(val1 = geo, val2 = experience, 
           cat1 = 'geo', cat2 = 'experience',
           y1 = geoY, y2 = experienceY) %>% 
  summarise(nObs = n())


df3 = df %>% 
  mutate(geoY = as.numeric(geo),
         genderY = as.numeric(gender) * 6/3 + 0.5,
         experienceY = as.numeric(experience) * 6/5 + 0.5,
         moodY = as.numeric(mood)* 6/5 + 0.5,
         danceY = as.numeric(dance)* 6/3 + 0.5,
         singY = as.numeric(sing) * 6/5 + 0.5,
         ratherY = as.numeric(rather) * 6/4 + 0.5) %>% 
  group_by(val1 = experience, val2 = gender, 
           cat1 = 'experience', cat2 = 'gender',
           y1 = experienceY, y2 = genderY) %>% 
  summarise(nObs = n())


df4 = df %>% 
  mutate(geoY = as.numeric(geo),
         genderY = as.numeric(gender) * 6/3 + 0.5,
         experienceY = as.numeric(experience) * 6/5 + 0.5,
         moodY = as.numeric(mood)* 6/5 + 0.5,
         danceY = as.numeric(dance)* 6/3 + 0.5,
         singY = as.numeric(sing) * 6/5 + 0.5,
         ratherY = as.numeric(rather) * 6/4 + 0.5) %>% 
  group_by(val1 = gender, val2 = mood, 
           cat1 = 'gender', cat2 = 'mood',
           y1 = genderY, y2 = moodY) %>% 
  summarise(nObs = n())


df5 = df %>% 
  mutate(geoY = as.numeric(geo),
         genderY = as.numeric(gender) * 6/3 + 0.5,
         experienceY = as.numeric(experience) * 6/5 + 0.5,
         moodY = as.numeric(mood)* 6/5 + 0.5,
         danceY = as.numeric(dance)* 6/3 + 0.5,
         singY = as.numeric(sing) * 6/5 + 0.5,
         ratherY = as.numeric(rather) * 6/4 + 0.5) %>% 
  group_by(val1 = mood, val2 = sing, 
           cat1 = 'mood', cat2 = 'sing',
           y1 = moodY, y2 = singY) %>% 
  summarise(nObs = n())


df6 = df %>% 
  mutate(geoY = as.numeric(geo),
         genderY = as.numeric(gender) * 6/3 + 0.5,
         experienceY = as.numeric(experience) * 6/5 + 0.5,
         moodY = as.numeric(mood)* 6/5 + 0.5,
         danceY = as.numeric(dance)* 6/3 + 0.5,
         singY = as.numeric(sing) * 6/5 + 0.5,
         ratherY = as.numeric(rather) * 6/4 + 0.5) %>% 
  group_by(val1 = sing, val2 = dance, 
           cat1 = 'sing', cat2 = 'dance',
           y1 = singY, y2 = danceY) %>% 
  summarise(nObs = n())

df7 = df %>% 
  mutate(geoY = as.numeric(geo),
         genderY = as.numeric(gender) * 6/3 + 0.5,
         experienceY = as.numeric(experience) * 6/5 + 0.5,
         moodY = as.numeric(mood)* 6/5 + 0.5,
         danceY = as.numeric(dance)* 6/3 + 0.5,
         singY = as.numeric(sing) * 6/5 + 0.5,
         ratherY = as.numeric(rather) * 6/4 + 0.5) %>% 
  group_by(val1 = dance, val2 = rather, 
           cat1 = 'dance', cat2 = 'rather',
           y1 = danceY, y2 = ratherY) %>% 
  summarise(nObs = n())

dfGGplot = rbind(df2, df3, df4, df5, df6, df7) %>% 
  mutate(buffer = nchar(as.character(val1)))

dfGGplot$cat1 = factor(dfGGplot$cat1,
  c('geo', 'experience', 'gender', 
    'mood', 'sing', 'dance', 'rather'))

dfGGplot$cat2 = factor(dfGGplot$cat2,
                      c('geo', 'experience', 'gender', 
                        'mood', 'sing', 'dance', 'rather'))