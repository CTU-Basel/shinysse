#' Shiny module UI function for the sse power.prop.test module
#'
#' @seealso \code{\link{sseProp}}
#'
ssePropUI <- function(id, label){
  box_width = 3
  box_height = 190
  ns <- NS(id)
  tabItem(label,
          br(), br(),
          h2("Proportion Test based sample size estimation"),
          fluidPage(
            fluidRow(
              br(),br(),
              p(""),
              br(),br()
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
                title = "Probability in group 1",
                sliderInput(ns("in_slider1"), "Select expected probability:", 0, 0.95, 0.5, step = 0.05),
                width = box_width,
                height = box_height
              ),
              box(
                title = "Probability in group 2",
                sliderInput(ns("in_slider2"), "Select expected probability:", 0.05, 1, 0.35, step = 0.05),
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
