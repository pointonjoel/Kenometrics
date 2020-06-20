context("Testing get_data functionailty")
library(Kenometrics)
file <-  system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd <- substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)

test_that("Sourcing txt data", {
  hseinv_data <- get_data("hseinv", "txt", file_loc=my_wd)
  lpop_data <- dput(hseinv_data[["lpop"]])
  expect_equal(lpop_data,
               c(11.87844, 11.89567, 11.91296, 11.92955, 11.94657, 11.96371,
                 11.98021, 11.99776, 12.01537, 12.03303, 12.05102, 12.06762,
                 12.08858, 12.10443, 12.12101, 12.13639, 12.15078, 12.16467,
                 12.17717, 12.18872,  12.19961, 12.2096, 12.21937, 12.23102,
                 12.2414, 12.25178, 12.26215, 12.27253, 12.28291, 12.29353,
                 12.30416, 12.31478, 12.32541, 12.33603, 12.34644, 12.35673,
                 12.36648, 12.37582, 12.38539, 12.39514, 12.40465, 12.41442
                 )
  )
})

test_that("Sourcing excel data", {
  NASA_data <-
    get_data("NASA", type="excel",
             file_loc = my_wd
             )
  txt_cms <- colMeans(NASA_data)
  expect_equal(txt_cms,
               c(Year = 1949.5,
                 No_Smoothing = 0.0431428571428571,
                 `Lowess` = 0.0432142857142857
  )
  )
})

