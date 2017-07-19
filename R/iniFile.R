#'
#'
#'

iniFile = function(cFile, fileName, flowName, years, locations){
  lData = length(cFile)
  line1 = "!   -----------------------------------------------------------------   !"
  line2 = paste("!   Input File Name: ", fileName, "                                        !", sep="")
  line3 = paste("!   Flow  Name: ", flowName, "                                             !", sep="")
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
  line15 = paste(length(cFile$Depth), "number of depths", sep=" ")
  line16 = paste(location, "i,j", sep=" ")
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