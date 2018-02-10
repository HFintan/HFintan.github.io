% This function computes the proportion of vectors 
% of given sparsity correctly recovered by OMP.
% The preliminary function hides output from the linear 
% programming solver.

function result = TestOMP(Mat, sparsity, runs)
tic
[Output, res] = evalc('MyTestOMP(Mat, sparsity, runs);');
toc
result = res;

end



function value = MyTestOMP(Mat,sparsity,runs)

errfunc = [];

counter = 0;
dims = size(Mat);
cols = dims(2);

for i = (1:runs) 
    vec = MyRandVec(cols, sparsity);
    im = Mat*vec;

    sol = OMP(Mat, im, 10^-8, errfunc);
    nm = norm(sol-vec);
    if nm < 10^-8
       counter = counter + 1;
    end
    
end

value = counter;

end
