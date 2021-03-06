% This function returns a normalized vector in which a random selection of K_SPARSITY
% of its ROWS rows are non-zero. The non-zero values are on the interval
% (0,1).

function V = randomKSparseVector(K_SPARSITY, ROWS)

V=zeros(ROWS, 1);
for i=1:K_SPARSITY
      	V(i,1)=abs(rand);
end
V=V(randperm(length(V)));
V(:,1)=V(:,1)/norm(V(:,1));
end
