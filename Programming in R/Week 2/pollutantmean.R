pollutantmean <- function(directory, pollutant, id=1:332){
  if(pollutant == "sulfate")
    norow <- 2
  
  if(pollutant == "nitrate")
    norow <- 3
  
  file_list <- list.files(path=directory, pattern="*.csv")
  
  x <- numeric()
  
  for (i in id){
    a1 <- read.csv(paste(directory, file_list[i], sep = '/'))
    
    good <- a1[complete.cases(a1), ]
    x[i] <- mean(good[[norow]])
  }
  a2 <- mean(x, na.rm = TRUE)
  a2
}