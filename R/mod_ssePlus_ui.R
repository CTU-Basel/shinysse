#' Shiny module UI function for the sse power.t.test module with user input
#'
#' This UI gives the user an opportunity to enter two group means as numeric inputs, in addition to standard deviation,
#' etc.
#'
#' @seealso \code{\link{ssePlus}}
#'
ssePlusUI <- function(id, label){
  box_width = 3
  box_height = 230
  ns <- NS(id)
  tabItem(label,
          br(), br(),
          h2("T - Test based sample size estimation with input"),
          fluidPage(
            fluidRow(
              br(),br(),
              p(""),
              br(),br()
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
