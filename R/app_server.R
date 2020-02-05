#' Main Shiny server function for shinysse
#'
#' Calls modules listed in app_ui, and passes on relevant data.
#'
#' @seealso \code{\link{app_ui}}, \code{\link{run_shiny}}
#' @export
#'
app_server <- function(input, output) {
  # fetch calc data from extdata
  calc_t_twosample <- readRDS(system.file("extdata", "calc_t_test_twosample.rds", package = "shinysse"))
  calc_t_paired <- readRDS(system.file("extdata", "calc_t_test_paired.rds", package = "shinysse"))
  calc_prop <- readRDS(system.file("extdata", "calc_prop_test.rds", package = "shinysse"))
  # get module labels and then call
  mod <- get_module_registry()
  callModule(app_intro, mod$app_intro)
  callModule(sse_ttest, mod$sse_ttest, calc_t_twosample, calc_t_paired)
  callModule(sse_ttest_plus, mod$sse_ttest_plus, calc_t_twosample)
  callModule(sse_prop, mod$sse_prop, calc_prop)
}
