#' Reorder data with parameters as headers
#'
#' @param pFile dataframe containing variable information to be selected.
#' @param col1 String name of the first column to be selected
#' @param col2 String name of the second column to be selected
#' @param col3 String name of the third column to be selected
#' @return Returns a dataframe containing the three original vectors reordered around the first


reorder = function(pFile, col1, col2, col3){
  pFile = select(pFile, starts_with(col1), starts_with(col2), starts_with(col3))
  pFile = dcast(pFile, pFile[[col1]] ~ pFile[[col2]], value.var=col3, fun.aggregate=mean)
  return(pFile)
}