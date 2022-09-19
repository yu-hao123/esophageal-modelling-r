library(ggplot2)
library(plotly)
library(sysid)

source("transfer.R")

df <- read.table("simple.csv", header = TRUE, sep = ",")
gain <- 1.1096
esophageal <- df$pes
tf_pes <- df$tf_pes

result <- oe_model(esophageal, gain)

x <- seq_along(esophageal)

esophageal_df <- data.frame(x, esophageal, result, tf_pes)

fig <- plot_ly(dataf, y = ~esophageal, type = 'scatter', name = 'original pes', mode = 'lines')
fig <- fig %>% add_trace(y = ~tf_pes, name = 'corrected pes (MATLAB)', mode = 'lines')
fig <- fig %>% add_trace(y = ~result, name = 'corrected pes (R)', mode = 'lines')
fig <- fig %>% layout(legend = list(x = 0.05, y = 0.05))

fig