context("Testing chow functionailty")
library(Kenometrics)
file <- system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd <- substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)
hseinv_data <- get_data("hseinv", "txt", file_loc=my_wd)
NASA_data <- get_data("NASA", "excel", file_loc=my_wd)
cement_data <- get_data("cement", "txt", file_loc=my_wd)
ezunem_data <- get_data("ezunem", "txt", file_loc=my_wd)

test_that("Chow test for both (intercept and slope) - no break", {
  output1 <- chow(1960, "year", hseinv_data, "linvpc ~ lpop", "both")
  expect_equal(dput(output1),
  "The dummies are NOT jointly significant; a structural break has NOT occured"
  )
})
test_that("Chow test for both (intercept and slope) - break", {
  output1 <- chow(1985, "year", ezunem_data, "uclms ~ c1", "both")
  expect_equal(dput(output1),
  "The dummies are jointly significant, so a structural break has occured"
  )
})


test_that("Chow test for intercept - no break", {
  output2 <- chow(1960, "year", hseinv_data, "linvpc ~ lpop", "intercept")
  expect_equal(dput(output2),
"The intercept dummy is NOT significant so a structural break has NOT occured"
  )
})
test_that("Chow test for intercept - break", {
  output2 <- chow(1983, "year", ezunem_data, "uclms ~ c1", "intercept")
  expect_equal(dput(output2),
  "The intercept dummy is significant so a structural break has occured"
  )
})


test_that("Chow test for slope - no break", {
  output3 <- chow(1960, "year", hseinv_data, "linvpc ~ lpop", "slope")
  expect_equal(dput(output3),
  "The slope dummy is NOT significant so a structural break has NOT occured"
  )
})
test_that("Chow test for slope - break", {
  output4 <-
    chow(1960, "year", cement_data, "ipcem ~ milemp + prcpet", "slope")
  expect_equal(dput(output4),
  "The slope dummy is significant so a structural break has occured"
  )
})


test_that("Test for typo", {
  output5 <-
    chow(1960, "year", cement_data, "ipcem ~ milemp + prcpet", "slp thing")
  expect_equal(dput(output5),
  "Please ensure one of intercept/slope/both is chosen"
  )
})

