
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Kenometrics

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/pointonjoel/Kenometrics/branch/master/graph/badge.svg)](https://codecov.io/gh/pointonjoel/Kenometrics?branch=master)
[![Travis build
status](https://travis-ci.com/pointonjoel/Kenometrics.svg?branch=master)](https://travis-ci.com/pointonjoel/Kenometrics)
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
variety of sources (FRED, txt, Excel)</i>

</li>

<li>

<b>ttest()</b> <i>Conduct a t-test (with a specific hypothesised mean,
not necessarily 0)</i>

</li>

<li>

<b>chow()</b> <i>Conduct a chow test (it adds an intercept and dummy
slope and tests the significance depending on if one is testing for a
break in the intercept, slope or both)</i>

</li>

<li>

<b>make\_ts()</b> <i>Make the data time-series (to allow for lagged
variables etc.)</i>

</li>

<li>

<b>make\_numeric()</b> <i>Make the data of numeric form, to allow to
conversion from zoo to numeric (reversing the make\_ts function).</i>

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
examples](https://www.cengage.com/cgi-wadsworth/course_products_wp.pl?fid=M20b&product_isbn_issn=9781111531041):

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
#>     Year No_Smoothing Lowess
#>    <dbl>        <dbl>  <dbl>
#>  1  1880        -0.16  -0.09
#>  2  1881        -0.08  -0.12
#>  3  1882        -0.1   -0.16
#>  4  1883        -0.17  -0.2 
#>  5  1884        -0.28  -0.23
#>  6  1885        -0.32  -0.25
#>  7  1886        -0.3   -0.26
#>  8  1887        -0.35  -0.26
#>  9  1888        -0.16  -0.26
#> 10  1889        -0.1   -0.25
#> # ... with 130 more rows
```

Whilst the function defaults the working directory to the current
location of the workspace, students are encouraged to set a working
directory prior to sourcing data. This can be done by using:

``` r
my_wd="C:/Documents"
#And then for usage:
#setwd(my_wd)
```

Note the use of “/” rather than "", as is customary in R.

Students can also import files from FRED using Kenometrics, once they
have obtained a [FRED API
key](https://research.stlouisfed.org/docs/api/api_key.html), which is
simple and free. For examples, see:

``` r
#?get_data
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

## Chow tests

With Kenometrics, a Chow test can easily be conducted. The fucntion
works by adding both an intercept and a slope dummy, allowing the user
to select whether the test is for the intercept, slope, or both.

``` r
chow(1960, "year", hseinv, "linvpc ~ lpop", "both")
#> linvpc ~ lpop + D + Dx
#> <environment: 0x00000000120272c0>
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
#> [1] "The dummies are NOT jointly significant; a structural break has NOT occured"
```

## Making data time series

In order to add lagged variables to regressions, the data needs to be
declared time series. This can be done easily, with the ability to
override the old data frame or make a new one:

``` r
#Code needed to obtain the data file on the user's computer
file <-  system.file("extdata", "NASA.xlsx", package="Kenometrics")
my_wd <- substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)
hseinv_data <- get_data("hseinv", "txt", file_loc=my_wd)

#Using the function to make a new data set that is time series
TS_data <- make_ts("year", hseinv_data)

#Using the function to override the old data with time series data
#Note that this is strongly discouraged, see below.
hseinv_data <- make_ts("year", hseinv_data)
```

The user can then use the dynlm function to add lagged variables to
their model.

``` r
library(dynlm)
#> Loading required package: zoo
#> 
#> Attaching package: 'zoo'
#> The following objects are masked from 'package:base':
#> 
#>     as.Date, as.Date.numeric
lagged_model <- dynlm(lpop ~ price + L(linvpc,0:2), data=TS_data)
summary(lagged_model)
#> 
#> Time series regression with "zoo" data:
#> Start = Jan 1949, End = Jan 1988
#> 
#> Call:
#> dynlm(formula = lpop ~ price + L(linvpc, 0:2), data = TS_data)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -0.22169 -0.07194  0.02768  0.05565  0.11692 
#> 
#> Coefficients:
#>                 Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)      10.9222     0.3271  33.389  < 2e-16 ***
#> price             1.6264     0.2927   5.557 2.97e-06 ***
#> L(linvpc, 0:2)0   0.2612     0.1123   2.326   0.0259 *  
#> L(linvpc, 0:2)1  -0.1121     0.1384  -0.810   0.4234    
#> L(linvpc, 0:2)2   0.1769     0.1174   1.508   0.1407    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.086 on 35 degrees of freedom
#> Multiple R-squared:  0.6974, Adjusted R-squared:  0.6629 
#> F-statistic: 20.17 on 4 and 35 DF,  p-value: 1.084e-08
```

When users convert to time series data, the ADF and chow test functions
automatically convert this to numeric form in order to proceed. If users
do, for whatever reason, want to convert back from time series (to
numeric class), a function has been created to allow for this:

``` r
make_numeric(TS_data, "year")
```

However, this is discouraged because the initial data types are lost in
the process of converting from time series and back to numeric.
Therefore, users are encouraged to not override the initial dataset but
instead use time series function to make a new time series data frame,
also keeping the initial one.

## ADF test

An ADF can ordinarily be run without Kenometrics. However, students
often find the results confusing and difficult to understand.
Kenometrics selects an appropriate test (defaulting to “constant, no
trend”) for students automatically, yet leaving the option for users to
select their own. Additionally, if the variable is found to be
non-stationary, the function calculates the 1st difference and returns
the original dataset with a the 1st difference appended. This allows
students to then run regressions knowing that all variables are
stationary.

``` r
#overrides the previous dataset
#If the variable is stationary then no change is made
#If the variable is non-stationary then the 1st difference is appended
#We converted the data to time series, above, so we must add a time variable:
hseinv_data <- ADF("lpop", hseinv_data, type="type1", time_var = "year")
#> c("year", "inv", "pop", "price", "linv", "lpop", "lprice", "t", 
#> "invpc", "linvpc", "lprice_1", "linvpc_1", "gprice", "ginvpc"
#> )
#> Augmented Dickey-Fuller Test 
#> alternative: stationary 
#>  
#> Type 1: no drift no trend 
#>      lag    ADF p.value
#> [1,]   0 23.499   0.990
#> [2,]   1  0.955   0.905
#> [3,]   2  0.384   0.748
#> [4,]   3  0.351   0.739
#> Type 2: with drift no trend 
#>      lag    ADF p.value
#> [1,]   0 -12.64  0.0100
#> [2,]   1  -2.64  0.0963
#> [3,]   2  -1.66  0.4580
#> [4,]   3  -1.80  0.4032
#> Type 3: with drift and trend 
#>      lag   ADF p.value
#> [1,]   0 -1.98   0.570
#> [2,]   1 -1.95   0.583
#> [3,]   2 -2.66   0.308
#> [4,]   3 -3.06   0.154
#> ---- 
#> Note: in fact, p.value = 0.01 means p.value <= 0.01 
#> [1] "beta 1  is significant"
#> [1] "lpop is not stationary"
#> [1] "beta 2  is significant"
#> [1] "beta 3  is significant"
#> [1] "beta 4  is significant"
#> [1] "The 1st difference has been appended to the data frame"
```

## LRM

The final function available to users is the LRM function, which
calculates the Long Run Multiplier/Propensity of a FDL model. It is
currently configured to only allow 3 lags of one variable, and from this
the LRM is calculated. Additional functionality to enable users to
specify the number of lags is expected to be released in a future
update. The LRM also calculates the t-statistic of the LRM and prints
this, but only returns the LRM, as shown below.

``` r
#Sourcing the data from the user's computer
file <- system.file("extdata", "fertil3.txt", package="Kenometrics")
fertil3_data <- read.delim(file)

#Using the function
LR_prop <- LRM("gfr", "pe", 3, other_vars=c("ww2", "pill"), df=fertil3_data)
#> [1] "The LRM IS: 0.1007"
#> [1] "The LRM standard error is: 0.0298"
#> [1] "The t-stat of the LRM is: 3.3795"
print(LR_prop)
#> [1] 0.1007191
```

\#Check gp() and all\_checks() - fix everything \#Finish website
