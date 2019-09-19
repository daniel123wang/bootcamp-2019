library(data.table)
library(readr)
generation_df <- read_csv("data/ca_energy_generation.csv")
generation_dt <- fread("data/ca_energy_generation.csv")

class(generation_df)
class(generation_dt)

generation_dt[natural_gas <= 5000 & large_hydro >= 2000]
generation_dt[coal >= 10 & solar > median(solar)]

generation_dt[,newcol := 3*wind + solar*biogas/2]
generation_dt[,.(newcol = 3*wind + solar*biogas/2)]
generation_dt[,newcol := NULL]

generation_dt[,total_hydro := small_hydro + large_hydro]
generation_dt[, .(mean(nuclear), mean(biogas))]

generation_dt[solar == 0,.(datetime, natural_gas+coal)]

generation_dt[, median(solar), by = hour(datetime)]
generation_dt[solar > 0, max(natural_gas), by = hour(datetime)]

generation_dt[,.N]




