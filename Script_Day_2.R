library(readr)
generation <- read_csv("data/ca_energy_generation.csv")
imports <- read_csv("data/ca_energy_imports.csv")
head(generation)
library(reshape2)
long_gen <- melt(generation, id.vars = "datetime", variable.name = "source", value.name = "usage")
head(long_gen)

merged_energy <- merge(generation, imports, by = "datetime")
long_merged_energy <- melt(merged_energy, id.vars = "datetime", variable.name = "source", value.name = "usage")
head(long_merged_energy)

library("dplyr")
library("tidyverse")
tmp <- select(merged_energy, biogas, biomass, geothermal, solar)
tmp <- select(merged_energy, contains("hydro"))
tmp <- mutate(long_merged_energy, log_usage = log(usage))
head(tmp)

merged_energy %>% select(contains("hydro")) %>% mutate(total_hydro = rowSums(., na.rm = T)) %>% 
    summarize(mean_hydro = mean(total_hydro, na.rm = T))

merged_energy %>% summarise(mean_use_sh = mean(small_hydro), mean_use_lh = mean(large_hydro), mean_use_biogas = mean(biogas),
                            mean_use_biomass = mean(biomass))


