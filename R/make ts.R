#' @title  Make Time Series
#' @description Convert the entire dataset to time-series data type
#'
#' @param time_var The variable in the dataset which marks the data/time of the observations. E.g. "year" or "month"
#' @param df The dataframe which needs to be made a time series data
#'
#' @return The new dataset
#' @export
#'
#' @import zoo
#' @examples
#' data <- make_ts("year", data)
make_ts <-
  function (time_var, df){
    if (is.null(time_Var)) {
      print("Please give the time variable!")
      break
    }
    if (is.null(df)) {
      print("Please input data frame.")
      break
    }
   df[[time_var]] <- zoo::as.yearmon(df[[time_var]], "%Y")
    for (i in 2:ncol(df)){
      df[[i]] <- zoo::zoo(df[[i]], df[[time_var]])
    }
  }
