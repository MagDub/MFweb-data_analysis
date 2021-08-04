
make_pval_u_ <- function(pval) {   
  
  if (pval<0.001){
    pval_new<-'p_u<.001'
  } else{
    pval_new<-sub("^0+", "", pval) 
    pval_new<-paste('p_u=',round(pval,3), sep="")
  }
  
  return(pval_new)
}
