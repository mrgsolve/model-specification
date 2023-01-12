library(dplyr)
library(readr)
library(bbr)

# Compare mrgsolve against NONMEM PRED
tab <- read_table("model/nonmem/106/106.tab", skip = 1)
csv <- read_csv("data/derived/analysis3.csv", na = '.')
data <- left_join(tab, csv, by = "NUM", suffix = c("", ".y"))

head(data)

mod <- mread("model/106-nonmem.mod")

check <- mrgsim(
  zero_re(mod),
  data = data,
  carry_out = "EVID,PRED",
  digits = 6,
  output = "df"
)

head(check)

check_obs <- filter(check, EVID==0)
summary(check_obs$PRED - check_obs$Y)


summary(check_obs$IPRED - check_obs$Y)


