#' Run rloadest with a given data frame.
#' 
#' @param pFile The dataframe containing the variable, flow rate, and dates to be read
#' @param varName The string name of the variable to be run through rloadest
#' @param flowName The string name of the column containing flow data
#' @param dateName The string name of the column containing date data
#' @param unitsName A string of units denoting the concentration of the variable. 
#' @param stationName The string name of the station.
#' @seealso \code{\link[rloadest]{loadConvFactor}}
#' @return Returns a dataframe containing the concentration information

rLoadRun = function(pFile, fFile, varName, flowName, dateName, stationName){
  rRun = selBestModel(varName, data=pFile, flow="Q", flow.units="cms",
                      dates="Date", station="Holt station", time.step="day")
  concentration = predConc(rRun, fFile, by="day")
  return(concentration)
}

test = rLoadRun(file, file2, "Q", "Q", "DAAAAAY", "TEst")
print(test)