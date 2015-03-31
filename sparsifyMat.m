% This function takes a dense matrix DENSE_MAT and returns a sparse matrix
% SparseMat where PROPORTION of the entries in each column of SparseMat 
% are equal to the corresponding entries in DENSE_MAT and all other entries
% are zero. This is done by taking the pointwise product with a random
% zero-one matrix CoefficientMat, of which PROPORTION entries in each
% column are 1.

function SparseMat = sparsifyMat(DENSE_MAT, PROPORTION);
        if PROPORTION==1
            Mat=DENSE_MAT;
        else
        [Rows, Cols] = size(DENSE_MAT);
        CoefficientMat = sparsifyingMat(Rows, Cols, PROPORTION);
        Mat = DENSE_MAT .* CoefficientMat;             % Pointwise product.
        end
