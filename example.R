library(ggplot2)
library(plotly)
library(sysid)

rm(list = ls())
source("transfer.R")

df <- read.table("simple.csv", header = TRUE, sep = ",")
gain <- 1.1096
esophageal_raw <- df$pes
tf_pes <- df$tf_pes

#bf = butter(5, 0.06)
#esophageal <- filtfilt(bf, esophageal_raw)
esophageal <- lowpass_esophageal(esophageal_raw)

result <- oe_model(esophageal, gain)

x <- seq_along(esophageal)

esophageal_df <- data.frame(x, esophageal, result, tf_pes)

fig <- plot_ly(esophageal_df, y = ~esophageal, type = 'scatter', name = 'filtered pes', mode = 'lines')
fig <- fig %>% add_trace(y = ~esophageal_raw, name = 'original pes (MATLAB)', mode = 'lines')
fig <- fig %>% add_trace(y = ~tf_pes, name = 'corrected pes (MATLAB)', mode = 'lines')
fig <- fig %>% add_trace(y = ~result, name = 'corrected pes (R)', mode = 'lines')
fig <- fig %>% layout(legend = list(x = 0.05, y = 0.05))

fig