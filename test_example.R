#input
m <- 100
n <- 30

W1 <- diag(m)
W1[lower.tri(W1)] <- rnorm(sum(1:m-1))
W1[upper.tri(W1)] <- t(W1)[upper.tri(t(W1))] #symmetric matrix

W2 <- diag(n)
W2[lower.tri(W2)] <- rnorm(sum(1:n-1))
W2[upper.tri(W2)] <- t(W2)[upper.tri(t(W2))] #symmetric matrix

W12 <- matrix(data=rnorm(m*n),nrow=n,ncol=m)

W <- rbind(cbind(W1,t(W12)),cbind(W12,W2))
cols <- colSums(W)
D <- diag(x=cols, nrow=m+n, ncol=m+n)
L <- D-W
eigens <- eigen(solve(D,L)) # generalized eigenvector problem
