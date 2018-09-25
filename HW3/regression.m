
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

% Standardize the data:
% 1) Compute the mean and standard deviation for each feature dimension using the train set only.
% 2) Subtract the mean and dividing by the stdev for each sample. 
% 3) Append a 1 for each feature vector, which will correspond to the bias that our model learns.

% 1)
% means = single row vector containing mean of each feature dimension
means = mean(training_data);

% standard_devs = single row vector containing standard deviation of each
% feature dimension.
standard_devs = std(training_data);

% 2) 
% For each sample (row), subtract mean and divide by stdev
% Initialize standardized matrix to all zeros
standardized_training_data = zeros(size(training_data));

for sample = 1:size(training_data,1)
    standardized_training_data(sample) = (training_data(sample, : ) - means) / standard_devs ;
end


% 3) 
% Append a 1 for each feature vector, which will correspond to the bias that our model learns.
standardized_training_data = [ones(size(standardized_training_data,1),1) standardized_training_data];




