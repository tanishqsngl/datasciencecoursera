rankall <- function(outcome, num = "best") {
  ## Read outcome data
  hosp_data <- read.csv("outcome-of-care-measures.csv")
  
  state <- character()
  hospital <- character()
  
  ## Check that outcome is valid
  if(outcome == "heart attack")
    x <- hosp_data[, c(2,7,11)]
  
  else if(outcome == "heart failure")
    x <- hosp_data[, c(2,7,17)]
  
  else if(outcome == "pneumonia")
    x <- hosp_data[, c(2,7,23)]
  
  else
    stop("invalid outcome")
  
  ## For each state, find the hospital of the given rank
  data_list <- split(x, x$State)
  ordered_list <- lapply(data_list, function(x)
    {
      x[, 3] <- as.numeric(x[, 3])
      x <- x[complete.cases(x), ]
      x <- x[order(x$Hospital.Name, na.last = TRUE), ]
    
      ranking <- rank(x[, 3], ties.method = "first")
      x$Rank <- as.factor(ranking)
      x <- x[order(x$Rank, na.last = TRUE), ]
      
      # if(num == "best")
      #   return(x[x$Rank == 1, 1])
      # 
      # else if(num == "worst")
      #   return(x[nrow(x), 1])
      # 
      # else if(num > nrow(x))
      #   return(NA)
      # 
      # else
      #   return(x[x$Rank == num, 1])
  })
return(ordered_list)
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  ord_list <- lapply(ordered_list, function(x, num){
    if(num == "best")
      return(x[x$Rank == 1, 1])
    
    else if(num == "worst")
      return(x[nrow(x), 1])
    
    else if(num > nrow(x))
      return(NA)
    
    else
      return(x[x$Rank == num, 1])
  }, num)
}