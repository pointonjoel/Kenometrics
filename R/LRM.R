#' @title Find the LRM
#' @description Find the long run multiplier/propensity
#'
#' @param yvar The regressand/dependent variable in the FDL model
#' @param xvar The variable within the Finite Distributed Lag (FDL) model
#' that will be the regressor. E.g. lpop
#' @param lags The number of lags of the x variable
#' @param other_vars variables to be included (not lagged). Input using a vector
#' such as: c("lprice", "linvpc")
#' @param df The dataframe which the model is based upon, e.g. my_data or NASA.
#' @param time_var The variable in the dataset which marks the year of the
#' observations. E.g. "year".
#'
#' @return It prints the LRM its standard error and returns the LRM
#' @export
#'
#' @importFrom Hmisc Lag
#' @importFrom utils tail
#'
#' @examples
#' #Sourcing the data from the user's computer
#' file <- system.file("extdata", "fertil3.txt", package="Kenometrics")
#' fertil3_data <- read.delim(file)
#'
#' #Using the function
#' LR_prop <- LRM("gfr", "pe", 3, other_vars=c("ww2", "pill"), df=fertil3_data)
LRM <-
  function (yvar, xvar, lags=3, other_vars="", df, time_var="year"){
    df <- make_ts(time_var, df)
    if (lags==3){
      #getting the lags
      lag1 <- Hmisc::Lag(df[[xvar]], 1)
      lag2 <- Hmisc::Lag(df[[xvar]], 2)
      #lag3 <- Hmisc::Lag(df[[xvar]], 3)

      #calculating the lag
      difference1 <- lag1-df[[xvar]]
      difference2 <- lag2-df[[xvar]]

      #making the name that we want the new, lagged var to have
      var_diff1 <- paste(toString(xvar), "_diff1", sep = "")
      var_diff2 <- paste(toString(xvar), "_diff2", sep = "")

      #appending the difference
      df[[var_diff1]] <- difference1
      df[[var_diff2]] <- difference2

      #Removing the first two observations due to the the 1st/2nd differences
      new_df <- utils::tail(df,-2)

      others <- ""
      for (i in 1:length(other_vars)){
        if(!other_vars[1]==""){
          others <- paste(others, other_vars[i], sep=" + ")
        }
      }

      #Obtaining regression formula
      formula <-
        as.formula(
          paste(
            yvar, "~", xvar, "+", var_diff1, "+", var_diff2, others, sep=" "
            )
          )

      #Regression and LRP
      model <- dynlm(formula, data=new_df)
      LRM <- unname(model[["coefficients"]][xvar])
      LRM_se <- unname(summary(model)[["coefficients"]][, "Std. Error"][xvar])
      print_LRM <- round(LRM,4)
      print_LRM_se <- round(LRM_se,4)

      print(paste("The LRM IS:", print_LRM))
      print(paste("The LRM standard error is:", print_LRM_se))

      #T-test
      t_stat <- LRM/LRM_se
      print_t_stat <- round(t_stat,4)
      print(paste("The t-stat of the LRM is:", print_t_stat))
    }
    return(LRM)
  }
