
library(ggplot2)
library(plotly)
library(sysid)

oe_model <- function(input_signal) {
    model <- idpoly(A = 1, B = c(0, 20.9958, -19.4621),
C = 1, D = 1, F = c(1, 0.2710, 0.1242, 0.0937), Ts=0.01, noiseVar = 0.0079)
    output_signal <- 1.1096 * sim(model, input_signal)
    return(output_signal)
}


df <- read.table("simple.csv", header = TRUE, sep = ",")

esophageal <- df$pes
tf_pes <- df$tf_pes

mod_process <- idpoly(A = c(1, -0.02697, 0.0000532),
B=c(0, 3.72, -2.715),ioDelay = 0,Ts=0.01, noiseVar = 0.0079)

mod_oe <- idpoly(A = 1, B = c(0, 20.9958, -19.4621),
C = 1, D = 1, F = c(1, 0.2710, 0.1242, 0.0937), Ts=0.01, noiseVar = 0.0079)


result = 1.1016 * sim(mod_oe, esophageal)

result <- oe_model(esophageal)

x <- c(1:32202)

dataf <- data.frame(x, esophageal, result, tf_pes)


fig <- plot_ly(dataf, y = ~esophageal, type = 'scatter', mode = 'lines')
fig <- fig %>% add_trace(y = ~tf_pes, name = 'trace 1', mode = 'lines')
fig <- fig %>% add_trace(y = ~result, name = 'trace 0', mode = 'lines')

fig


#orca(fig, "image.png")