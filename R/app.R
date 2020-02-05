#' Runs the shinysse Shiny application
#'
#' This runs the shinysse Shiny web application. You can run the application by
#' calling the run_shiny() function.
#'
#' @seealso \code{\link{app}},\code{\link{app_ui}}
#' @export
#'
run_shiny <- function(){
    ## with addResourcePath, one can make resources available in the global environment
    ## this is needed for www since we keep it at a non-standard location for shiny term
    addResourcePath('www', system.file('www', package = 'shinysse'))
    shinyApp(ui = app_ui, server = app_server)
}
