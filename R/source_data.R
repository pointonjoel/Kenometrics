#' @title Importing Data
#' @description Import data from a variety of sources
#'
#' @param name The filename of the dataset to be used, e.g. "hseinv" or "NASA", without the extension (i.e. "NASA", not "NASA.xlsx").  If using FRED, type the series id.
#' @param type The type of data, i.e "Wooldridge", "excel" or "FRED". If using FRED then the fredr_set_key() be used prior, with the series id as the name parameter.
#' @param delim The delimiter used for txt files, with whitespace/tab delimiter being the default.
#' @param header Use FALSE if your data has no header names.
#' @param wd The working directory for the file, if appropriate.
#' @param ... The additional parameters either for sourcing FRED data (start/end observations) or txt/csv files.
#'
#' @return The dataset as a dataframe
#' @export
#'
#' @import wooldridge
#' @import fredr
#' @import readxl
#' @importFrom utils read.table data
#' @examples
#' data <- get_data("hseinv", "wooldridge") #add functionality for using FRED!
#' my_data <- get_data("NASA", "txt", "/", FALSE, wd="C:/Users/point/Documents/R/Kenometrics/R")
get_data <-
  function (name, type="wooldridge",delim="",header=TRUE,wd=wd, ...){
    if (is.null(name)) {
      print("Please give the name of the file.")
      break
    }
    if(type=="wooldridge"){
      df <- utils::data(name) #importing the data from the wooldridge package
    }

    if(type=="txt"){
      file_name <- paste(name,".txt", sep = "")
      df <- utils::read.table(file_name,header=header, sep=delim)
    }
    if(type=="excel"){
      file_name <- paste(name,".xlsx", sep = "")
      location <- paste(wd,"/", file_name, sep = "")
      df <- readxl::read_excel(location)
    }
    if(type=="FRED"){
      df <- FRED_data <- fredr::fredr_request(series_id="CLVMNACSCAB1GQUK", endpoint = "series/observations",...)
    }
  return(df)
  }
