#' Write a boundary condition file using a given dataframe.
#' 
#' @param cFile Send in a dataframe to be read into file.
#' @param fileName Name (and directory, if necessary) of output file
#' @param flowName Name (as a string) of the flow
#' @param years A string of the years your simulation will cover
#' @param locations AEM3D uses these numeric location tags to identify where the parameter affects the lake. Send in as a string double spaced.
#'

bcFile = function(cFile, fileName, flowName, years, locations){
  lData = length(cFile)
  line1 = "!   -----------------------------------------------------------------   !"
  line2 = paste("!   Input File Name: ", fileName, "                                        !", sep="")
  line3 = paste("!   Inflow  Name: ", flowName, "                                             !", sep="")
  line4 = paste("!   Years: ", years, "                                                  !", sep="")
  line5 = "!   --Site keys------------------------------------------------------   !"
  line6 = "!   --MLD: Midlake Deep----------------------------------------------   !"
  line7 = "!   --MLN: Midlake North---------------------------------------------   !"
  line8 = "!   --NAR: Narrows---------------------------------------------------   !"
  line9 = "!   --NOR: Northshore------------------------------------------------   !"
  line10= "!   --SWR: Swan River------------------------------------------------   !"
  line11= "!   --HOL: Holt------------------------------------------------------   !"
  line12= "!   --POL: Polson----------------------------------------------------   !"
  line13= "!   -----------------------------------------------------------------   !"
  line14 = paste(lData-1, " data sets", sep="")
  line15 = "0  seconds between data"
  line16 = locations
  write(line1, file=fileName, append=FALSE)
  write(line2, file=fileName, append=TRUE)
  write(line3, file=fileName, append=TRUE)
  write(line4, file=fileName, append=TRUE)
  write(line5, file=fileName, append=TRUE)
  write(line6, file=fileName, append=TRUE)
  write(line7, file=fileName, append=TRUE)
  write(line8, file=fileName, append=TRUE)
  write(line9, file=fileName, append=TRUE)
  write(line10, file=fileName, append=TRUE)
  write(line11, file=fileName, append=TRUE)
  write(line12, file=fileName, append=TRUE)
  write(line13, file=fileName, append=TRUE)
  write(line14, file=fileName, append=TRUE)
  write(line15, file=fileName, append=TRUE)
  write(line16, file=fileName, append=TRUE)
  write.table(cFile, sep="\t", quote=FALSE, row.names=FALSE, file=fileName, append=TRUE)
}

# ##Constants##
# pFile = read.table("C:/Users/daniel.wilkerson/Desktop/testout.txt", sep="\t")
# fileName = file("Test.txt")
# flowName = "TestFlow"
# years = "2010 - 2017"
# lData = length(pFile)
# locations = readline("Enter the location values separated by two spaces: ")
# 
# 
# line1 = "!   -----------------------------------------------------------------   !"
# line2 = paste("!   Input File Name: ", fileName, "                                        !", sep="")
# line3 = paste("!   Inflow  Name: ", flowName, "                                        !", sep="")
# line4 = paste("!   Years: ", years, "                                                  !", sep="")
# line5 = "!   -----------------------------------------------------------------   !"
# line6 = paste(lData-1, " data sets", sep="")
# line7 = "0  seconds between data"
# line8 = locations
# writeLines(line1, fileName)
# writeLines(line2, fileName)
# writeLines(line3, fileName)
# writeLines(line4, fileName)
# writeLines(line5, fileName)
# writeLines(line6, fileName)
# writeLines(line7, fileName)
# writeLines(line8, fileName)
# write.table(pFile, sep="", file="Test.txt", append=TRUE)
