complete <- function(directory, id = 1:332) {
  files_full <- list.files(path = directory, full.names = TRUE)
  requestedfiles <- data.frame()
  compcase <- data.frame()  
  nonNAfiles <- data.frame()
   for (i in id) { 
    requestedfiles <- (read.csv(files_full[i],header=TRUE))
   
    compcase <- sum(complete.cases(requestedfiles))
     
    nonNAfiles <- rbind(nonNAfiles, data.frame(i,compcase))
  }
  colnames(nonNAfiles) <- c("id", "nobs")
 nonNAfiles
}