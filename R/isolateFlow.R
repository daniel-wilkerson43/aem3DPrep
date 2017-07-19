#' Isolate columns from a .csv file
#' 
#' Function is intended to separate out useful data from
#' extraneous data that is unnecessary for AEM3D processing. Use
#' this for flow data files.
#' !!!CAUTION!!!
#' This is currently a weak spot in the code -- Flow files are coming in
#' with several different formats. Must be uniquely tailored to each run.
#' 
#' @param flowFile Reads in a string denoting the filepath of your .csv
#' @param col1 String name of an initial column
#' @param col2 String name of a second column
#' @return Returns a dataframe containing just the targetted columns


isolateFlow = function(flowFile, col1, col2){
  excellFile = read.csv(flowFile, col.names=c("Date", "Q"))
  fFile = select(excellFile, starts_with(col1), starts_with(col2))
  fFile = fFile[-c(1, 2),] #Specify lines to be deleted in function call
  return(fFile)
}