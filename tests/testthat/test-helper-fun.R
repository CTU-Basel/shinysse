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
  expect_equal(length(mod), 5)
})
