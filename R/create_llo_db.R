library(readr)
library(dplyr)
library(purrr)
library(RSQLite)
library(stringr)


sp_dir <- file.path("Path/To/Sharepoint/",
                    "RES_FG_Governance and Performance - New Framework - Dashboard Data/",
                    "MS_Data_Outputs")


##
csvs <- dir(sp_dir, recursive = TRUE, full.names = TRUE, pattern = ".csv")




get_data_from_csv <- function(fl) {
    if(str_detect(fl, "mental_physical_health")) { ## workaround for the separate sex column
        df <- read_csv(fl, col_types = c(timeperiod_sortable = "character",
                                         timeperiod_label = "character",
                                         timeperiod_type = col_character(),
                                         indicator = col_character(),
                                         llo = col_character(),
                                         sex = col_character(),
                                         value = col_number())
        )
        w_persons <- which(df$sex %in% "Persons")
        df$area_name <- df$sex
        df$area_name[w_persons] <- "London"

    } else {
        df <- read_csv(fl, col_types = c(timeperiod_sortable = "character",
                                         timeperiod_label = "character",
                                         timeperiod_type = col_character(),
                                         indicator = col_character(),
                                         llo = col_character(),
                                         area_name = col_character(),
                                         value = col_number())
        )
        df$area_name <- str_replace(df$area_name, " region \\(statistical\\)", "")
        df$area_name <- str_replace(df$area_name, "United Kingdon", "UK")

    }
    df
}


dat <- map_df(csvs, get_data_from_csv)

mtd_e <- read_csv("data/meta_llo.csv")

lkp <- mtd_e$dataset
names(lkp) <- mtd_e$indicator

dat$dataset <- lkp[dat$indicator]

glimpse(dat)


cn <- dbConnect(SQLite(), "data/sol_llo.db")
tbls <- dbListTables(cn, tbls)
if("meta" %in% tbls) dbSendQuery(cn, "drop table meta")
if("charts_data" %in% tbls) dbSendQuery(cn, "drop table charts_data")
dbWriteTable(cn, "meta", mtd_e)
dbWriteTable(cn, "charts_data",
              dat |>
                  select(dataset, timeperiod_sortable, timeperiod_label,
                         timeperiod_type, area_name, value))

dbDisconnect(cn)
