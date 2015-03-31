%This function is a work in progress.

function GenMat=generateMat(type,rows,cols,lowb,uppb);
% Generates a random matrix of size rows by cols
% with entries uniformly distributed on the open interval
% between 0 and 1 if type begins with V, or with entries
% uniformly distributed between lowerb and upperb if type 
% begins with U, or normally distributed about 0 if type begins
% with N.
% Additionally, if type includes a T then the matrix is Toeplitz
% and if type includes a P then the matrix is partial circulant.
%
if type=='V'
    GenMat=rand(rows,cols);
elseif type=='U'
    GenMat=randi([lowb,uppb],rows,cols);
elseif type=='N'
    GenMat=abs(randn(rows,cols)); % Note the new ABS!
elseif type=='VP'
    GenMat=PartialCirculant(type,rows,cols);
elseif type=='F'
    GenMat=abs(OurFourierMat(rows)); % We assume it's got 2000 columns... And we take abs... necessary?
elseif type=='VT'
    GenMat=ToeplitzMat(type,rows,cols);
elseif type=='UP'
    GenMat=PartialCirculant(type,rows,cols,lowb,uppb);
elseif type=='UT'
    GenMat=ToeplitzMat(type,rows,cols,lowb,uppb);
elseif type=='NP'
    GenMat=abs(PartialCirculant(type,rows,cols,type));
elseif type=='NT'
    GenMat=abs(ToeplitzMat(type,rows,cols));
elseif type=='B'
    GenMat=BernoulliMat(rows,cols);
end;
