context("Helper functions")

## test mint header
head_label <- "Header Title"
head <-  get_header_mint(head_label)

test_that("Header check", {
  expect_equal(typeof(head), "list")
  expect_equal(class(head), "shiny.tag")
  expect_equal(head$children[[2]]$children[[1]], head_label)
})

## test module registry
mod <- get_module_registry()

test_that("Module registry", {
  expect_equal(typeof(mod), "list")
  expect_equal(length(mod), 4)
})

## test calc_prop
n <- seq(from = 1, to = 10, by = 1)
theta <- seq(from = 0, to = 0.5, by = 0.1)
xi <- seq(from = 0.1, to = 1, by = 0.1)
alpha <- c(0.01, 0.025)
save_path <- file.path("test_calc_prop.rds")
suppressWarnings(suppressMessages(
  calcs_prop <- calc_prop(n, theta, xi, alpha, save_path)
))
test_that("Power calc proportions", {
  expect_equal(class(calcs_prop), "list")
  expect_equal(length(calcs_prop), 2)
  expect_equal(class(calcs_prop[[1]])[[1]], "powCalc")
  expect_true(file.exists(save_path))
})

file.remove(save_path)

## test calc_t
n <- seq(from = 1, to = 10, by = 1)
theta <- seq(from = 0, to = 10, by = 1)
xi <- seq(from = 1, to = 10, by = 1)
alpha <- c(0.01, 0.025)
type <- "paired"
save_path <- file.path("test_calc_t.rds")
suppressWarnings(suppressMessages(
  calcs_t <- calc_t(n, theta, xi, alpha, type, save_path)
))
test_that("Power calc proportions", {
  expect_equal(class(calcs_prop), "list")
  expect_equal(length(calcs_prop), 2)
  expect_equal(class(calcs_prop[[1]])[[1]], "powCalc")
  expect_true(file.exists(save_path))
})

file.remove(save_path)
