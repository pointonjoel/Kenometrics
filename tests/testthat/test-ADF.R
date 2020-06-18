context("Testing chow functionailty")
library(Kenometrics)
file <- system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd <- substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)
hseinv_data <- get_data("hseinv", "txt", file_loc=my_wd)

test_that("ADF with NS variable", {
  ADF_data <- ADF("lpop", hseinv_data, type="type1")
  new_column <- ADF_data[["lpop_diff"]]
  expect_equal(dput(new_column),
               c(NA, 0.0172300000000014, 0.0172899999999991,
                 0.0165900000000008, 0.0170199999999987,
                 0.0171400000000013, 0.0164999999999988,
                 0.01755, 0.0176100000000012, 0.0176599999999993,
                 0.0179899999999993, 0.0166000000000004,
                 0.0209600000000005, 0.0158500000000004,
                 0.0165799999999994, 0.0153800000000004,
                 0.0143899999999988, 0.01389, 0.0125000000000011,
                 0.0115499999999997, 0.0108899999999998,
                 0.00999000000000017, 0.00976999999999961,
                 0.0116499999999995, 0.0103800000000014,
                 0.0103799999999996, 0.01037,
                 0.0103799999999996, 0.0103799999999996,
                 0.0106200000000012, 0.010629999999999,
                 0.0106200000000012, 0.010629999999999,
                 0.0106199999999994, 0.0104100000000003,
                 0.0102900000000012, 0.00974999999999859,
                 0.0093399999999999,
                 0.00957000000000008, 0.00975000000000037,
                 0.00951000000000057, 0.00976999999999961)
  )
})
test_that("ADF with stationary variable", {
  ADF_data <- ADF("lpop", hseinv_data, type="type2")
  new_column <- ADF_data[["lpop_diff"]]
  expect_equal(dput(new_column), NULL
  )
})
