context("Helper functions")

head_label <- "Header Title"
head <-  get_header_mint(head_label)

test_that("Header check", {
  expect_equal(typeof(head), "list")
  expect_equal(class(head), "shiny.tag")
  expect_equal(head$children[[2]]$children[[1]], head_label)
})
