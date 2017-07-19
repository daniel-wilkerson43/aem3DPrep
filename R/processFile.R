#'
#'

processFile = function(filepath){
  con = file(filepath, "r")
  while(TRUE){
    line = readLines(con, n=1)
    if(length(line)==0){
      break
    }
    print(line, quote=FALSE)
  }
  close(con)
}

filepath = "C:/Users/daniel.wilkerson/Desktop/AEM3D 1.0/ConversionTest/run_aem3d.dat"
processFile(filepath)