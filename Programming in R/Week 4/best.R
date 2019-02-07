best <- function(state, outcome) {
  ## Read outcome data
  hosp_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  if(outcome == "heart attack")
  {
    x <- hosp_data[, c(2,7,11)]
  }
  else if(outcome == "heart failure")
  {
    x <- hosp_data[, c(2,7,17)]
  }
  else if(outcome == "pneumonia")
  {
    x <- hosp_data[, c(2,7,23)]
  }
  else
    stop("invalid outcome")
  
  y <- state == hosp_data[, 7]
  y <- sum(as.numeric(y))
  
  if(y == 0)
    stop("invalid state")
  
  ## Return hospital name in that state with lowest 30-day death
  x <- x[order(x$Hospital.Name, na.last = TRUE), ]
  x <- x[x$State == state, ]
  index_value <- which.min(x[, 3])
  return(x[index_value, 1])
  ## rate
}