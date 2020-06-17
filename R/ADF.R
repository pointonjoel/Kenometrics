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
#'
#' @return The result of the ADF test, and the first difference of the variable
#'  if it is stationary
#' @export
#'
#' @import zoo
#' @importFrom aTSA adf.test
#' @importFrom stats lag
#' @examples
#' file = system.file("extdata", "hseinv.txt", package="Kenometrics")
#' data <- read.delim(file)
#' data <- ADF("linvpc", data)
#' data <- ADF("lpop", data, type="type1")
ADF <-
  function (my_var, df,type="type2"){
    #frame_data=data.matrix(df)
    adf_data <- df[[my_var]]
    ADF <- aTSA::adf.test(adf_data)
    print(ADF)
    for (n in 1:length(ADF[[type]][,3])){
      if(ADF[[type]][,3][n]< 0.05){print(
        paste("beta",n, " is not significant"))
      }
      else {
        print(paste("beta",n, " is significant"))
        if (n==1){
          print(paste(my_var, "is not stationary"))
          #making it TS if it isn't already
          zoo_df <- read.zoo(df)
          #-1 means the lag of 1
          lags <- stats::lag(zoo_df, 0:-1)
          #making the 'numeric' df become a df
          lag_df <- data.frame(lags)
          #making the name that the df will have the lag under
          lag_var <- paste(toString(my_var), ".lag.1", sep = "")
          #making the name that we want the new, lagged var to have
          var_diff<-paste(toString(my_var), "_diff", sep = "")
          #calculating the 1st difference and appending it to the original df df
          df[[var_diff]] <- df[[my_var]]-lag_df[[lag_var]]
          print("The 1st difference has been appended to the data frame")
        }
      }
    }
    return(df)
  }
