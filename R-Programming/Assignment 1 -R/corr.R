corr <- function(directory, threshold = 0) {
  source("complete.R")
  
  comp_case <- complete(directory)
  cat_files <- comp_case[comp_case$nobs > threshold, 1]
  full_dir <- list.files(path = directory, full.names = TRUE)
  corr_mon_pol <- rep(NA,length(cat_files))
  
  for (i in cat_files) {
    files_full <- (read.csv(full_dir[i]))
    comp_case <- complete.cases(files_full)
    
    sulfate_data <- files_full[comp_case, "sulfate"]
    nitrate_data <- files_full[comp_case, "nitrate"]
    
    corr_mon_pol[i] <- cor(x = sulfate_data, y = nitrate_data)
  }
  
  corr_mon_pol <- corr_mon_pol[complete.cases(corr_mon_pol)]
  
  print(corr_mon_pol)
}