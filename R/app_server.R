#' Shiny main app server function for shinysse
#'
#' Calls modules defined in app_ui, and passes on relevant data.
#'
#' @seealso \code{\link{app_ui}}, \code{\link{run_shiny}}
#' @export
#'
app_server <- function(input, output) {
  # data
  calc_t_twosample <- readRDS(system.file("extdata", "calc_t_test_twosample.rds", package = "shinysse"))
  calc_t_paired <- readRDS(system.file("extdata/calc_t_test_paired.rds", package = "shinysse"))
  calc_prop <- readRDS(system.file("extdata/calc_prop_test.rds", package = "shinysse"))
  # modules
  mod <- get_module_registry()
  callModule(intro, mod$intro)
  callModule(sse_t_test, mod$sse_t_test, calc_t_twosample, calc_t_paired)
  callModule(ssePlus, mod$sse_plus, calc_t_twosample)
  callModule(ssePlus, mod$sse_plus_paired, calc_t_paired)
  callModule(sseProp, mod$sse_prop, calc_prop)
}
