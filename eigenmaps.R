L  <- diag(rowSums(W)) - W # D-W, D is diagonal matrix
l <- nrow(L)
eigens <- NULL # eigenvectors
M <- NULL # object to be returned, p-dimentional embedding

eigenmap <- function(W, measure_type = c('unorm','norm'), p = 2) {
  measure_type <- match.arg(measure_type)
  if(nrow(W) != ncol(W)) {
    print('Input weight matrix W must be symmetric')
    return( NULL )
  }

  if(measure_type == 'norm') {
    Ds <- diag(1/sqrt(rowSums(W)))
    L_sym <- Ds %*% L %*% Ds
    eigens <- eigen(L_sym, symmetric=T) # values ordered in decreasing order
    M <- diag(Ds) * eigens$vectors[,(l-1):(l-p)]
  }
  if(measure_type == 'unorm') {
    L  <- diag(rowSums(W)) - W  # corrosponding to the algorithm --> D-W
    eigens <- eigen(L, symmetric=T) # values ordered in decreasing order
    l <- nrow(L)
    M <- eigens$vectors[,(l-1):(l-p)]
  }

  if(sum(eigens$values == 0) > 1) {
  	warning(paste('More than one non-zero eigenvalue - disjoint clusters. Multiplicity: ', 
  		         sum(eigens$values == 0)) )
  }

  colnames(M) <- paste0('component_', 1:p)
  M <- data.frame(M)
  
  return( M )
}