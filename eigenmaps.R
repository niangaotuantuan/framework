seq1 <- c(1,2,3,2,1,2,3,2,1)
mat1 <- matrix(seq1, 3)
seq2 <- rep(0, 9)
mat2 <- matrix(seq2, 3)
mat12 <- cbind(mat1, mat2)
mat34 <- cbind(mat2, mat1)
W <- rbind(mat12, mat34)
cols <- colSums(W)
D <- diag(x=cols, nrow=6, ncol=6)
L <- D-W
eigens <- eigen(solve(D,L)) # generalized eigenvector problem