pollutantmean <- function(directory, pollutant, id = 1:332)
{files_full <- list.files(path = directory, full.names = TRUE)
 requestedfiles <- data.frame()
 for (i in id) {
   requestedfiles <- rbind(requestedfiles, read.csv(files_full[i]))
 }
 if (pollutant == "sulfate"){
   mean(requestedfiles$sulfate, trim = 0, na.rm = TRUE)
 }
 else if (pollutant == "nitrate"){
   mean(requestedfiles$nitrate, trim = 0, na.rm = TRUE)
 }
}