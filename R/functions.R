#' @import dplyr
worker_fct1 = function(i) {
  df = data.frame(x = 1:i, y = (1:i)^2)

  out = head(dplyr::group_by(df, x), 1)

  return(out)
}

#' @export
master_fct1 = function(n = 1) {
  cl = parallel::makePSOCKcluster(
    names = 1L
  )

  out = parallel::clusterApplyLB(
    cl = cl,
    x = 1:n,
    fun = worker_fct1
  )

  parallel::stopCluster(cl)

  return(out)
}

#' @import dplyr
worker_fct2 = function(i) {
  df = data.frame(x = 1:i, y = (1:i)^2)

  out = dplyr::summarize_all(df, mean)

  return(out)
}

#' @export
master_fct2 = function(n = 1) {
  cl = parallel::makePSOCKcluster(
    names = 1L
  )

  out = parallel::clusterApplyLB(
    cl = cl,
    x = 1:n,
    fun = worker_fct2
  )

  parallel::stopCluster(cl)

  return(out)
}
