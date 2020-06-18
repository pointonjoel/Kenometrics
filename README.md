
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
#> <environment: 0x0000000011995d30>
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
#> c("year", "inv", "pop", "price", "linv", "lpop", "lprice", "t", 
#> "invpc", "linvpc", "lprice_1", "linvpc_1", "gprice", "ginvpc"
#> )
#>    year    inv    pop  price     linv     lpop     lprice  t     invpc
#> 1  1947  54864 144126 0.8190 10.91261 11.87844 -0.1996712  1 0.3806669
#> 2  1948  64717 146631 0.8649 11.07778 11.89567 -0.1451414  2 0.4413596
#> 3  1949  63150 149188 0.8456 11.05327 11.91296 -0.1677088  3 0.4232914
#> 4  1950  86014 151684 0.8765 11.36227 11.92955 -0.1318186  4 0.5670605
#> 5  1951  70610 154287 0.8819 11.16493 11.94657 -0.1256766  5 0.4576536
#> 6  1952  68574 156954 0.8842 11.13567 11.96371 -0.1230720  6 0.4369051
#> 7  1953  70818 159565 0.8868 11.16787 11.98021 -0.1201358  7 0.4438191
#> 8  1954  78460 162391 0.8597 11.27034 11.99776 -0.1511718  8 0.4831549
#> 9  1955  91204 165275 0.8708 11.42085 12.01537 -0.1383429  9 0.5518318
#> 10 1956  80383 168221 0.8829 11.29456 12.03303 -0.1245433 10 0.4778416
#> 11 1957  74040 171274 0.8722 11.21236 12.05102 -0.1367365 11 0.4322898
#> 12 1958  74822 174141 0.8521 11.22287 12.06762 -0.1600514 12 0.4296633
#> 13 1959  88936 177830 0.8647 11.39567 12.08858 -0.1453726 13 0.5001181
#> 14 1960  83127 180671 0.8620 11.32813 12.10443 -0.1485000 14 0.4601015
#> 15 1961  83207 183691 0.8553 11.32909 12.12101 -0.1563030 15 0.4529727
#> 16 1962  89121 186538 0.8593 11.39775 12.13639 -0.1516372 16 0.4777632
#> 17 1963  96778 189242 0.8656 11.48018 12.15078 -0.1443324 17 0.5113981
#> 18 1964  94306 191889 0.8795 11.45430 12.16467 -0.1284017 18 0.4914612
#> 19 1965 100103 194303 0.8774 11.51396 12.17717 -0.1307923 19 0.5151902
#> 20 1966  92145 196560 0.8783 11.43112 12.18872 -0.1297670 20 0.4687881
#> 21 1967  91336 198712 0.8919 11.42230 12.19961 -0.1144013 21 0.4596401
#> 22 1968  99617 200706 0.9036 11.50909 12.20960 -0.1013685 22 0.4963329
#> 23 1969 102183 202677 0.9152 11.53452 12.21937 -0.0886127 23 0.5041667
#> 24 1970  96855 205052 0.8823 11.48097 12.23102 -0.1252231 24 0.4723436
#> 25 1971 124309 207191 0.8798 11.73053 12.24140 -0.1280606 25 0.5999730
#> 26 1972 147269 209353 0.8874 11.90002 12.25178 -0.1194595 26 0.7034482
#> 27 1973 145286 211536 0.9057 11.88646 12.26215 -0.0990471 27 0.6868145
#> 28 1974 112349 213743 0.9232 11.62936 12.27253 -0.0799094 28 0.5256266
#> 29 1975  95170 215973 0.9147 11.46342 12.28291 -0.0891592 29 0.4406569
#> 30 1976 117727 218280 0.9199 11.67612 12.29353 -0.0834903 30 0.5393394
#> 31 1977 142412 220612 0.9604 11.86648 12.30416 -0.0404054 31 0.6455315
#> 32 1978 151261 222968 1.0061 11.92676 12.31478  0.0060815 32 0.6783978
#> 33 1979 143049 225350 1.0356 11.87094 12.32541  0.0349809 33 0.6347859
#> 34 1980 112310 227757 1.0432 11.62902 12.33603  0.0422929 34 0.4931133
#> 35 1981 102714 230139 1.0282 11.53970 12.34644  0.0278097 35 0.4463129
#> 36 1982  84676 232520 1.0000 11.34659 12.35673  0.0000000 36 0.3641665
#> 37 1983 122819 234799 0.9836 11.71847 12.36648 -0.0165359 37 0.5230814
#> 38 1984 145166 237001 0.9836 11.88563 12.37582 -0.0165359 38 0.6125122
#> 39 1985 146311 239279 0.9760 11.89349 12.38539 -0.0242927 39 0.6114661
#> 40 1986 168406 241625 0.9760 12.03413 12.39514 -0.0242927 40 0.6969726
#> 41 1987 167459 243934 0.9892 12.02849 12.40465 -0.0108587 41 0.6864930
#> 42 1988 165459 246329 0.9864 12.01648 12.41442 -0.0136933 42 0.6716992
#>        linvpc lprice_1 linvpc_1 gprice ginvpc
#> 1  -0.9658305       35       42     16     23
#> 2  -0.8178953       34       40     41     34
#> 3  -0.8596944       26       34     11      9
#> 4  -0.5672894       33       39     38     41
#> 5  -0.7816427       22       11     23     20
#> 6  -0.8280393       17       30     19     10
#> 7  -0.8123382       14       36     20     25
#> 8  -0.7274181       13       33     14     31
#> 9  -0.5945120       29       23     28     33
#> 10 -0.7384759       24       12     31     17
#> 11 -0.8386591       15       24      8     16
#> 12 -0.8447533       23       37     12      2
#> 13 -0.6929110       32       38     32     35
#> 14 -0.7763081       27       19      4     13
#> 15 -0.7919235       28       28      6      4
#> 16 -0.7386400       31       31     21     28
#> 17 -0.6706070       30       25     24     29
#> 18 -0.7103723       25       17     34      8
#> 19 -0.6632192       19       22      1     26
#> 20 -0.7576043       21       16     18     14
#> 21 -0.7773115       20       27     33      5
#> 22 -0.7005083       11       29     29     30
#> 23 -0.6848482       10       20     27     24
#> 24 -0.7500486        7       18     15     11
#> 25 -0.5108707       16       26      3     40
#> 26 -0.3517610       18       10     26     37
#> 27 -0.3756910       12        1     36      7
#> 28 -0.6431642        9        3     35     22
#> 29 -0.8194886        5       14      7     18
#> 30 -0.6174103        8       35     22     39
#> 31 -0.4376812        6       13     39     38
#> 32 -0.3880215        4        6     40     27
#> 33 -0.4544675       37        5     37     12
#> 34 -0.7070163       39        7     25     21
#> 35 -0.8067350       40       21      9     15
#> 36 -1.0101440       38       32     13     19
#> 37 -0.6480181       36       41     10     42
#> 38 -0.4901865        2       15     17     36
#> 39 -0.4918957        2        8      5      1
#> 40 -0.3610092        3        9     17     32
#> 41 -0.3761592        3        2     30      3
#> 42 -0.3979446        1        4      2      6
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

\#make LRM function, use roxygen skeleton, add to README, run unit
testing. \#Stop make\_numeric being annoying and printing the variables
