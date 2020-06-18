context("Testing make_numeric functionailty")
library(Kenometrics)
file <- system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd <- substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)
hseinv_data <- get_data("hseinv", "txt", file_loc=my_wd)
TS_data <- make_ts("year", hseinv_data)

test_that("Converting TS to numeric", {
  non_TS_data <- make_numeric(TS_data, "year")
  TS_class <- class(TS_data[[1]])
  non_TS_class <- class(non_TS_data[[2]])
  expect_equal(c(TS_class, non_TS_class),
               c("yearmon", "numeric")
  )
})
