%1. 
% Download the data file. The last value in each row contains the target 
% label for that row, and the remaining values are the features. Split the 
% data into 10 approximately equally-sized "folds". Your results reported 
% below should be an average of the results when you train on the first 9 
% folds and test on the remaining 1, then if you train on the folds numbered 
% 1 through 8 and the 10th fold and testing on the 9th fold, etc. For 
% simplicity, you can use folds of size 76 and drop the remaining 8 instances.

clc, clear

% Read in file
raw_data = csvread('pima.data');
cols = size(raw_data,2)-1;

% discard last 8 rows
x_data = raw_data(1:760,1:cols);
y_data = raw_data(1:760,end);

% Split the data
folds = zeros(76,cols,10);

% Create folds 
st = 1;
en = 76;
for fold = 1:10
    folds(:,:,fold) = x_data(st:en,:);
    st = st + 76;
    en = en + 76;
end







