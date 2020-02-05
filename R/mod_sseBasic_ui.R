#' Shiny module UI function for the sse power.t.test module
#'
#' This shiny UI function to be used for sseBasic() server.
#'
#' @seealso \code{\link{sseBasic}}
#'
sseBasicUI <- function(id, label){
  box_width = 3
  box_height = 190
  ns <- NS(id)
  tabItem(label,
          br(), br(),
          h2("T - Test based sample size estimation"),
          fluidPage(
            fluidRow(
              br(),br(),
              p(""),
              br(),br()
            ),
            fluidRow(
              box(
                radioButtons(ns("in_type"), "Select a t-test type:", c("two-sample", "paired")),
              )
            ),
            fluidRow(
              box(
                title = "Power",
                radioButtons(ns("in_power"), "Select a power:", c(0.7, 0.8, 0.9, 0.95)),
                width = box_width,
                height = box_height
              ),
              box(
                title = "Significance level",
                radioButtons(ns("in_alpha"), HTML("Select a significance (&alpha;) level:"), c(0.01, 0.025, 0.05)),
                width = box_width,
                height = box_height
              ),
              box(
                title = "Effect size",
                sliderInput(ns("in_slider2"), "Select expected effect size:", 1, 50, 40),
                width = box_width,
                height = box_height
              ),
              box(
                title = "Standard deviation",
                sliderInput(ns("in_slider1"), "Select expected standard deviation:", 1, 80, 20),
                width = box_width,
                height = box_height
              )
            ),
            fluidRow(
              box(
                plotOutput(ns("out_plot1"), height = 250*2),
                width = 12,
                height = 250*2+20
              ),
            )
          )
  )
}
