% We work through the functions for the second graph in the paper.

% Make a data file

fileID = fopen('graphfour.txt', 'w');
Data = [];

Rows = [100, 150, 200, 250, 300, 350, 400 ,450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1100, 1200, 1300, 1400, 1500];

for T=Rows
a = findRx(T, 10*T, 'N', [100, 500], 0.98, 1, 'C');
b = findRx(T, 10*T, 'N', [100, 500], 0.98, 0.7, 'C');
c = findRx(T, 10*T, 'N', [100, 500], 0.98, 0.4, 'C');
d = findRx(T, 10*T, 'N', [100, 500], 0.98, 0.1, 'C');
e = findRx(T, 10*T, 'N', [100, 500], 0.98, 0.05, 'C');

result = [a, b, c, d, e];

fprintf(fileID, '%5d %5d %5d %5d %5d \n',result);
Data = [Data; result];
end

fclose(fileID);





