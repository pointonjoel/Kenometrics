context("Testing get_data functionailty")

test_that("Whether the get_data function works", {


  file = system.file("extdata", "NASA.xlsx", package="Kenometrics")
  my_wd =substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)

  #Testing woodlridge data using hseinv
  library(wooldridge)
  data(hseinv)
  head(hseinv)
  wool_cms <- colMeans(hseinv[sapply(hseinv, is.numeric)])
  expect_equal(wool_cms, c(year = 1967.5, inv = 104512.428571429, pop = 197380.880952381,
                           price = 0.912635718073164, linv = 11.5146317027864, lpop = 12.1807868140084,
                           lprice = -0.0934132829508079, t = 21.5, invpc = 0.521338218024799,
                           linvpc = -0.666155116189094, lprice_1 = NA, linvpc_1 = NA, gprice = NA,
                           ginvpc = NA
                           )
               )

  #Testing txt using NASA
  NASA_data <- get_data("NASA", type="excel", file_loc = my_wd)
  txt_cms <- colMeans(NASA_data)
  expect_equal(txt_cms, c(Year = 1949.5, No_Smoothing = 0.0431428571428571, `Lowess(5)` = 0.0432142857142857
                          )
               )
})
