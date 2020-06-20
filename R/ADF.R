#' @title ADF Test
#' @description Conduct an ADF test and automatically find the first difference
#' if the variable is non-stationary.
#'
#' @param my_var The variable to be tested, with the null hypothesis stationary
#' (random walk) and the alternative as non-stationary.
#' @param df The data frame where the variable is contained, e.g. my_dataframe.
#' @param type The three types are "no constant, no trend",
#' "constant, no trend" and "constant, trend". The default is "type2",
#' but there is also "type1" and "type3".
#' @param time_var If the supplied data frame has previously been converted to
#' time series using make_ts and/or the "zoo" package, then a time variable must
#' be specified. The variable in the dataset which marks the year of the
#' observations. E.g. "year"
#'
#' @return The result of the ADF test, and the first difference of the variable
#'  if it is stationary
#' @export
#'
#' @importFrom Hmisc Lag
#' @importFrom aTSA adf.test
#' @importFrom stats lag
#' @examples
#' file = system.file("extdata", "hseinv.txt", package="Kenometrics")
#' data <- read.delim(file)
#' data <- ADF("linvpc", data)
#' data <- ADF("lpop", data, type="type1")
ADF <-
  function (my_var, df,type="type2",time_var){
    #Testing to see if the df is time series
    zoo_types <- c('zoo','yearmon')
    TS <- class(df[[1]]) %in% zoo_types

    #converting TS data to numeric type
    if (TS==TRUE){
      variables <- dput(names(df))
      numeric_data <- as.data.frame(as.numeric(df[[time_var]]))
      for (k in seq_len(length(df))){ #here 1:
        if (!variables[k]==time_var){
        numeric_data[[k]] <- as.numeric(df[[k]])
        }
      }
      names(numeric_data) <- variables
      df <- numeric_data
    }

    #ADF code
    changed <- FALSE
    adf_data <- df[[my_var]]
    ADF <- aTSA::adf.test(adf_data)
    for (n in seq_len(length(ADF[[type]][,3]))){ #here 1:
      if(ADF[[type]][,3][n]< 0.05){print(
        paste("beta",n, " is not significant"))
      }
      else {
        print(paste("beta",n, " is significant"))
        if (n==1){
          print(paste(my_var, "is not stationary"))

          #getting the lag
          lagged_data <- Hmisc::Lag(adf_data, 1)

          #calculating the lag
          difference <- adf_data-lagged_data

          #making the name that we want the new, lagged var to have
          var_diff<-paste(toString(my_var), "_diff", sep = "")

          #appending the difference
          df[[var_diff]] <- difference
          changed <- TRUE
        }
      }
    }
    #Informing the user of the outcome
    if (changed==TRUE){
      print("The 1st difference has been appended to the data frame")
    }
    if (changed==FALSE){
      print("No change has been made to the data frame")
    }
    return(df)
  }
