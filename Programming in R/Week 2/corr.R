corr <- function(directory, threshold = 0){
  
  file_list <- list.files(path=directory, pattern="*.csv")
  result <- numeric()
  
  x <- complete("specdata")
  id <- x[x[[2]]>threshold, ]
    
  for(i in id[[1]]){
    a1 <- read.csv(paste(directory, file_list[i], sep = '/'))
    good <- a1[complete.cases(a1), ]
    
    result <- append(result, cor(good[[2]], good[[3]]))
  }
 result
}