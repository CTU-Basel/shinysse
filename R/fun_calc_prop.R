#' Evaluates power functions for power.prop.test
#'
#' For all pre-set combinations of n, theta, xi and alpha, this function calculates a list of powCalc
#' objects and saves.
#'
#' Input parameters are optional. Defaults:\cr
#' n <- seq(from = 3, to = 10000, by = 5)\cr
#' theta <- c(seq(from = 0, to = 0.15, by = 0.0125), seq(from = 0.2, to = 0.5, by = 0.05))\cr
#' xi <- seq(from = 0.05, to = 1, by = 0.05)\cr
#' alpha <- c(0.01, 0.025, 0.05)\cr
#' save_path <- file.path("inst", "extdata", "calc_prop_test.rds")\cr
#'
#' @param n numeric vector containing possible range of sample sizes
#' @param theta numeric vector containing possible range of effect sizes
#' @param xi numeric vector containing possible range of proportions
#' @param alpha numeric vector containing possible range of significance levels
#' @return list of calculated powCalc objects
#' @export
#'
calc_prop <- function(n, theta, xi, alpha, save_path){
  if (missing(n)) n <- seq(from = 3, to = 10000, by = 5)
  if (missing(theta)) theta <- c(seq(from = 0, to = 0.15, by = 0.0125), seq(from = 0.2, to = 0.5, by = 0.05))
  if (missing(xi)) xi <- seq(from = 0.05, to = 1, by = 0.05)
  if (missing(alpha)) alpha <- c(0.01, 0.025, 0.05)
  if (missing(save_path)) save_path <- file.path("inst", "extdata", "calc_prop_test.rds")

  ## defining power parameters needed for power fun evluation later on
  psi_prop <- powPar(n = n, theta = theta, xi = xi)
  ## defining a power fun based on a power.prop.test and parameters set in powPar
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
  saveRDS(calc_prop, save_path)
  return(calc_prop)
}
