#' Chow Test
#' @description Conduct a chow test on a desired model for a structural break
#' in either the intercept, slope, or both.
#'
#' @param possible_break The year (point) in which the structural break is
#' believed to have occured, e.g. 1969.
#' @param time_var The variable which marks the data/time of the observations.
#' @param df The data frame which holds the variables. e.g. cement_data
#' @param type The type of structural break to be assessed; a break in the
#' break the "intercept", "slope", or "both".
#' @param model The model which the chow test is to be conducted on.
#' Enter this in string form, i.e. "lpop ~ price, L(linvpc,0:2) + p"
#'
#' @return The output from \code{\link{print}}, giving the result of the
#' chow test.
#' @export
#'
#' @importFrom car linearHypothesis
#' @importFrom stats as.formula
#' @import dynlm
#' @examples
#' file = system.file("extdata", "hseinv.txt", package="Kenometrics")
#' data <- read.delim(file)
#' chow(1960, "year", data, "linvpc ~ lpop", "both")
#' #chow(1960, "Time", my_data, "lpop ~ price, L(linvpc,0:2) + p", "intercept")
chow <-
  function (possible_break, time_var="year", df, model, type){
    #Ensuring one of intercept/slope/both is chosen
    v <- c('intercept','slope','both')
    result <- type %in% v
    if (result==TRUE){
      #Testing to see if the df is time series
      zoo_types <- c('zoo','yearmon')
      TS <- class(df[[1]]) %in% zoo_types

      #converting TS data to numeric type
      if (TS==TRUE){
        variables <- dput(names(df))
        numeric_data <- as.data.frame(as.numeric(df[[time_var]]))
        for (k in 1:length(df)){
          if (!variables[k]==time_var){
            numeric_data[[k]] <- as.numeric(df[[k]])
          }
        }
        names(numeric_data) <- variables
        df <- numeric_data
      }

      #Chow test code
      df[["D"]] <- ifelse(df[[time_var]] < possible_break, 0, 1)
      df[["Dx"]] <- df$D * df[[time_var]]
      new_model <- stats::as.formula(paste(model, " + D + Dx", sep="" ))
      print(new_model)
      chow_model <- dynlm(new_model, data=df)
      modelSummary <- summary(chow_model)
      print(modelSummary)
      if (type=="both"){
        f_test <- car::linearHypothesis(chow_model, c("D=0", "Dx=0"))
        p_value <- f_test[["Pr(>F)"]][2]
        if (p_value<0.05){
          result <-
      "The dummies are jointly significant, so a structural break has occured"
        }
        if (p_value>0.05){
          result <-
  "The dummies are NOT jointly significant; a structural break has NOT occured"
        }
      }
      if (type=="intercept"){
        if (modelSummary[["coefficients"]]["D","Pr(>|t|)"]<0.05){
          result <-
      "The intercept dummy is significant so a structural break has occured"
        }
        if (modelSummary[["coefficients"]]["D","Pr(>|t|)"]>0.05){
          result <-
"The intercept dummy is NOT significant so a structural break has NOT occured"
        }
      }
      if (type=="slope"){
        if (modelSummary[["coefficients"]]["Dx","Pr(>|t|)"]<0.05){
          result <-
            "The slope dummy is significant so a structural break has occured"
        }
        if (modelSummary[["coefficients"]]["Dx","Pr(>|t|)"]>0.05){
          result <-
    "The slope dummy is NOT significant so a structural break has NOT occured"
        }
      }
    }
    if (result==FALSE){
      result <-
        "Please ensure one of intercept/slope/both is chosen"
    }
    return(print(strwrap(result, width=80)))
  }
