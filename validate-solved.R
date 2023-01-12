library(dplyr)
library(readr)
library(bbr)

tab <- read_table("model/nonmem/106/106.tab", skip = 1)
csv <- read_csv("data/derived/analysis3.csv", na = '.')
data <- left_join(tab, csv, by = "NUM", suffix = c("", ".y"))

head(data)

mod <- mread("model/106-nonmem.mod")

check <- mrgsim(
  zero_re(mod),
  data = data,
  carry_out = "NUM,EVID,PRED",
  digits = 5,
  output = "df"
)

head(check)

check_obs <- filter(check, EVID==0)

summary(check_obs$PRED - check_obs$Y)

