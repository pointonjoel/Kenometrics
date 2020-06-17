context("Testing ttest functionailty")
library(Kenometrics)
file = system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd =substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)

test_that("Sourcing txt data", {
  hseinv_data <- get_data("hseinv", "txt", file_loc=my_wd)
  txt_cms <- colMeans(hseinv_data[sapply(hseinv_data, is.numeric)])
  expect_equal(txt_cms, c(year = 1967.5, inv = 104512.428571429, pop = 197380.880952381,
                          price = 0.912635714285714, linv = 11.5146321428571, lpop = 12.180785952381,
                          lprice = -0.093413280952381, t = 21.5, invpc = 0.521338214285714,
                          linvpc = -0.666155114285714)
  )
})

test_that("Sourcing excel data", {
  NASA_data <- get_data("NASA", type="excel", file_loc = my_wd)
  txt_cms <- colMeans(NASA_data)
  expect_equal(txt_cms, c(Year = 1949.5, No_Smoothing = 0.0431428571428571, `Lowess(5)` = 0.0432142857142857
  )
  )
})

test_that("Sourcing FRED data", {
  FRED_data <- get_data(name="CLVMNACSCAB1GQUK", type="FRED", key="864c07d6903d4ac4929bba42b1829355")
  GDP <- FRED_data$value[1]
  expect_equal(GDP, "180405.0"
  )
})

