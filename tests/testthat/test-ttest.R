context("Testing ttest functionailty")
library(Kenometrics)
file = system.file("extdata", "hseinv.txt", package="Kenometrics")
data <- read.delim(file)

test_that("T-test with 0 mean", {
  linear_model <- lm(linv ~ lpop + lprice, data=data)
  result <- ttest("lpop", data, linear_model)
  expect_equal(result, "The t-value for lpop is 6.624, and the p-value is 3.469e-07."
  )
})

test_that("T-test with non-0 mean", {
  linear_model <- lm(linv ~ lpop + lprice, data=data)
  result <- ttest("lpop", data, linear_model, -1)
  expect_equal(result, "The t-value for lpop is 10.69, and the p-value is 2.148e-11."
  )
})
