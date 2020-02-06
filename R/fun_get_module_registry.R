#' Retrieves a list of module aliases
#'
#' Module aliases retrieved via get_module_registry() are used to define module IDs in shiny::callModule(),
#' and are also used as tabnames for the sidebar, and shiny UI function, label and id.
#'
#' @return list of strings containing module aliases
#' @seealso \code{\link{app_ui}}, \code{\link{app_server}}
#' @export
#'
get_module_registry <- function(){
  mod <- list()
  mod$sse_intro <- "sse_intro"
  mod$sse_ttest <- "sse_ttest"
  mod$sse_ttest_plus <- "sse_ttest_plus"
  mod$sse_prop <- "sse_prop"
  return(mod)
}
