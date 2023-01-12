library(mrgsolve)
library(dplyr)

mod <- mread("model/combined.mod")

mod <- mread("demo.mod", project = "model")

mod %>% ev(amt = 100) %>% mrgsim()

mod <- modlib("irm1")


mrgsolve:::SUPERMATRIX(omat(mod)@data)
