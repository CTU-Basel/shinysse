#' Shiny module server function for the display of sse for t-test
#'
#' Plots results of the power.t.test for the two-sample or paired t-test.
#'
#' @seealso \code{\link{sse_ttest_ui}}
#'
sse_ttest <- function(input, output, session, calcs_twosample, calcs_paired){
  ## define parameters and plot
  output$out_plot1 <- renderPlot({
    sigLevel <- as.numeric(input$in_alpha)
    power <- as.numeric(input$in_power)
    effSize <- as.numeric(input$in_slider2)
    sd <- as.numeric(input$in_slider1)

    if (input$in_type == "paired"){
      calcs <- calcs_paired
    } else{
      calcs <- calcs_twosample
    }

    calc <- calcs[[paste0("alpha", sub(".", "p", sigLevel, fixed = TRUE))]]

    ## calculate an example sample size for given parameters
    example <- powEx(calc, theta = effSize, xi = sd, power = power)

    ## dynamically define x and y axis limits for a nicer plotting experience
    calcN <- tex(example, type = "nEval")
    ## validations
    validate({
      calcAppx <- list(n = calcN)
      if (is.na(calcN)){
        calcAppx <- power.t.test(n = NULL,
                                 delta = effSize,
                                 sd = sd,
                                 sig.level = sigLevel,
                                 power = power)
      }
      need(!is.na(calcN),
           paste0("Estimated sample size is ", ceiling(calcAppx$n * 2), " , which is outside of plottable range."))
    })

    ## dynamically define x and y axis limits for a nicer plotting experience
    ylim <- c(0, 2000)
    if (calcN < 10) {
      ylim <- c(0, 20)
    } else if (calcN < 50) {
      ylim <- c(0, 100)
    } else if (calcN < 250) {
      ylim <- c(0, 500)
    } else if (calcN < 500) {
      ylim <- c(0, 1000)
    }

    p <- plot(example,
              at = c(0.7, 0.8, 0.9, 0.95),
              ylab = "sample size",
              xlab = "treatment effect",
              ylim = ylim # adjust based on data
    )
    par(bg = "blue")
    return(p)
  })
}

### add paired or two sample
