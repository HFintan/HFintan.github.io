%function Normalized=normalizeMat(MAT)
%t1=cputime;
%Cols=size(MAT,2);
%for c=1:Cols
%    MAT(:,c)=MAT(:,c)/norms(MAT(:,c));
%end
%Normalized=MAT;
%cputime-t1

% This function normalizes the columns of a matrix. (2-norm).
% (The above version was giving NaNs so I switched to this.)
function Normalized=normalizeMat(MAT)
[Rows,Cols]=size(MAT);

for c=1:Cols
    ColSum=0;
    for r=1:Rows
        ColSum=ColSum+MAT(r,c)^2;
    end
    c=c/sqrt(ColSum);
end
Normalized=MAT;
