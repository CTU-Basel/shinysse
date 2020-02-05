#' Main shiny UI function for shinysse
#'
#' Controls the general appearance, header, sidebar, body, tabs with modules, etc.
#'
#' @seealso \code{\link{app_server}}
#' @export
#'
app_ui <- function(){
  mod <- get_module_registry()
  dashboardPage(
    get_header_mint("SSE app"),
    dashboardSidebar(
      div(p(" ")),
      sidebarMenu(
        menuItem("Introduction", tabName = mod$app_intro, icon = icon("info")),
        menuItem("Two sample t-Test SSE", tabName = mod$sse_ttest, icon = icon("text-size", lib = "glyphicon")),
        menuItem("Two sample t-Test SSE + input", tabName = mod$sse_ttest_plus, icon = icon("text-size", lib = "glyphicon")),
        menuItem("Proportion Test SSE", tabName = mod$sse_prop, icon = icon("percentage"))
      )
    ),
    dashboardBody(
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "www/custom.css")
      ),
      tabItems(
        app_intro_ui(mod$app_intro, label = mod$app_intro),
        sse_ttest_ui(mod$sse_ttest, label = mod$sse_ttest),
        sse_ttest_plus_ui(mod$sse_ttest_plus, label = mod$sse_ttest_plus),
        sse_prop_ui(mod$sse_prop, label = mod$sse_prop)
      )
    )
  )
}
