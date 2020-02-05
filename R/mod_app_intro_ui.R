#' Shiny module ui for the sse introduction page
#'
#' @seealso \code{\link{app_intro}}
#'
app_intro_ui <- function(id, label){
  ns <- NS(id)
  tabItem(label,
          br(), br(),
          h2("Sample size estimation"),
          fluidPage(
            fluidRow(
              br(), br(),
              box(p("DISCLAIMER:"), br(),
                  p("This app is designed for demonstration purposes only,
            and cannot replace a well crafted statistical modelling performed by a skilled statistician."))),
            fluidRow(
              p("Sample size estimation is the process of estimating
                the number of replicates to include in a statistical study."),
              p("It crucially depends on several variables:"),
              tags$ul(
                tags$li("Chosen test statistics"),
                tags$li("Expected effect size"),
                tags$li("Target test power"),
                tags$li("Target alpha level"),
                tags$li("Expected variance")
              ),
              p("This app consists of several tabs, each representing a different test statistics:"),
              tags$ul(
                tags$li("Two sample t-test"),
                tags$li("Paired t-test"),
                tags$li("Proportion test")
              )
            )
          )
  )
}
