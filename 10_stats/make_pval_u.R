
make_pval_u <- function(pval) {   
  
  pval_ <- round(pval,3)
  if (pval_==0){
    pval_new<-'p_u<.001'
  } else{
    pval_new<-sub("^0+", "", pval_) 
    pval_new<-paste('p_u=',pval_, sep="")
  }
  
  return(pval_new)
}
