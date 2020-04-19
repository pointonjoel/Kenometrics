#' @title ADF Test
#' @description Conduct an ADF test and automatically find the first difference if the variable is non-stationary.
#'
#' @param var The variable to be tested, with the null hypothesis stationary (random walk) and the alternative as non-stationary.
#' @param df The data frame where the variable is contained, e.g. "my_dataframe".
#' @param type The three types are "no constant, no trend", "constant, no trend" and "constant, trend". The defaulT is "type2", but there is also "type1" and "type3".
#'
#' @return The result of the ADF test, and the first difference of the variable if it is stationary
#' @export
#'
#' @import zoo
#' @importFrom tseries adf.test
#' @examples
#' data<-ADF("linvpc", data)
#' data<-ADF("linvpc", data, type="type1")
ADF <-
  function (var, df,type="type2"){#The 3 versions are:
    ADF<-tseries::adf.test(df[[var]])#this part is the issue - idk why? will megring it with the next few lines help?
    print(ADF)
    for (n in 1:length(ADF[[type]][,3])){
      if(ADF[[type]][,3][n]< 0.05){print(
        paste("beta",n, " is not significant"))
        }
      else {
        print(paste("beta",n, " is significant"))
        if (n==1){
          print(paste(var, "is not stationary"))
          zoo_df <- read.zoo(df) #making it TS if it isn't already
          lags=lag(zoo_df, 0:-1) #-1 means the lag of 1
          lag_df <- df.frame(lags) #making the 'numeric' df become a df
          lag_var=paste(toString(var), ".lag.1", sep = "") #making the name that the df will have the lag under
          var_diff<-paste(toString(var), "_diff", sep = "") #making the name that we want the new, lagged var to have in the original df df
          df[[var_diff]]=df[[var]]-lag_df[[lag_var]] #calculating the 1st difference and appending it to the original df df
          print("The 1st difference has been appended to the data frame")
        }
      }
    }
    return(df)
  }

#spare tests
#ADF<-adf.test(var,nlag=3) #nlag is how many terms,nlag=3 means 1 level and 2 differences. The 3 versions are: {no constant, no trend}, {constant, no trend} and {constant, trend}
#ADF2=ur.df(hseinv$lprice,lags=2,type="trend") #weird ADF test
#summary(ADF2)
