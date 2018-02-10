% This function computes the proportion of vectors 
% of given sparsity correctly recovered by OMP.
% The preliminary function hides output from the solver.

function result = TestCoSaMP(Mat, sparsity, runs)
tic
[Output, res] = evalc('MyTestCoSaMP(Mat, sparsity, runs);');
toc
result = res;

end



function value = MyTestCoSaMP(Mat,sparsity,runs)

errfunc = [];

counter = 0;
dims = size(Mat);
cols = dims(2);
rows = dims(1);
upper = floor(rows/3);

for i = (1:runs) 
    vec = MyRandVec(cols, sparsity);
    im = Mat*vec;

    sol = OMP(Mat, im,upper, errfunc);
    nm = norm(sol-vec);
    if nm < 10^-8
       counter = counter + 1;
    end
    
end

value = counter;

end
