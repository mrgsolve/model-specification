library(dplyr)
library(readr)
library(bbr)
library(mrgsolve)

mod <- modlib("popex") %>% zero_re()

nh <- data.frame(WT = runif(100, 50, 140), ID = seq(100))

doses <- expand.ev(amt = 100) %>% ev_rep(1:100)

data <- left_join(doses, nh, by = "ID")

out <- mrgsim(mod, data, delta = 0.1, end= 72)

