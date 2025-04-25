library(readxl)
library(dplyr)
library(tidyr)
library(glue)
library(stringr)
library(readr)

env_fl <- "C:/Users/JoeHeywood/Greater London Authority/IU - State of London report/Version 6 (June 2025)/Data/Environment/Environment v6.xlsx"



epc <- read_excel(env_fl, "Fig 2 Energy performance") |>
    select(Quarter, value = 2) |>
    separate(Quarter, into = c("Year", "Q"), sep = "/") |>
    mutate(M = ((as.numeric(Q) - 1)*3) + 1) |>
    mutate(timeperiod_sortable = glue("{Year}{sprintf('%02d', M)}01"),
           timeperiod_label = glue("{Year}Q{Q}"),
           timeperiod_type = "Quarter",
           indicator = "Energy efficiency ratings of new and existing homes",
           llo = "London is a net zero carbon city",
           area_name = "London",
           area_code = ""  ) |>
    select(timeperiod_sortable, timeperiod_label, timeperiod_type,
           indicator, llo, area_name, area_code, value)


rcyc <- read_excel(env_fl, "Fig 3 Recycling rates") |>
    select(Year:England) |>
    pivot_longer(-Year, names_to = "area_name") |>
    mutate(y1 = str_replace(Year, "(\\d{4})-(\\d{2})", "\\1")) |>
    mutate(timeperiod_sortable = glue("{y1}0401"),
           timeperiod_label = Year,
           timeperiod_type = "Financial Year",
           indicator = "Household waste recycling rate",
           llo = "London is a net zero carbon city",
           area_name = "London",
           area_code = ""  ) |>
    select(timeperiod_sortable, timeperiod_label, timeperiod_type,
           indicator, llo, area_name, area_code, value)

ren_eng <- read_excel(env_fl, "Fig 4 Renewable energy gen") |>
    select(Year, value = Value) |>
    mutate(timeperiod_sortable = glue("{Year}0401"),
           timeperiod_label = as.character(Year),
           timeperiod_type = "Financial Year",
           indicator = "Renewable electricity generated in London",
           llo = "London is a net zero carbon city",
           area_name = "London",
           area_code = ""  ) |>
    select(timeperiod_sortable, timeperiod_label, timeperiod_type,
           indicator, llo, area_name, area_code, value)


nzcc <- bind_rows(epc, rcyc, ren_eng)

write_csv(nzcc, "llo_net_zero_supps.csv")
