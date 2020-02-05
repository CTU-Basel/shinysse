#' Evaluates power -function for power.prop.test
#'
#' For all pre-set combinations of n, theta, xi and alpha, this function calculates a list of powPar (package: sse)
#' objects and saves them at a pre-set location in inst/extdata. The function uses the stats::power.prop.test for
#' this purpose. Make sure to re-build the package after running the function, in order to make it available
#' with package installation.
#'
#' @return list of calculated powPar objects
#' @export
#'
fun_calc_prop <- function(){
  ## define range of significance levels
  alpha <- c(0.01, 0.025, 0.05)
  ## defining the range of n and theta to be evaluated
  psi_prop <- powPar(n = seq(from = 3, to = 10000, by = 5), # possible range of sample sizes
                     theta = c(seq(from = 0, to = 0.15, by = 0.0125),
                               seq(from = 0.2, to = 0.5, by = 0.05)), # possible range of effect sizes
                     xi = seq(from = 0.05, to = 1, by = 0.05)) # possible range of proportions

  ## defining a power fun based on a power.prop.test
  powFuns_prop <- list()
  for (i in 1:length(alpha)){
    eval(parse(text = paste(paste0("powFuns_prop[[", paste0("'alpha", sub(".", "p", alpha[i], fixed = TRUE)), "']]",
                                   " <- function(psi)"),
                            "{",
                            "p1 = xi(psi)",
                            "power.prop.test(n = sse::n(psi)/2,",
                            "p1 = p1,",
                            "p2 = p1-theta(psi),",
                            paste0("sig.level = ", alpha[i], ","),
                            "power = NULL",
                            ")$power",
                            "}", sep = "\n")))
  }
  ## evaulate power function for all combinations of n, theta, xi and alpha
  calc_prop <- map(powFuns_prop, ~powCalc(psi_prop, .))
  ## save calcs to be used in the shiny app
  save_path <- file.path("inst", "extdata", "calc_prop_test.rds")
  saveRDS(calc_prop, save_path)
  return(calc_prop)
}
