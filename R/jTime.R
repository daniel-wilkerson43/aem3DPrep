
jTime = function(pFile, col1, col2){
  pFile[[col1]] = mdy(pFile[[col1]])
  pFile[[col1]] = format(pFile[[col1]], "%Y%m%d")
  pFile[[col2]] = gsub(":", "", pFile[[col2]])
  print(sum(as.numeric(pFile[[col2]])))
  if(sum(as.numeric(pFile[[col2]])==0)){
    pFile[[col2]] = "0000"
  }else{
  pFile[[col2]] = strtrim(pFile[[col2]], 4)
  }
  pFile = pFile[order(pFile[[col1]]),]
  return(pFile)
}

##Possibly legacy. Consider whether this can be removed from the code.