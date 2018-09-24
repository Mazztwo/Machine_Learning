
clc

% First, download the winequality-red.csv file, load it in Matlab 
% (e.g. using dlmread). 
all_data = dlmread("winequality-red.csv", ";", 1, 0);

% Divide the data into a training and test set 
% using approximately 50% for training.
rows = size(all_data, 1);
cols = size(all_data, 2);
training_data = all_data(1:rows/2, :);
test_data = all_data((rows/2 + 1):rows , :);

% Standardize the data, by computing the mean and standard deviation for 
% each feature dimension using the train set only, then subtracting the 
% mean and dividing by the stdev for each feature and each sample. Append 
% a 1 for each feature vector, which will correspond to the bias that our 
% model learns.