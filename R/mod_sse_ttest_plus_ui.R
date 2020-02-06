#' Shiny module UI function for the display of sse for t-test
#'
#' Enhanced version of \code{\link{sse_ttest}}. It allows users to input group means and
#' standard deviation, then plots the expected distribution of data points for these groups,
#' Additionally, it plots results of the power.t.test for the two-sample or paired t-test.
#'
#' @seealso \code{\link{sse_ttest_plus}}
#'
sse_ttest_plus_ui <- function(id, label){
  box_width <- 3
  box_height <- 230
  ns <- NS(id)
  tabItem(label,
          br(), br(),
          h2("T - Test based sample size estimation with input"),
          fluidPage(
            fluidRow(
              br(), br(),
              p("")
            ),
            fluidRow(
              box(
                radioButtons(ns("in_type"), "Select a t-test type:", c("two-sample", "paired")),
              )
            ),
            fluidRow(
              box(
                title = "Example data",
                numericInput(ns("mean_g1"), "Mean group 1:", 10, min = 1, max = 1000, step = 1),
                numericInput(ns("mean_g2"), "Mean group 2:", 15, min = 1, max = 1000, step = 1),
                sliderInput(ns("stdev"), "Standard deviation:", 1, 50, 30),
                # numericInput(ns("stdev"), "Standard deviation:", 10, min = 1, max = 50, step = 1),
                #textInput(ns("mean_g1"), value = 10, "Mean group 1"),
                width = 2,
                height = box_height * 1.5
              ),
              box(
                plotOutput(ns("out_plot_density")),
                width = 4,
                height = box_height * 1.5
              ),
              box(
                title = "Power",
                radioButtons(ns("in_power"), "Select a power:", c(0.7, 0.8, 0.9, 0.95)),
                width = box_width,
                height = box_height * 1.5
              ),
              box(
                title = "Significance level",
                radioButtons(ns("in_alpha"), HTML("Select a significance (&alpha;) level:"), c(0.01, 0.025, 0.05)),
                width = box_width,
                height = box_height * 1.5
              )
            ),
            fluidRow(
              box(
                plotOutput(ns("out_plot_sse"), height = 250 * 2),
                width = 12,
                height = 250 * 2 + 20
              ),
            )
          )
  )
}
