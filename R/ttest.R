#' @title T-Test
#'
#' @description Obtain the T-value and P-value for any parameter in a model,
#' given a hypothesised mean.
#'
#' @param var_name the variable to find the t-value for, in the form
#' "educ" or "exper" etc.
#' @param df the dataframe which the model is based upon, e.g. my_data
#' or NASA.
#' @param model the model which the parameter pertains to, e.g. my_model
#' or chow_model.
#' @param pop_mean the value which the population mean is hypothesised
#' to be, typically 0.
#'
#' @return The output from \code{\link{print}}, giving the T-Value and P-Value.
#' @export
#'
#' @importFrom stats pt
#' @examples
#' file = system.file("extdata", "hseinv.txt", package="Kenometrics")
#' data <- read.delim(file)
#' linear_model <- lm(linv ~ lpop + lprice, data=data)
#' ttest("lpop", data, linear_model, 0)
#' \dontrun{
#' ttest("educ", my_df, chow_model, 1)
#' }
ttest <-
  function (var_name, df, model, pop_mean=0){

    #Getting df name
    df.name <- deparse(substitute(my_data))

    #Getting the exact variable name used in the model
    try2 <- function(code, silent = FALSE) { #I might need to pass in var_name
      fixed_name <- tryCatch(code, error = function(c) { #same here
        if (!silent) {name <-
          paste(df.name,"$",var_name, sep="")}
        else{name <- var_name}})
      return(fixed_name)}

    #Assigning variable name and continuing
    correct_var_name <- try2(var_name)
    estimate <- summary(model)$coefficients[correct_var_name , 1]
    se <- summary(model)$coefficients[correct_var_name , 2]
    tstat <- (estimate-pop_mean)/se
    p_value <- 2*stats::pt(-abs(tstat), df=nrow(df)-ncol(df))
    return(print(paste("The t-value for ", var_name, " is ",
                       signif(tstat, digits = 4), ", and the p-value is ",
                       formatC(signif(p_value, digits = 3),
                               format = "f",digits = 4), ".", sep = "")))
  }
