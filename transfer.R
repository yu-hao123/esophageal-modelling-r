library(sysid)
library(signal)

lowpass_esophageal <- function(esophageal_pressure) {
    # Filter parameters
    fs <- 100
    order <- 16 # should be much lower than the input data size
    HR <- 60
    cutoff <- HR / 5
    wn <- cutoff / (fs / 2)

    filter_coefs <- fir1(order, wn, "low", scale = FALSE)
    filtered <- filtfilt(filter_coefs, esophageal_pressure)
    return(filtered)
}

oe_model <- function(input_signal, gain) {
    model <- idpoly(A = 1, B = c(0, 20.9958, -19.4621),
                    C = 1, D = 1, F = c(1, 0.2710, 0.1242, 0.0937),
                    Ts = 0.01, noiseVar = 0.0079)
    output_signal <- gain * sim(model, input_signal)
    return(output_signal)
}

