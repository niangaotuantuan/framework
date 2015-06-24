function spectral_clustering()

%load the weight matrix W 
%different ways to construct W
%--N neighbors W---
%--Gaussian W---
%--Margin W---

%to construct the D_ij & L matrix
one_vec = ones(N,1);
D = diag(W*one_vec);
L = D - W;

%Compute the n eigenvectors of L with its n smallest eigenvalues;

[vecL val] = eigs(L,200);
total_tmp = [];
for(i=1:200)
    val_tmp = val(i,i);
    total_tmp = [total_tmp,val_tmp];
end
[sort_val sort_loc] = sort(total_tmp);
vecL = vecL(:,sort_loc(1:20));
vecL = vecL./repmat(sqrt(sum(vecL.*vecL)),size(vecL,1),1);
Y = vecL';

%using k-means to cluster the points;
sys_kmeans(Y);

end
