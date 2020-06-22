
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Kenometrics

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/pointonjoel/Kenometrics/branch/master/graph/badge.svg)](https://codecov.io/gh/pointonjoel/Kenometrics?branch=master)
[![Travis build
status](https://travis-ci.com/pointonjoel/Kenometrics.svg?branch=master)](https://travis-ci.com/pointonjoel/Kenometrics)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/pointonjoel/Kenometrics?branch=master&svg=true)](https://ci.appveyor.com/project/pointonjoel/Kenometrics)
[![R build
status](https://github.com/pointonjoel/Kenometrics/workflows/R-CMD-check/badge.svg)](https://github.com/pointonjoel/Kenometrics/actions)
![CI](https://github.com/pointonjoel/Kenometrics/workflows/CI/badge.svg)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=DXBJF8MEJ3GT2&source=url)
<!-- badges: end -->

The goal of Kenometrics is to provide a set of functions which allow
econometrics students to simply conduct important manipulations and
tests.

## Installation

You can install the released version of Kenometrics by contacting [Joel
Pointon](https:/www.joelpointon.com/contact).

## Overview

The Kenometrics package enables lecturers and students to teach and
implement fundamental econometric techniques. This project has taken
many hours; if you find the package useful then please consider donating
using the donation badge (linked to PayPal) above. Additionally, if you
have a feature you would like to see added then please get in touch (and
consider donating\!). Below is a summary of the functions on offer and
how they can be used:

<body>

<ul>

<li>

<b>get\_data()</b> <i>A single function to find and source data from a
variety of sources (txt, Excel)</i>

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
conversion from zoo to numeric (reversing the make\_ts function)</i>

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
readxl and tseries. Having all of these bundled into one package and
harnessed for econometrics means that students can quickly begin putting
theory into practice. Without Kenometrics, testing for non-stationary
data, for example, can be long-winded and and require multiple packages.
However, Kenometrics simplifies the code into one line and includes all
other necessary packages. Although, students are encouraged to look into
the code, which is written in a simple and intuitive way, to see how
they could complete the data manipulations without Kenometrics.

<center>

<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">

<input type="hidden" name="cmd" value="_s-xclick" />
<input type="hidden" name="hosted_button_id" value="KRYRDEYU4TDZS" />
<input type="image" src="https://www.paypalobjects.com/en_US/GB/i/btn/btn_donateCC_LG.gif" border="0" name="submit" title="PayPal - The safer, easier way to pay online!" alt="Donate with PayPal button" />
<img alt="" border="0" src="https://www.paypal.com/en_GB/i/scr/pixel.gif" width="1" height="1" />

</form>

</center>
