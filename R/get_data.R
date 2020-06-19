#' @title Importing Data
#' @description Import data from a variety of sources
#'
#' @param name The filename of the dataset to be used, e.g. "hseinv"
#' or "NASA", without the extension (i.e. "NASA", not "NASA.xlsx").
#' If using FRED, type the series id.
#' @param type The type of data, i.e "Wooldridge", "excel" or "FRED".
#' @param delim The delimiter used for txt files, with whitespace/
#' tab delimiter being the default.
#' @param header Use FALSE if your data has no header names.
#' @param file_loc The working directory for the file, if appropriate.
#' Note the use of "/" rather than "\", as is customary in R.
#' @param key The user's personal key used to access FRED's API
#' @param ... The additional parameters either for sourcing FRED data
#' (start/end observations) or txt/csv files.
#'
#' @return The dataset as a dataframe
#' @export
#'
#' @import fredr
#' @import readxl
#' @importFrom utils read.delim data
#' @examples
#' #Code needed to obtain the NASA file on the user's computer
#' file = system.file("extdata", "NASA.xlsx", package="Kenometrics")
#' my_wd =substr(file,0,nchar(file)-nchar("NASA.xlsx")-1)
#' #Once the working directory has been obtained, the get_data function
#' #can be used
#'
#' NASA_data <- get_data("NASA", type="excel", file_loc = my_wd)
#'
#' some_data <- get_data("hseinv", "txt", file_loc=my_wd)
#'
#' \dontrun{
#' FRED requests can also be made; simply replace the key ("ABCDE")
#' with your personal access token - see Kenometrics_Support file
#' for details
#' my_data <- get_data(name="CLVMNACSCAB1GQUK", type="FRED", key="ABCDE")
#' }
get_data <-
  function (name, type="excel",delim="",header=TRUE,file_loc, key, ...){
    if(type=="txt"){
      file_name <- paste(name,".txt", sep = "")
      location <- paste(file_loc,"/", file_name, sep = "")
      df <- utils::read.delim(location,header=header, sep=delim)
    }
    if(type=="excel"){
      file_name <- paste(name,".xlsx", sep = "")
      location <- paste(file_loc,"/", file_name, sep = "")
      df <- readxl::read_excel(location)
    }
    if(type=="FRED"){
      fredr::fredr_set_key(key)
      df <-
        fredr::fredr_request(
          series_id=name, endpoint = "series/observations",...
          )
    }
    return(df)
  }
