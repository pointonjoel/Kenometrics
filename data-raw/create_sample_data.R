set.seed(100)
library(tibble)
x = rnorm(100)
y = 2*x + rnorm(100)
sample_data = data.frame(x = x, y = y)

usethis::use_data(sample_data, compress = "xz")
