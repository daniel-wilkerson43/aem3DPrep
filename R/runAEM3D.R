#' Set working directory and run AEM3D
#' 
#' MAKE SURE setwd() paths to the directory aem3d.exe is located in. WILL NOT
#' RUN if your working directory isn't the same -- Can't find run_aem3d.dat otherwise.
#' Customize file paths as necessary.If you need to end the run early, you MUST kill
#' the process -- Stopping the R script will not end the run.

setwd('C:\\Users\\daniel.wilkerson\\Desktop\\AEM3D 1.0\\test\\RoundLake\\run')
shell('C:\\Users\\daniel.wilkerson\\Desktop\\"AEM3D 1.0"\\test\\RoundLake\\run\\aem3d_openmp.exe')

##include pre_aem3d in here as well