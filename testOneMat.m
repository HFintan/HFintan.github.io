function OneMatIter = testOneMat(ROWS, COLS, MAT_TYPE, SPARSITY_LIST, VEC_SPARSITY)
% Generates a ROWS by COLS matrix DenseMat
% Creates a number of sparsified versions of DenseMat and for each one,
% generates a sparse vector Vec and tests whether linprog (or the OMP or
% CoSaMP algorithms, if selected) successfully
% recovers it. The output is a 0,1-vector, indicating the success or
% failure of the test for of the various sparsifications.
[T,DenseMat]=evalc('generateMat(MAT_TYPE, ROWS, COLS)');
ResultsVec=zeros(1, size(SPARSITY_LIST,2));
for i=1:size(SPARSITY_LIST, 2)
    SparseMat=sparsifyMat(DenseMat, SPARSITY_LIST(i));
    Vec=randomKSparseVector(VEC_SPARSITY, COLS);
    LowVecVals=zeros(COLS, 1);
    UppVecVals=ones(COLS, 1);
    ObjectiveFunction=ones(COLS, 1);
    [T,GuessVec]=evalc('linprog(ObjectiveFunction, [], [], SparseMat, SparseMat*Vec, LowVecVals, UppVecVals)');
        % The [],[] here indicate that we are not seeking inequalities.
%    [T,GuessVec]=evalc('OMP(SparseMat, SparseMat*Vec, 10^-6, [])');
%tic
%    [T,GuessVec]=evalc('CoSaMP(SparseMat,SparseMat*Vec,VEC_SPARSITY,[])');
%toc
    ResultsVec(i)=((norm(Vec-GuessVec, 1))<10^-6);

end

OneMatIter=ResultsVec;
