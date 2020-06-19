context("Testing make_TS functionailty")
library(Kenometrics)
file <-  system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd <- substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)
hseinv_data <- get_data("hseinv", "txt", file_loc=my_wd)
ezanders_data <- get_data("ezanders", "txt", file_loc=my_wd)

test_that("Making Time Series - year, all", {
  TS_data <- make_ts("year", hseinv_data)
  expect_equal(class(TS_data$year), "yearmon"
  )
})
test_that("Making Time Series - year, specific. lpop changed? ", {
  TS_data <- make_ts("year", hseinv_data, vars = c("linvpc", "lpop"))
  expect_equal(class(TS_data$lpop), "zoo"
  )
})
test_that("Making Time Series - year, specific. pop unchanged?", {
  TS_data <- make_ts("year", hseinv_data, vars = c("linvpc", "lpop"))
  expect_equal(class(TS_data$pop), "integer"
  )
})
test_that("Making Time Series - year/month, all", {
  TS_data <- make_ts(c("year", "month"), ezanders_data)
  expect_equal(class(TS_data$year), "zoo"
  )
})
test_that("Making Time Series - year/month, all. luclms changed? ", {
  TS_data <- make_ts(c("year", "month"), ezanders_data, c("luclms"))
  expect_equal(class(TS_data$luclms), "zoo"
  )
})
test_that("Making Time Series - year/month, all. year unchanged?", {
  TS_data <- make_ts(c("year", "month"), ezanders_data, c("luclms"))
  expect_equal(class(TS_data$year), "integer"
  )
})
