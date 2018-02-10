function OneMatIter = testOneMat(ROWS, COLS, MAT_TYPE, SPARSITY_LIST, VEC_SPARSITY,ALG)
% Generates a ROWS by COLS matrix DenseMat
% Creates a number of sparsified versions of DenseMat and for each one,
% generates a sparse vector Vec and tests whether linprog (or the OMP or
% CoSaMP algorithms, if selected) successfully
% recovers it. The output is a 0,1-vector, indicating the success or
% failure of the test for each of the various sparsifications.
[T,DenseMat]=evalc('generateMat(MAT_TYPE, ROWS, COLS)');
ResultsVec=zeros(1, size(SPARSITY_LIST,2));
Vec=randomKSparseVector(VEC_SPARSITY, COLS);
LowVecVals=zeros(COLS, 1);
UppVecVals=ones(COLS, 1);
ObjectiveFunction=ones(COLS, 1);
for i=1:size(SPARSITY_LIST, 2)
    SparseMat=sparsifyMat(DenseMat, SPARSITY_LIST(i));
    if ALG=='L'
    [T,GuessVec]=evalc('linprog(ObjectiveFunction, [], [], SparseMat, SparseMat*Vec, LowVecVals, UppVecVals)');
    % The [],[] here indicate that we are not seeking inequalities.
    elseif ALG=='O'
        [T,GuessVec]=evalc('OMP(SparseMat, SparseMat*Vec, VEC_SPARSITY, [])');
    elseif ALG=='C'
    [T,GuessVec]=evalc('CoSaMP(SparseMat,SparseMat*Vec,VEC_SPARSITY,[])');
    end
    ResultsVec(i)=((norm(Vec-GuessVec, 1))<10^-6);

end

OneMatIter=ResultsVec;
