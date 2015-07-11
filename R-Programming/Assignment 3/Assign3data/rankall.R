rankall <- function(outcome, num = "best") {

        outcome_all <- data.frame()
        hospital <- character()
        
        outcome_all <- read.csv("outcome-of-care-measures.csv", header = TRUE,)
        colnames(outcome_all)[c(11, 17, 23)] = c("heart attack", "heart failure", "pneumonia")
        
        state <- sort(unique(outcome_all$State))
        
       
        if (!outcome %in% colnames(outcome_all))  stop("Invalid Outcome") 
        
        if (num=="best") num = 1
        

for (s in seq_along(state))
{
        state_data <- outcome_all[outcome_all$State==state[s],]
        
                for (i in outcome){
                        state_data[,i] <- suppressWarnings(as.numeric(levels(state_data[,i])[state_data[,i]]))
                }
           
        state_data_ordered <- state_data[order(state_data[[outcome]], state_data[["Hospital.Name"]], decreasing = FALSE, na.last = NA),]
        
        x <- length(state_data_ordered[[outcome]])
        
        if (num=="worst") num = as.numeric(x)
     
        hospital[s] <- as.character(state_data_ordered[num, 2])
}  

data.frame(hospital, state, row.names=state)

}

