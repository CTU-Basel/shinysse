#' Shiny main app UI function for shinysse
#'
#' Controls the general appearance, header, sidebar, body, modules, etc.
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
        menuItem("Introduction", tabName = mod$intro, icon = icon("info")),
        menuItem("Two sample t-Test SSE", tabName = mod$sse_basic, icon = icon("text-size", lib = "glyphicon")),
        menuItem("Two sample t-Test SSE + input", tabName = mod$sse_plus, icon = icon("text-size", lib = "glyphicon")),
        menuItem("Paired t-Test SSE + input", tabName = mod$sse_plus_paired, icon = icon("text-size", lib = "glyphicon")),
        menuItem("Proportion Test SSE", tabName = mod$sse_prop, icon = icon("percentage"))
      )
    ),
    dashboardBody(
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "www/custom.css")
      ),
      tabItems(
        introUI(mod$intro, label = mod$intro),
        sseBasicUI(mod$sse_basic, label = mod$sse_basic),
        ssePlusUI(mod$sse_plus, label = mod$sse_plus),
        ssePlusUI(mod$sse_plus_paired, label = mod$sse_plus_paired),
        ssePropUI(mod$sse_prop, label = mod$sse_prop)
      )
    )
  )
}
