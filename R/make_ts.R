#' @title  Make Time Series
#' @description Convert the entire dataset to time-series data type
#'
#' @param time_var The variable in the dataset which marks the
#' year of the observations. E.g. "year". If there are separate year and month
#' variables, use a vector with the year variable first and the month variable
#' second. E.g. c("year", "month")
#' @param df The dataframe which needs to be made a time series data
#' @param vars A vector of variable names, e.g. c("pop", "inv", )
#'
#' @return The new dataset
#' @export
#'
#' @import zoo
#' @importFrom stringr str_to_title
#' @examples
#' file = system.file("extdata", "hseinv.txt", package="Kenometrics")
#' data <- read.delim(file)
#' TS_data <- make_ts("year", data)
make_ts <-
  function (time_vars, df, vars="all"){
    #For one time variable; years and months
    if (length(time_vars)==2){
      #Obtaining months
      months <- df[[time_vars[2]]][0:12]

      #Converting months to a usable case and then the right format
      for (x in 1:length(months)){
        months[x] <- stringr::str_to_title(months[x], locale = "en")
        months[x] <- substr(months[x], 0, 3)
      }

      #Converting to numeric values
      months_nos <- match(months,month.abb)

      #Making numbers double digit
      months_nos <- sprintf("%02d", as.numeric(months_nos))

      #Patching the year and month together
      df[["yearmon"]] <- paste(df[["year"]], "-", months_nos, sep="")

      #First part of zoo work
      df[["yearmon"]] <- zoo::as.yearmon(df[["yearmon"]], "%Y-%m")

      names <- names(df)
      #Testing whether specific vars or all of them are to be converted
      if (vars[1]=="all"){
        #Removing old time vars
        drops <- c("year","month")
        df <- df[ , !(names(df) %in% drops)]
        for (i in 1:ncol(df)){
          if (!names[i]==time_vars[1]){
            df[[i]] <- zoo::zoo(df[[i]], df[["yearmon"]])
          }
        }
      } else {
        for (n in 1:length(vars)){
          if (!vars[n]=="yearmon"){
            df[[vars[n]]] <- zoo::zoo(df[[vars[n]]], df[["yearmon"]])
          }
        }
      }
    }

    #If only a year variable
    if (length(time_vars)==1){
      df[[time_vars[1]]] <- zoo::as.yearmon(df[[time_vars[1]]], "%Y")
      names <- names(df)
      #Testing whether specific vars or all of them are to be converted
      if (vars[1]=="all"){
        for (i in 1:ncol(df)){
          if (!names[i]==time_vars[1]){
            df[[i]] <- zoo::zoo(df[[i]], df[[time_vars[1]]])
          }
        }
      } else {
        #Ensuring vars contains the time var
        #test <- time_vars %in% vars
        #if (test==FALSE){
         # vars <- append(vars, time_vars)
        #}

        #Making the specified vars time series
        for (n in 1:length(vars)){
          if (!vars[n]==time_vars[1]){
            df[[vars[n]]] <- zoo::zoo(df[[vars[n]]], df[[time_vars[1]]])
          }
        }
      }
    }

    return(df)
  }
