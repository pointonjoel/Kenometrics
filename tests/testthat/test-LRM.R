context("Testing ttest functionailty")
library(Kenometrics)
file <- system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd <- substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)
fertil3_data <- get_data("fertil3", "txt", file_loc=my_wd)

test_that("LRM with fertil3 data", {
  long_run <- LRM("gfr", "pe", 3, other_vars=c("ww2", "pill"), df=fertil3_data)
  expect_equal(long_run,0.1007191)
})

