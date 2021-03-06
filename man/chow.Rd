% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chow.R
\name{chow}
\alias{chow}
\title{Chow Test}
\usage{
chow(possible_break, time_var = "year", df, model, type)
}
\arguments{
\item{possible_break}{The year (point) in which the structural break is
believed to have occurred, e.g. 1969.}

\item{time_var}{The variable which marks the data/time of the observations.}

\item{df}{The data frame which holds the variables. e.g. cement_data}

\item{model}{The model which the chow test is to be conducted on.
Enter this in string form, i.e. "lpop ~ price, L(linvpc,0:2) + p"}

\item{type}{The type of structural break to be assessed; a break in the
break the "intercept", "slope", or "both".}
}
\value{
The output from \code{\link{print}}, giving the result of the
chow test.
}
\description{
Conduct a chow test on a desired model for a structural break
in either the intercept, slope, or both.
}
\examples{
file = system.file("extdata", "hseinv.txt", package="Kenometrics")
data <- read.delim(file)
chow(1960, "year", data, "linvpc ~ lpop", "both")
#chow(1960, "Time", my_data, "lpop ~ price, L(linvpc,0:2) + p", "intercept")
}
