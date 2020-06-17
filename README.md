Readme
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

# Kenometrics

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/pointonjoel/Kenometrics/branch/master/graph/badge.svg)](https://codecov.io/gh/pointonjoel/Kenometrics?branch=master)
<!-- badges: end -->

The goal of Kenometrics is to provide a set of functions which allow
econometrics students to simply conduct important manipulations and
tests.

## Installation

You can install the released version of Kenometrics from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("Kenometrics")
```

To install the latest development version from GitHub:

``` r
install.packages("remotes")
remotes::install_github("pointonjoel/Kenometrics")
```

## Overview

The Kenometrics package enables lecturers and students to teach and
implement fundemental econometric techniques. Below is a summary of the
functions on offer and how they can be used:

<body>

<ul>

<li>

<b>get\_data()</b> <i>A single function to find and source data from a
variety of sources (Wooldridge, FRED, txt, Excel)</i>

</li>

<li>

<b>ttest()</b> <i>Conduct a t-test (with a specific hypothesised mean,
not necessarily 0)</i>

</li>

<li>

<b>make\_ts()</b> <i>Make the data time-series (to allow for lagged
variables etc.)</i>

</li>

<li>

<b>chow()</b> <i>Conduct a chow test (it adds an intercept and dummy
slope and tests the significance depending on if one is testing for a
break in the intercept, slope or both)</i>

</li>

<li>

<b>ADF()</b> <i>Conduct an ADF test (and if the data are non stationary,
it adds the first-difference to the data frame)</i>

</li>

<li>

<b>LRM()</b> <i>Find and test the significance of the long run
multiplier</i>

</li>

</ul>

</body>

The Kenometrics package takes many existing packages and incorporates
them as dependencies, simplifying the existing functions they provide.
Dependencies include, but are not limited to: wooldridge, zoo, dynlm,
fredr, readxl and tseries. Having all of these bundled into one package
and harnessed for econometrics means that students can quickly begin
putting theory into practice. Without Kenometrics, testing for
non-stationary data, for example, can be long-winded and and require
multiple packages. However, Kenometrics similifies the code into one
line and includes all other necessary packages. Although, students are
encouraged to look into the code, which is written in a simple and
intuitive way, to see how they could complete the data manipulations
without Kenometrics.

## Importing data

When importing data, students may often be overwhelmed with the
specifics needed when importing from a variety of sources. The having
one function complete with FRED and Excel integration simplies things
further.

To import data to the current environment, there are two ways depending
on the type of data. It is reccomended that users also import the
[wooldridge
package](https://cran.r-project.org/web/packages/wooldridge/index.html),
which contains all of the [datasets used in the textbook’s
examples](https://www.cengage.com/aise/economics/wooldridge_3e_datasets/):

``` r
library(Kenometrics)
library(wooldridge)
data(hseinv)
#Then the dataset can be previewed (and manipulated)
head(hseinv)
#>   year   inv    pop  price     linv     lpop     lprice t     invpc     linvpc
#> 1 1947 54864 144126 0.8190 10.91261 11.87844 -0.1996712 1 0.3806669 -0.9658305
#> 2 1948 64717 146631 0.8649 11.07778 11.89567 -0.1451414 2 0.4413596 -0.8178953
#> 3 1949 63150 149188 0.8456 11.05327 11.91296 -0.1677088 3 0.4232914 -0.8596944
#> 4 1950 86014 151684 0.8765 11.36227 11.92955 -0.1318186 4 0.5670605 -0.5672894
#> 5 1951 70610 154287 0.8819 11.16493 11.94657 -0.1256766 5 0.4576536 -0.7816427
#> 6 1952 68574 156954 0.8842 11.13567 11.96371 -0.1230720 6 0.4369051 -0.8280393
#>     lprice_1   linvpc_1       gprice      ginvpc
#> 1         NA         NA           NA          NA
#> 2 -0.1996712 -0.9658305  0.054529801  0.14793521
#> 3 -0.1451414 -0.8178953 -0.022567436 -0.04179913
#> 4 -0.1677088 -0.8596944  0.035890266  0.29240507
#> 5 -0.1318186 -0.5672894  0.006141976 -0.21435338
#> 6 -0.1256766 -0.7816427  0.002604567 -0.04639655
```

Kenometrics provides support for a variety of other types of datasets.
Simply specify the name of the file/dataset and the type of data.

``` r
#Code needed to obtain the NASA file on the user's computer
file = system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd =substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)
#Once the working directory has been obtained, the get_data function can be used
NASA_data <- get_data("NASA", type="excel", file_loc = my_wd)
print(NASA_data)
#> # A tibble: 140 x 3
#>     Year No_Smoothing `Lowess(5)`
#>    <dbl>        <dbl>       <dbl>
#>  1  1880        -0.16       -0.09
#>  2  1881        -0.08       -0.12
#>  3  1882        -0.1        -0.16
#>  4  1883        -0.17       -0.2 
#>  5  1884        -0.28       -0.23
#>  6  1885        -0.32       -0.25
#>  7  1886        -0.3        -0.26
#>  8  1887        -0.35       -0.26
#>  9  1888        -0.16       -0.26
#> 10  1889        -0.1        -0.25
#> # ... with 130 more rows
```

Whilst the function defaults the working directory to the current
location of the workspace, students are encouraged to set a working
directory prior to sourcing data. This can be done by using:

``` r
my_wd="C:/Documents"
#And then for usage
#setwd(my_wd)
```

Note the use of “/” rather than "", as is customary in R.

Students can also import files from FRED using Kenometrics, once they
have obtained a [FRED API
key](https://research.stlouisfed.org/docs/api/api_key.html), which is
simple and free. For examples, see:

``` r
?get_data
#> starting httpd help server ... done
```

## T-tests

Once data has been imported, a t-test can then be conducted. Ordinarily,
this is possible through the completing a linear regression and finding
the summary of it.

``` r
simple_model <- lm(lprice ~ lpop + linvpc , data=hseinv)
summary(simple_model)
#> 
#> Call:
#> lm(formula = lprice ~ lpop + linvpc, data = hseinv)
#> 
#> Residuals:
#>       Min        1Q    Median        3Q       Max 
#> -0.054007 -0.030110 -0.000722  0.016743  0.084962 
#> 
#> Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) -4.068122   0.566440  -7.182 1.21e-08 ***
#> lpop         0.326166   0.045171   7.221 1.07e-08 ***
#> linvpc      -0.002631   0.041633  -0.063     0.95    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.03788 on 39 degrees of freedom
#> Multiple R-squared:  0.6613, Adjusted R-squared:  0.6439 
#> F-statistic: 38.07 on 2 and 39 DF,  p-value: 6.8e-10
```

However, this assumes that the hypothesised population mean is 0; there
is no scope to change it. To conduct a T-Test where there is a non-0
population mean is simple with Kenometrics:

``` r
#t_stat <- ttest("linvpc", some_data, "simple_model", pop_mean = -1)
#print(t_stat)
```

``` r
chow(1960, "year", hseinv, "linvpc ~ lpop", "both")
#> 
#> Time series regression with "numeric" data:
#> Start = 1, End = 42
#> 
#> Call:
#> dynlm(formula = new_model, data = df)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -0.46825 -0.06333 -0.00423  0.08076  0.28312 
#> 
#> Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)
#> (Intercept) -6.450571   7.424640  -0.869    0.390
#> lpop         0.473727   0.619662   0.764    0.449
#> D           -8.519577  14.453617  -0.589    0.559
#> Dx           0.004326   0.007403   0.584    0.562
#> 
#> Residual standard error: 0.1457 on 38 degrees of freedom
#> Multiple R-squared:  0.339,  Adjusted R-squared:  0.2868 
#> F-statistic: 6.495 on 3 and 38 DF,  p-value: 0.001173
#> 
#> [1] "The dummies are NOT jointly significant, so a structural break in the intercept"
#> [2] "and slope has NOT occured"
```

``` r
file = system.file("extdata", "sample_data_hseinv.txt", package="Kenometrics")
#data <- read.delim(file)
#data <- make_ts("year", data)
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. \#codecov(token = “7362364f-d882-438c-8156-339b77b22474”)

\#finsih unit testing \#check the examples above which are commented out
\#make LRM function, use roxygen skeleton, add to README, run unit
testing.
