# Example preprocessing script.
tracking.a$Date <- as.Date(tracking.a$Date)
A <- c(NA, diff(tracking.a$Cases))
tracking.a$CleanDeltaCases  <- ifelse( is.na(A), tracking.a$DeltaCases, A)
tracking.a$CleanDeltaDeaths <- c(NA, diff(tracking.a$Deaths))

tracking.b$Date <- as.Date(tracking.b$Date)
tracking.b$CleanDeltaCases  <- tracking.b$DeltaCases
tracking.b$CleanDeltaDeaths <- tracking.b$DeltaDeaths

tracking.c$Date <- as.Date(tracking.c$Date)
tracking.c$CleanDeltaCases  <- tracking.c$DeltaCases
tracking.c$CleanDeltaDeaths <- tracking.c$DeltaDeaths
