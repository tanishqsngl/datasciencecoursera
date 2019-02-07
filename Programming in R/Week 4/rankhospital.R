rankhospital <- function(state, outcome, num = "best") {
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
  ## Return hospital name in that state with the given rank
  x[, 3] <- as.numeric(x[, 3])
  x <- x[complete.cases(x), ]
  x <- x[order(x$Hospital.Name, na.last = TRUE), ]
  x <- x[x$State == state, ]
  
  ranking <- rank(x[, 3], ties.method = "first")
  x$Rank <- as.factor(ranking)
  x <- x[order(x$Rank, na.last = TRUE), ]
  #return(x)
  index_value <- which.max(x[, 4])
  if(num == "best")
    return(x[x$Rank == 1, 1])

  else if(num == "worst")
    return(x[index_value, 1])
  
  else if(num > index_value)
    return(NA)
  
  else
    return(x[x$Rank == num, 1])
  ## 30-day death rate
}