#' Convert (Zoo) Data Frame to Numeric
#'
#' @param df The data frame to be converted (which is not numeric)
#' @param time_var The variable in the dataset which marks the
#' year of the observations. E.g. "year"
#'
#' @return The original data frame but in numeric form
#' @export
#'
#' @examples
#' #Souring the data
#' file = system.file("extdata", "hseinv.txt", package="Kenometrics")
#' data <- read.delim(file)
#'
#' #Making the data time-series
#' TS_data <- make_ts("year", data)
#'
#' #Converting back to numeric
#' non_TS_data <- make_numeric(TS_data, "year")
make_numeric <-
  function (df, time_var="year"){
    vars_as_list <- names(df)
    variables <- as.vector(vars_as_list)
    numeric_data <- as.data.frame(as.numeric(df[[time_var]]))
    for (k in 2:length(df)){
      numeric_data[[k]] <- as.numeric(df[[variables[k]]])
    }
    names(numeric_data) <- variables
    return(numeric_data)
  }
