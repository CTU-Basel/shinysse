#' Evaluates power -function for power.t.test
#'
#' For all pre-set combinations of n, theta, xi and alpha, this function calculates a list of powPar (package: sse)
#' objects and saves them at a pre-set location in inst/extdata. The function uses the stats::power.t.test for
#' this purpose. Make sure to re-build the package after running the function, in order to make it available
#'
#' @param type character string specifying the type of t test. options: "two.sample", "one.sample", "paired"
#' @return list of calculated powPar objects
#' @export
#'
fun_calc_t <- function(type = "two.sided"){
  print(type)
  ## define range of significance levels
  alpha <- c(0.01, 0.025, 0.05)
  ## defining the range of n and theta to be evaluated
  psi_t <- powPar(n = seq(from = 5, to = 2000, by = 5), # possible range of sample sizes
                  theta = seq(from = 1, to = 50, by = 1), # possible range of effect sizes
                  xi = seq(from = 1, to = 80, by = 1)) # possible range of standard deviations
  ## defining a power-function based on a power.t.test
  powFuns_t <- list()
  for(i in 1:length(alpha)){
    eval(parse(text = paste(paste0("powFuns_t[[", paste0("'alpha", sub(".", "p", alpha[i], fixed = TRUE)), "']]", " <- function(psi)"),
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
  ## evaulate power-function for all combinations of n, theta, xi and alpha
  calc_t <- map(powFuns_t, ~powCalc(psi_t, .))
  ## save calcs to be used in the shiny app
  save_path <- file.path("inst", "extdata", paste0("calc_t_test_", type, ".rds"))
  saveRDS(calc_t, save_path)
  return(calc_t)
}
