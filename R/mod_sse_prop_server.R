#' Shiny module server function for the sse power.prop.test module
#'
#' @seealso \code{\link{sse_prop_ui}}
#'
sse_prop <- function(input, output, session, calcs){
  ## define parameters and plot

  ## check if p1 p2 difference is in range
  p_diff <- reactive({
    p1 <- as.numeric(input$in_slider2)
    p2 <- as.numeric(input$in_slider1)
    sigLevel <- as.numeric(input$in_alpha)
    power <- as.numeric(input$in_power)

    p_diff_val <- as.numeric(toString(max(c(p1, p2)) - min(c(p1, p2))))
    validate({
      need(p_diff_val > 0,
           "Difference in probabilities in group 1 and 2 is outside of plottable range. It must be > 0 and <= 0.5")
      if (p_diff_val > 0.5){
        calcAppx <- power.prop.test(n = NULL,
                                    p1 = p1,
                                    p2 = p2,
                                    sig.level = sigLevel,
                                    power = power)
        need(p_diff_val <= 0.5,
             paste0("Difference in probabilities in group 1 and 2 is outside of plottable range. ",
                    "It must be > 0 and <= 0.5. The estimated sample size is ", ceiling(calcAppx$n * 2)))
      }
    })
    p_diff_val
  })

  output$out_plot1 <- renderPlot({
    sigLevel <- as.numeric(input$in_alpha)
    power <- as.numeric(input$in_power)
    p1 <- as.numeric(input$in_slider2)
    p2 <- as.numeric(input$in_slider1)
    calc <- calcs[[paste0("alpha", sub(".", "p", sigLevel, fixed = TRUE))]]

    ## validate
    validate({
      need(p_diff() > 0,
           "Difference in probabilities in group 1 and 2 is outside of plottable range. It must be > 0 and <= 0.5")
    })

    ## calculate an example sample size for given parameters
    example <- powEx(calc, theta = p_diff(), xi = p1, power = power)

    calcN <- tex(example, type = "nEval")

    ## dynamically define x and y axis limits for a nicer plotting experience
    ylim <- c(0, 10000)
    if (calcN < 10) {
      ylim <- c(0, 20)
    } else if (calcN < 50) {
      ylim <- c(0, 100)
    } else if (calcN < 250) {
      ylim <- c(0, 500)
    } else if (calcN < 500) {
      ylim <- c(0, 1000)
    } else if (calcN < 2000) {
      ylim <- c(0, 4000)
    }

    p <- plot(example,
              # xi = sd, # this should come from radio button chosen sig lev
              at = c(0.7, 0.8, 0.9, 0.95), # 3 possible values for power
              ylab = "sample size",
              xlab = "probability difference",
              ylim = ylim # adjust dynamically
    )
    par(bg = "blue")
    return(p)
  })
}
