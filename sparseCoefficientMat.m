% This function generates a coefficient matrix of zeros and ones which will
% then be used by the sparsifyMat function. It creates a ROWS by COLS
% matrix whose columns are zero everywhere except in PROPORTION of their
% rows.

function CoefficientMat = sparseCoefficientMat(ROWS, COLS, PROPORTION)

OnesPerColumn = ceil(ROWS*PROPORTION);
CoefficientMat = zeros(ROWS, COLS);

for col = 1 : COLS
	RandRows = randperm(ROWS);              
	RowsWithOne = RandRows(1:OnesPerColumn);
	CoefficientMat(RowsWithOne, col) = 1;
end
