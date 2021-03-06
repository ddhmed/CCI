#' FCI's skeleton discovery procedure adapted for CCI
#' @param suffStat List containing suffStat$data
#' @param indepTest The independence test
#' @param alpha Type I error rate for indepTest
#' @return List containing the skeleton data

IP_discovery <- function(suffStat,indepTest,alpha, p,max.cs=Inf){

  time_start <- proc.time();
  skel <- skeleton_new(suffStat, indepTest, alpha, p = p, m.max=max.cs)

  G_sk <- as(skel@graph, "matrix")
  sepset_sk <- skel@sepset

  time_skel = proc.time()-time_start;

  pdsepRes <- pdsep(skel@graph, suffStat, indepTest,
                    p=p, sepset_sk, alpha, skel@pMax, m.max=max.cs)

  G <- pdsepRes$G
  sepset <- pdsepRes$sepset

  time_pdsep = proc.time()-time_start;

  resIP <- list(G=G,G_sk=G_sk, sepset=sepset, sepset_sk = sepset_sk, time_skel=time_skel, time_pdsep=time_pdsep, skel=skel, pdsepRes=pdsepRes)

  return(resIP)

}
