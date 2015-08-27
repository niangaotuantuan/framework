# get reproducible data
reut21578 <- system.file("texts", "crude", package = "tm")
(r <- Corpus(DirSource(reut21578),
             readerControl = list(reader = readReut21578XMLasPlain)))

# voodoo to give Java 2 gb of RAM, have to do it before loading JVM
options(java.parameters = "-Xmx2g" ) 
# load and install packages if not already
list.of.packages <- c("tm", "openNLP", "openNLPmodels.en")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(list.of.packages , require, character.only=T)

# function to include a gc after POS tagging (for lapply and ldply)
tmTagPOS_gc <- function(x) tmTagPOS(x); invisible(gc(v=FALSE))

# function for POS tagging without gc
r_POStag_loop_fn <- function(j){
  r_POStag_loop <- vector(mode = "numeric", length = length(j))
 for(i in 1:length(j)){
   r_POStag_loop[[i]] <- tmTagPOS(r[[i]])
   cat(paste0(i," of ", length(r), " items\n")) 
   flush.console()   
 }
 return(j)
}

# function for POS tagging with gc
r_POStag_loop_gc_fn <- function(j){
  r_POStag_loop <- vector(mode = "numeric", length = length(j))
  for(i in 1:length(j)){
    r_POStag_loop[[i]] <- tmTagPOS(r[[i]])
    invisible(gc(v=FALSE)) 
    cat(paste0(i," of ", length(r), " items\n")) 
    flush.console()   
  }
  return(j)
}

# benchmarking...
library(plyr)
library(microbenchmark)    
results <- microbenchmark(
  lapply(r, tmTagPOS),
  lapply(r, tmTagPOS_gc),
  ldply(r, tmTagPOS, .progress = "text"),
  ldply(r, tmTagPOS_gc, .progress = "text"),
  r_POStag_loop_fn(r),
  r_POStag_loop_gc_fn(r),
times = 100L)
print(results)