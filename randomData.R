q1 = c('D.C.', 'Mission')
q2 = c('Africa', 'Asia', 'Europe', 
       'LAC',
       'Middle East', 'N. America', 'Oceania')
q3 = c('male', 'female')
q4 = c('0-2 y', '2-5 y', '5-10 y', '10-20 y', '20+ y')
q5 = c('happy :)', 'excited!', 'sleepy zzz',
       'sad :(', 'overwhelmed :-|')  


n = 30

df = data.frame(locale = sample(q1, size = n, replace = TRUE),
                geo = sample(q2, size = n, replace = TRUE),
                gender = sample(q3, size = n, replace = TRUE),
                exp = sample(q4, size = n, replace = TRUE),
                mood = sample(q5, size = n, replace = TRUE)) %>% 
  mutate(grp = 1:n,
         colour = ifelse(mood == 'sleepy zzz',
                         '#a50026', grey60K))



df$locale = 
  factor(df$locale, c('D.C.', 'Mission'))

df$geo = 
  factor(df$geo, c('Africa', 'Asia', 'Europe', 
                   'LAC',
                   'Middle East', 'N. America', 'Oceania'))

df$exp = 
  factor(df$exp, c('0-2 y', '2-5 y', '5-10 y', '10-20 y', '20+ y'))

df$gender = 
  factor(df$gender, c('male', 'female'))

df$mood = 
  factor(df$mood, c('happy :)', 'excited!', 'sleepy zzz',
                    'sad :(', 'overwhelmed :-|'))

df2 = df %>% 
  gather(cat, value, -grp, -colour)

df3 = df %>% 
  mutate(mood = as.numeric(mood)* 7/6 + 0.5, 
         geo = as.numeric(geo),
         gender = as.numeric(gender) * 7/3 + 0.5,
         exp = as.numeric(exp) * 7/6 + 0.5,
         locale = as.numeric(locale) * 7/3 + 0.5) %>% 
  gather(cat, y, -grp, -colour)

df2Plot = full_join(df2, df3) %>% 
  mutate(buffer = nchar(value))