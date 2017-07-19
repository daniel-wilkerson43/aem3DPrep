#' Add flow as header "Q" to a data file.
#' 
#' @param pFile dataframe containing the variables to be merged with the flow vector
#' @param fFile dataframe containing flow values. Must be of equal length to the pFile, must match timestamps.
#' @param col1 String name of the first column to be blended
#' @param col2 String name of the second column to be blended
#' @param col3 String name of the third column to be blended
#' @param fcol String name of the Q column in flows to be blended
#' @return Returns a dataframe containing the three original vectors and the flow vector

blend = function(pFile, fFile, col1, col2, col3, fcol){
  matchingDates = which(fFile$Date %in% pFile$Date)
  fFile = fFile[matchingDates,]
  matchingDates = which(pFile$Date %in% fFile$Date)
  pFile = pFile[matchingDates,]
  pFile["Q"] = fFile[[fcol]]
  c1 = which(colnames(pFile)==col1)
  c2 = which(colnames(pFile)==col2)
  c3 = which(colnames(pFile)==col3)
  #pFile = select(pFile, c1, Q, c2, c3)
  return(pFile)
}

##Legacy -- Currently unused