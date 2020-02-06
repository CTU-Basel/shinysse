#' Evaluates power functions for power.t.test
#'
#' For all pre-set combinations of n, theta, xi and alpha, this function calculates a list of powCalc
#' objects and saves the list.
#'
#' Input parameters are optional. Defaults:
#' * n <- seq(from = 5, to = 2000, by = 5)
#' * theta <- seq(from = 1, to = 50, by = 1)
#' * xi <- seq(from = 1, to = 80, by = 1)
#' * alpha <- c(0.01, 0.025, 0.05)
#' * save_path <- file.path("inst", "extdata", "calc_t_test.rds")
#' @md
#' @param n numeric vector containing possible range of sample sizes
#' @param theta numeric vector containing possible range of effect sizes
#' @param xi numeric vector containing possible range of standard deviations
#' @param alpha numeric vector containing possible range of significance levels
#' @param type string of value "two.sample", "one.sample", or "paired"
#' @param save_path string inidicating where the function output should be saved
#' @return list of calculated powCalc objects
#' @seealso \code{\link{calc_prop}}
#' @export
#'
calc_t <- function(n, theta, xi, alpha, type, save_path){
  if (missing(n)) n <- seq(from = 5, to = 2000, by = 5)
  if (missing(theta)) theta <- seq(from = 1, to = 50, by = 1)
  if (missing(xi)) xi <- seq(from = 1, to = 80, by = 1)
  if (missing(alpha)) alpha <- c(0.01, 0.025, 0.05)
  if (missing(type)) type <- "two.sample"
  if (missing(save_path)) save_path <- file.path("inst", "extdata", "calc_t_test.rds")

  ## defining the range of n and theta to be evaluated
  psi_t <- powPar(n = n, theta = theta, xi = xi)
  ## defining a power fun based on a power.t.test
  powFuns_t <- list()
  for (i in 1:length(alpha)){
    eval(parse(text =
      paste(paste0("powFuns_t[[", paste0("'alpha", sub(".", "p", alpha[i], fixed = TRUE)), "']]", " <- function(psi)"),
            "{",
            "power.t.test(n = sse::n(psi)/2,",
            "delta = theta(psi),",
            "sd = xi(psi),",
            paste0("sig.level = ", alpha[i], ","),
            "power = NULL,",
            paste0("type = '", type, "'"),
            ")$power",
            "}", sep = "\n")))
  }
  ## evaulates power function for all combinations of n, theta, xi and alpha
  calc_t <- map(powFuns_t, ~powCalc(psi_t, .))
  ## save calcs to be used in the shiny app
  saveRDS(calc_t, save_path)
  return(calc_t)
}
