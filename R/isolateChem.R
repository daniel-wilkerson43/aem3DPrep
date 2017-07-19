#' Isolate columns from a .csv file
#' 
#' Function is intended to separate out useful data from
#' extraneous data that is unnecessary for AEM3D processing. Use
#' this for chem data files.
#' @param chemFile Reads in a string denoting the filepath of your .csv
#' @param col1 String name of an initial column
#' @param col2 String name of a second column
#' @param col3 String name of a third column
#' @param col4 String name of a fourth column
#' @return Returns a dataframe containing just the targetted columns


isolateChem = function(chemFile, col1, col2, col3, col4){
  excellFile = read.csv(chemFile)#Change to read.table, search for delimiter in function call
  pFile = select(excellFile, starts_with(col1), starts_with(col2),
                 starts_with(col3), starts_with(col4))
  return(pFile)
}