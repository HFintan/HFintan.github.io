function Results=findRx(ROWS, COLS, MAT_TYPE, ITERS_LIST, X, MAT_SPARSITY,ALG)
% This function finds the maximum value k at which a ROWSxCOLS matrix of 
% sparsity MAT_SPARSITY successfully recovers all k-sparse vectors. This is
% achieved by running a few tests over all iterations to find the region of
% interest, and then more tests over this region of interest to find a
% candidate k, and finally a large number of tests to verify that k-sparse
% vectors are recovered, but k+1-sparse vectors are not. These numbers of
% tests are dictated by the ITERS_LIST.
k=1; j=1;
ResultsVec=zeros(ROWS/3,1);
while j<size(ITERS_LIST,2)
    ResultsVec(k,1)=0;
    for i=1:ITERS_LIST(j)
        ResultsVec(k,1)=ResultsVec(k,1)+testOneMat(ROWS, COLS, MAT_TYPE, [MAT_SPARSITY], k,ALG);            
    end
    display(ResultsVec);
    if ResultsVec(k,1)<ceil(ITERS_LIST(j)*(X))
        j=j+1;
        k=max(1,k-5);
    else
        k=k+1;
    end
end;
test=true;
while test==true;
    ResultsVec(k,1)=0;
    for i=1:ITERS_LIST(j)
        ResultsVec(k,1)=ResultsVec(k,1)+testOneMat(ROWS, COLS, MAT_TYPE, [MAT_SPARSITY], k,ALG);
    end
    if ResultsVec(k,1)<ceil(ITERS_LIST(j)*(X))
        test=false;
    else
        k=k+1;
    end
end
%ResultsVec=
%display(k-1);
%Results=(ResultsVec);
Results=k-1;
