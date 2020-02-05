#' Retrieves a list of module names
#'
#' These names will be used to define module IDs in shiny::callModule(),
#' and also as tabnames for the sidebar, and shiny UI function label and id.
#'
#' @return list of strings containing names of
#' @seealso \code{\link{app_ui}}, \code{\link{app_server}}
#' @export
#'
get_module_registry <- function(){
  mod <- list()
  mod$intro <- "intro"
  mod$sse_basic <- "sse_basic"
  mod$sse_plus <- "sse_plus"
  mod$sse_plus_paired <- "sse_plus_paired"
  mod$sse_prop <- "sse_prop"
  return(mod)
}
