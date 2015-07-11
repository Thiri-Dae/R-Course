best <- function(state, outcome) {
        ## Read outcome data
        ## Check that state and outcome are valid
        ## Return hospital name in that state with lowest 30-day death
        ## rate
{
        outcome_all <- data.frame()
        ordered_state_data <- data.frame()
        ordered_state_data_comp <- data.frame()
                
                outcome_all <- read.csv("outcome-of-care-measures.csv", header = TRUE)
                colnames(outcome_all)[c(11, 17, 23)] = c("heart attack", "heart failure", "pneumonia")
             
               
                if (!state %in% outcome_all$State)  stop("Invalid State")
                 else if (!outcome %in% colnames(outcome_all))  stop("Invalid Outcome") 
}           
   {
                        state_data <- outcome_all[outcome_all$State==state,]
                        
                        for (i in outcome){
                                state_data[,i] <- suppressWarnings(as.numeric(levels(state_data[,i])[state_data[,i]]))
                        }
                        state_data_ordered <- state_data[order(state_data[,outcome], decreasing = FALSE),]
                        state_data_ordered_comp <- state_data_ordered[complete.cases(state_data_ordered[,outcome]),] 
                        
                        print(as.character(state_data_ordered_comp[1,2]))
   }
                        
        }