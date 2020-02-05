#' Runs the shinysse Shiny application
#'
#' You can run the web application by alling the run_shiny() function.
#'
#' @seealso \code{\link{app}},\code{\link{app_ui}}
#' @export
#'
run_shiny <- function(){
    ## make resources available globally from non standard location
    addResourcePath("www", system.file("www", package = "shinysse"))
    shinyApp(ui = app_ui, server = app_server)
}
