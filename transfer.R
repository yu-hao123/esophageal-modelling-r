library(sysid)

oe_model <- function(input_signal, gain) {
    model <- idpoly(A = 1, B = c(0, 20.9958, -19.4621),
                    C = 1, D = 1, F = c(1, 0.2710, 0.1242, 0.0937),
                    Ts = 0.01, noiseVar = 0.0079)
    output_signal <- gain * sim(model, input_signal)
    return(output_signal)
}
