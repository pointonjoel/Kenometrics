context("Testing get_data functionailty")
library(Kenometrics)
file = system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd =substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)

test_that("Sourcing txt data", {
  hseinv_data <- get_data("hseinv", "txt", file_loc=my_wd)
  chow(1960, "year", data, "linvpc ~ lpop", "both")
  expect_equal(txt_cms, c(year = 1967.5, inv = 104512.428571429, pop = 197380.880952381,
                          price = 0.912635714285714, linv = 11.5146321428571, lpop = 12.180785952381,
                          lprice = -0.093413280952381, t = 21.5, invpc = 0.521338214285714,
                          linvpc = -0.666155114285714)
  )
})

Make sure its equal to:
  "The dummies are NOT jointly significant, so a structural break in the intercept"
[2] "and slope has NOT occured"

but 2 lines??
