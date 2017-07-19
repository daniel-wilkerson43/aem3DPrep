#' Delete unnecessary rows containing qualifiers.
#'
#' @param pFile datafram containing the variables to be isolated
#' @param qual String of the qualifier used to denote removal in dataset
#' @param qualCol String name of the column containing qualifiers
#' @return Returns the original dataframe with rows containing qualifiers removed. 

deleteRow = function(pFile, qual, qualCol){
  colNum = which(colnames(pFile)==qualCol)
  remRows = which(grepl(qual, pFile[colNum]))
  pFile = pFile[-(remRows),]
  return(pFile) 
}

# deleteQualifier = function(pFile, colNum, qualifier){
#   values = which(pFile[colNum]==qualifier) #Allow qualifier to be a vector -- iterate through qualifiers and delete all
#   j = colNum + 1 
#   for(i in values){
#     pFile[i, j] = NA
#   }
#   return(pFile)
# }

deleteQualifier = function(pFile, colNum, qualifier){
  for(i in 1:length(qualifier)){
    values = which(pFile[colNum]==qualifier[i])
    j = colNum + 1 
    for(i in values){
      pFile[i, j] = NA
    }
  }
  return(pFile)
}