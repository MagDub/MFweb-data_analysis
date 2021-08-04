
# function displaying res as string
make_string <- function(res, quest, meas, cor) {   
  
  res_p <- round(res$p.value,3)
  if (res_p==0){
    res_p<-'p<.001'
  } else{
    res_p<-sub("^0+", "", res_p) 
    res_p<-paste('p=',res_p, sep="")
  }
  
  out=paste(
    quest, " vs ", meas,": ", cor, " correlation: pearson R=",round(res$estimate,3),
    ", ",res_p, sep = "")
  
  return(out)
}
