#' Prep a read in file for AEM3D through rloadest.
#' All data modifications should occur in this file -- bring 
#' the incoming data as close to the expected format as possible
#' to prevent errors in functions.  
library(lubridate)
library(reshape2)
library(tidyverse)
library(rloadest)
library(ggplot2)
source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/bcFile.R")
source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/iniFile.R")
source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/plotChem.R")
source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/isolateChem.R")
source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/isolateFlow.R")
source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/delQual.R")
source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/reorder.R")
source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/jTime.R")
source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/blend.R")
#source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/rLoadRun.R")
source("C:/Users/daniel.wilkerson/Documents/aem3DPrep/R/julianTime.R")
inflow1 = "C:/Users/daniel.wilkerson/Desktop/Loading data/HOLT CHEMS FMP.csv"
inflow2 = "C:/Users/daniel.wilkerson/Desktop/Loading data/SWAN RIVER CHEMS FMP.csv"
outflow1 = "C:/Users/daniel.wilkerson/Desktop/Loading data/POLSON CHEMS FMP.csv"
flow1 = "C:/Users/daniel.wilkerson/Desktop/Loading Data/LOADEST Holt Q.csv"
flow2 = "C:/Users/daniel.wilkerson/Desktop/Loading Data/LOADEST Swan Q.csv"
flow3 = "C:/Users/daniel.wilkerson/Desktop/Loading Data/LOADEST Polson Q.csv"
syn1 = ""
syn2 = ""
syn3 = ""
syn4 = ""
syn5 = ""
syn6 = ""
syn7 = ""
syn8 = ""
synLIMS1 = ""
synLIMS2 = ""
synLIMS3 = ""
synLIMS4 = ""
synLIMS5 = ""
synLIMS6 = ""
synLIMS7 = ""
synLIMS8 = ""
colName1 = "CollectDate"
colName2 = "Param"
colName3 = "Qualifier"
colName4 = "CorrectedReportedResult"
flowName1 = "Date"
flowName2 = "Q"
qualifier = c("E", "Q")
startDate = "2012-01-01"
endDate = "2013-01-01"

#' Define and tidy separate river data

# holtChem = isolateChem(inflow1, colName1, colName2, colName3, colName4) %>%
#   deleteQualifier(3, qualifier1) %>% deleteQualifier(3, qualifier2) %>%
#   reorder(colName1, colName2, colName4)
# swanChem = isolateChem(inflow2, colName1, colName2, colName3, colName4) %>%
#   deleteQualifier(3, qualifier1) %>% deleteQualifier(3, qualifier2) %>%
#   reorder(colName1, colName2, colName4)
# polsChem = isolateChem(outflow1, colName1, colName2, colName3, colName4) %>%
#   deleteQualifier(3, qualifier1) %>% deleteQualifier(3, qualifier2) %>%
#   reorder(colName1, colName2, colName4)

holtChem = isolateChem(inflow1, colName1, colName2, colName3, colName4) %>%
  deleteQualifier(3, qualifier) %>% reorder(colName1, colName2, colName4)
swanChem = isolateChem(inflow2, colName1, colName2, colName3, colName4) %>%
  deleteQualifier(3, qualifier) %>% reorder(colName1, colName2, colName4)
polsChem = isolateChem(outflow1, colName1, colName2, colName3, colName4) %>%
  deleteQualifier(3, qualifier) %>% reorder(colName1, colName2, colName4)

holtFlow = isolateFlow(flow1, flowName1, flowName2)
swanFlow = isolateFlow(flow2, flowName1, flowName2)
polsFlow = isolateFlow(flow3, flowName1, flowName2)

holtFlow$Time = "00:00:00"
swanFlow$Time = "00:00:00"
polsFlow$Time = "00:00:00"

holtFlow = jTime(holtFlow, "Date", "Time")
swanFlow = jTime(swanFlow, "Date", "Time")
polsFlow = jTime(polsFlow, "Date", "Time")

colnames(holtChem)[1] = "CollectDate"
colnames(swanChem)[1] = "CollectDate"
colnames(polsChem)[1] = "CollectDate"

#' Equations occur here -- Isolating compulsory AEM3D variables from our chem data.

reFrame1 = data.frame(holtChem$`NO3-N`, holtChem$`NO2/3`, holtChem$`NO3/NO2`) %>% select(3, 2, 1)
reFrame2 = data.frame(swanChem$`NO3-N`, swanChem$`NO2/3`, swanChem$`NO3/NO2`) %>% select(3, 2, 1)
reFrame3 = data.frame(polsChem$`NO3-N`, polsChem$`NO2/3`, polsChem$`NO3/NO2`) %>% select(3, 2, 1)

reFrame4 = data.frame(holtChem$TN, holtChem$TPN, holtChem$TKN) %>% select(3, 2, 1)
reFrame5 = data.frame(swanChem$TN, swanChem$TPN, swanChem$TKN) %>% select(3, 2, 1)
reFrame6 = data.frame(polsChem$TN, polsChem$TPN, polsChem$TKN) %>% select(3, 2, 1)

holtChem$NOx = do.call(dplyr::coalesce, rev(reFrame1))
swanChem$NOx = do.call(dplyr::coalesce, rev(reFrame2))
polsChem$NOx = do.call(dplyr::coalesce, rev(reFrame3))

holtChem$TN = do.call(dplyr::coalesce, rev(reFrame4))
swanChem$TN = do.call(dplyr::coalesce, rev(reFrame5))
polsChem$TN = do.call(dplyr::coalesce, rev(reFrame6))

#' More data sorting and tidying

holtChem = select(holtChem, "CollectDate", "DIC", "DOC", "NDOC", "NH4-N",
               "pH", "SiO2", "SRP", "TP", "TN", "NOx")
swanChem = select(swanChem, "CollectDate", "DIC", "DOC", "NDOC", "NH4-N",
               "pH", "SiO2", "SRP", "TP", "TN", "NOx")
polsChem = select(polsChem, "CollectDate", "DIC", "DOC", "NDOC", "NH4-N",
               "pH", "SiO2", "SRP", "TP", "TN", "NOx")

holtChem$NH4N = holtChem$`NH4-N`
swanChem$NH4N = swanChem$`NH4-N`
polsChem$NH4N = polsChem$`NH4-N`

holtChem = holtChem[,-5]
swanChem = swanChem[,-5]
polsChem = polsChem[,-5]

holtChem = separate(holtChem, CollectDate, c("Date", "Time"), sep=" ") %>% jTime("Date", "Time") %>%
  merge(holtFlow, all=TRUE) %>% select("Date", "Time", "Q", everything())
swanChem = separate(swanChem, CollectDate, c("Date", "Time"), sep=" ") %>% jTime("Date", "Time") %>%
  merge(swanFlow, all=TRUE) %>% select("Date", "Time", "Q", everything())
polsChem = separate(polsChem, CollectDate, c("Date", "Time"), sep=" ") %>% jTime("Date", "Time") %>%
  merge(polsFlow, all=TRUE) %>% select("Date", "Time", "Q", everything())

#' Data at this point is as tidy as it needs to be to run rloadest. Make sure
#' that the variables you want to use are all contained within the chem data frame
#' at this point. The subsets are to send in to rloadest's predConc to isolate a year
#' of loading data. Loading dataframes are created to store the rloadest output.

holtChem$Q = as.numeric(holtChem$Q)
swanChem$Q = as.numeric(swanChem$Q)
polsChem$Q = as.numeric(polsChem$Q)

holtChem$Date = as.Date(ymd(holtChem$Date))
swanChem$Date = as.Date(ymd(swanChem$Date))
polsChem$Date = as.Date(ymd(polsChem$Date))

subChemH = subset(holtChem, holtChem$Date >= startDate & holtChem$Date < endDate)
subChemH$Q = as.numeric(subChemH$Q)
subChemS = subset(swanChem, swanChem$Date >= startDate & swanChem$Date < endDate)
subChemS$Q = as.numeric(subChemS$Q)
subChemP = subset(polsChem, polsChem$Date >= startDate & polsChem$Date < endDate)
subChemP$Q = as.numeric(subChemP$Q)

holtLoading = data.frame(subChemH$Date, subChemH$Time, subChemH$Q)
swanLoading = data.frame(subChemS$Date, subChemS$Time, subChemS$Q)
polsLoading = data.frame(subChemP$Date, subChemP$Time, subChemP$Q)

#' If the code is going to break, it'll PROBABLY be here. Iterate
#' through the three river chem files and create loading
#' data for each. If there are ANY math errors, they come from here.

varNames1 = colnames(holtChem)
varNames2 = colnames(swanChem)
varNames3 = colnames(polsChem)

if(all(varNames1!=varNames2) & all(varNames1!=varNames3) & all(varNames2!=varNames3)){
  stop("Column names are not the same in all data frames.")
}

#' Loop through a rloadest function. Currently breaking for reasons unknown, will revisit
#' at a later date.
# for(i in 4:length(varNames1)){
#   concentration1 = rLoadRun(holtChem, subChemH, varNames1[i], "Q",
#                            "Date", "Holt Station")
#   concentration2 = rLoadRun(swanChem, subChemS, varNames1[i], "Q",
#                            "Date", "Swan Station")
#   concentration3 = rLoadRun(polsChem, subChemP, varNames1[i], "Q",
#                            "Date", "Polson Station")
#   holtLoading[varNames1[i]] = concentration1[3]
#   swanLoading[varNames1[i]] = concentration2[3]
#   polsLoading[varNames1[i]] = concentration3[3]
# }

for(i in 4:length(varNames1)){
  rRun1 = selBestModel(varNames1[i], data=holtChem, flow="Q", flow.units="cms",
                                         dates="Date", station="Holt station", time.step="day")
  concentration1 = predConc(rRun1, subChemH, by="day")
  rRun2 = selBestModel(varNames2[i], data=swanChem, flow="Q", flow.units="cms",
                                         dates="Date", station="Swan station", time.step="day")
  concentration2 = predConc(rRun2, subChemS, by="day")
  rRun3 = selBestModel(varNames3[i], data=polsChem, flow="Q", flow.units="cms",
                                         dates="Date", station="Polson station", time.step="day")
  concentration3 = predConc(rRun3, subChemP, by="day")
  holtLoading[varNames1[i]] = concentration1[3]
  swanLoading[varNames2[i]] = concentration2[3]
  polsLoading[varNames3[i]] = concentration3[3]
}

#' Rename variables to AEM3D expected headers, cull unnecessary data.

holtLoading$TIME = julianTime(holtLoading$subChemH.Date, as.numeric(as.character(holtLoading$subChemH.Time)))
swanLoading$TIME = julianTime(swanLoading$subChemS.Date, as.numeric(as.character(swanLoading$subChemS.Time)))
polsLoading$TIME = julianTime(polsLoading$subChemP.Date, as.numeric(as.character(polsLoading$subChemP.Time)))

holtLoading$INFLOW = holtLoading$subChemH.Q
swanLoading$INFLOW = swanLoading$subChemS.Q
polsLoading$OUTFLOW = polsLoading$subChemP.Q

holtLoading = holtLoading[,-c(1, 2, 3)]
swanLoading = swanLoading[,-c(1, 2, 3)]
polsLoading = polsLoading[,-c(1, 2, 3)]

holtLoading = select(holtLoading, "TIME", "INFLOW", everything())
swanLoading = select(swanLoading, "TIME", "INFLOW", everything())
polsLoading = select(polsLoading, "TIME", "OUTFLOW", everything())

#' This section will be used to kick data into boundary condition files or
#' ini files, depending on what's needed and where it's used.

bcFile(holtLoading, "C:/Users/daniel.wilkerson/Desktop/Holt2012outTest.txt", "Holt River", "2012", "0  1  1  1  1  1  1  1  1  1  1  1")
bcFile(swanLoading, "C:/Users/daniel.wilkerson/Desktop/Swan2012outTest.txt", "Swan River", "2012", "0  1  1  1  1  1  1  1  1  1  1  1")
bcFile(polsLoading, "C:/Users/daniel.wilkerson/Desktop/Pols2012outTest.txt", "Polson River", "2012", "0  1  1  1  1  1  1  1  1  1  1  1")

#' This section will rewrite necessary files in AEM3D (Namely, pre_aem3d.dat and
#' run_aem3d.dat, also datablock.xml to ensure you're getting the expected output)

#' This section will run AEM3D and kick it's output files into a new directory.
#' MAKE SURE IF YOU DOWNLOAD THIS FROM GITHUB THAT YOU RESET DIRECTORIES. I know
#' it's a bad coding practice to write in directories, but we're primarily using
#' this in house. Use at your own risk.

