rankhospital <- function(state, outcome, num) {
        ## Read outcome data
        ## Check that state and outcome are valid
        ## Return hospital name in that state with lowest 30-day death
        ## rate
{
        outcome_all <- data.frame()
        state_data_ordered <- data.frame()
        
        outcome_all <- read.csv("outcome-of-care-measures.csv", header = TRUE)
        colnames(outcome_all)[c(11, 17, 23)] = c("heart attack", "heart failure", "pneumonia")
        
        
        
        if (!outcome %in% colnames(outcome_all))  stop("Invalid Outcome") 
        
}           
{
        state_data <- outcome_all[outcome_all$State==state,]
        
        for (i in outcome){
                state_data[,i] <- suppressWarnings(as.numeric(levels(state_data[,i])[state_data[,i]]))
        }
        
        state_data_ordered <- state_data[order(state_data[[outcome]], state_data[["Hospital.Name"]], decreasing = FALSE, na.last = NA),]
        
        if (num=="best") num = 1
        if (num=="worst") num = nrow(state_data_ordered)
        
        print(as.character(state_data_ordered[num,2]))
}

}