library(dplyr)
dummy_df <- data.frame(
    region = c("North East", "North West", "East Midlands", "West Midlands",
               "South West", "South East", "London", "East of England"),
    value = c(.45, .43, .56, .58, .72, .73, .78, .66)
)

fmt_df <- dummy_df |>
    select(xd = region, only = value)


optsx = list(
    type = "character",
    charttype = "bar",
    stackgroup = "stack",
    stack = TRUE,
    horiz = TRUE,
    #lgg = c(),
    silent_x = FALSE,
    nolabels = FALSE
)
mopts <- list(includetitles = FALSE)
chrt <- robservable(
    "@joe-heywood-gla/gla-dpa-chart",
    include = "chrt",
    input = list(unempl = fmt_df, chartopts = optsx, metaopts = mopts,
                 inpopts = list())
)


df2 <- data.frame(
    xd = c("2014-15", "2015-16", "2016-17", "2017-18", "2018-19", "2019-20"),
    Male = c(14, 14, 14.5, 14.8, 16, 18),
    Female = c(10, 11, 11, 12, 11, 10)
)

optsx2 = list(
    type = "character",
    charttype = "bar",
    stackgroup = "stack",
    stack = TRUE,
    horiz = FALSE,
    silent_x = FALSE,
    nolabels = FALSE
)

chrt2 <- robservable(
    "@joe-heywood-gla/gla-dpa-chart",
    include = "chrt",
    input = list(unempl = df2, chartopts = optsx2, metaopts = mopts,
                 inpopts = list())
)

df3 <- data.frame(
    xd = c("2016", "2017", "2018", "2019", "2020",
           "2016", "2017", "2018", "2019", "2020"),
    b = c("London", "London", "London", "London", "London",
          "UK", "UK", "UK", "UK", "UK"),
    y = c(14, 14.5, 15, 14.8, 15.6,
          10.5, 12, 11.8, 13,  14.8)
)

optsx3 = list(
    type = "character",
    charttype = "line",
    nolabels = FALSE,
    high = TRUE
)


chrt3 <- robservable(
    "@joe-heywood-gla/gla-dpa-chart",
    include = "chrt",
    input = list(unempl = df3, chartopts = optsx3, metaopts = mopts,
                 inpopts = list())
)
