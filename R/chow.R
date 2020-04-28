#' Chow Test
#' @description Conduct a chow test on a desired model for a structural break in either the intercept, slope, or both.
#'
#' @param possible_break The year (point) in which the structural break is believed to have occured, e.g. 1969.
#' @param time_var The variable which marks the data/time of the observations.
#' @param df The data frame which holds the variables.
#' @param type The type of structural break to be assessed; a break in the break the "intercept", "slope", or "both".
#' @param model The model which the chow test is to be conducted on. Enter this in string form, i.e. "lpop ~ price, L(linvpc,0:2) + p"
#'
#' @return The output from \code{\link{print}}, giving the result of the chow test.
#' @export
#'
#' @importFrom car linearHypothesis
#' @importFrom stats as.formula
#' @import dynlm
#' @examples
#' file = system.file("extdata", "sample_data_hseinv.txt", package="Kenometrics")
#' data <- read.delim(file)
#' chow(1960, "Year", data, "linvpc ~ lpop", "both")
#' chow(1960, "Time", my_data, "lpop ~ price, L(linvpc,0:2) + p", "intercept")
chow <-
  function (possible_break, time_var="year", df, model, type){#type can be intercept, slope or both
    if (is.null(possible_break)) {
      print("Please give the year in which the break is believed to have occured")
      break
    }
    if (is.null(df)) {
      print("Please input data frame")
      break
    }
    if (is.null(model)) {
      print("Please input the desired model")
      break
    }
    if (is.null(type)) {
      print("Please specify if the test is for a break in the intercept, slope or both")
      break
    }
    df[["D"]] <- ifelse(df[[time_var]] < possible_break, 0, 1)
    df[["Dx"]] <- df$D * df[[time_var]]
    new_model <- stats::as.formula(paste(model, " + D + Dx", sep="" ))
    chow_model <- dynlm(new_model, data=df)
    modelSummary <- summary(chow_model) #doing an F-Test compared to a restricted model without the dummies will give the same result as the Chow Test above! Testing either D or Dx using  t-Test will signify if either the intercept or slope has changed, respectively.
    print(modelSummary)
    if (type=="both"){
      f_test <- car::linearHypothesis(chow_model, c("D=0", "Dx=0"))
      p_value <- f_test[["Pr(>F)"]][2]
      if (p_value<0.05){
        print("The dummies are jointly significant, so a  structural break in the intercept and slope has occured")
      }
      if (p_value>0.05){
        print("The dummies are NOT jointly significant, so a  structural break in the intercept and slope has NOT occured")
      }
    }
    if (type=="intercept"){
      if (modelSummary[["coefficients"]]["D","Pr(>|t|)"]<0.05){
        print("The intercept dummy is significant, so a  structural break in the intercept has occured")
      }
    }
    if (type=="slope"){
      if (modelSummary[["coefficients"]]["Dx","Pr(>|t|)"]<0.05){
        print("The slope dummy is significant, so a  structural break in the slope has occured")
      }
    }
  }
