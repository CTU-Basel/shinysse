#' Shiny module server function for the sse power.t.test module with user input
#'
#' This shiny server function to be used for sse_ttest_plus_ui().
#'
#' @seealso \code{\link{sse_ttest_plus_ui}}
#'
sse_ttest_plus <- function(input, output, session, calcs_twosample, calcs_paired){
  ## validity checks
  effSize <- reactive({
    m1 <- input$mean_g1
    m2 <- input$mean_g2
    effSize_val <- abs(m1 - m2)
    validate({
      need( ( (m1 %% 1) == 0) & ( (m2 %% 1) == 0),
            "Only integers are allowed for group means")
      need( (effSize_val >= 5) & (effSize_val <= 50),
           "The difference in expected means between group 1 and group 2 should be >=5 and <= 50.")
    })
    return(effSize_val)
  })
  ## density plot
  output$out_plot_density <- renderPlot({
    mean_g1 <- input$mean_g1
    mean_g2 <- input$mean_g2
    sd <- as.numeric(input$stdev)
    ## generate example data
    d1 <- data.frame(
      dat = rnorm(10000, mean = mean_g1, sd = sd),
      group = "group 1")
    d2 <- data.frame(
      dat = rnorm(10000, mean = mean_g2, sd = sd),
      group = "group 2")
    dat <- rbind(d1, d2)
    ## generate plot for example data
    p <- ggplot(dat, aes(dat, colour = group, fill = group)) +
      geom_density(alpha = 0.1, adjust = 2) +
      theme(legend.position = "none",
            axis.title.x = element_blank(),
            axis.line = element_line(size = 0.5, colour = "grey"),
            panel.background = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.border = element_blank())
    return(p)
  },
  height = 270, width = 285)


  ## sse plot
  output$out_plot_sse <- renderPlot({
    ## get input
    sigLevel <- as.numeric(input$in_alpha)
    power <- as.numeric(input$in_power)
    sd <- as.numeric(input$stdev)
    if (input$in_type == "paired"){
      calcs <- calcs_paired
    } else{
      calcs <- calcs_twosample
    }

    calc <- calcs[[paste0("alpha", sub(".", "p", sigLevel, fixed = TRUE))]]
    example <- powEx(calc, theta = effSize(), xi = sd, power = power)

    calcN <- tex(example, type = "nEval")
    ## validations
    validate({
      calcAppx <- list(n = calcN)
      if (is.na(calcN)){
        calcAppx <- power.t.test(n = NULL,
                                 delta = effSize(),
                                 sd = sd,
                                 sig.level = sigLevel,
                                 power = power)
      }
      need( !is.na(calcN),
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
              ylim = ylim # adjust dynamically
    )
    return(p)
  })
}
