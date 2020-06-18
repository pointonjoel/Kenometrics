context("Testing make_TS functionailty")
library(Kenometrics)
file <-  system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd <- substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)

test_that("Making Time Series", {
  hseinv_data <- get_data("hseinv", "txt", file_loc=my_wd)
  TS_data <- make_ts("year", hseinv_data)
  expect_equal(class(TS_data$year), "yearmon"
  )
})
