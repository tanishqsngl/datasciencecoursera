complete <- function(directory, id = 1:332){
  
  file_list <- list.files(path=directory, pattern="*.csv")
  len <- numeric()
  nobs <- numeric()
  j <- 1
  
  for(i in id){
    a1 <- read.csv(paste(directory, file_list[i], sep = '/'))
    
    good <- a1[complete.cases(a1), ]
    nobs[j] <- length(good[[1]])
    len[j] <- i
    j <- j+1
  }
  x <- data.frame(id = len, nobs = nobs)
  x
}