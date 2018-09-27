
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

% Split data into x and y, feature and label
training_x = training_data(1:end, 1:end-1);
training_y = training_data(1:end, end);
testing_x = test_data(1:end, 1:end-1);
y_test = test_data(1:end, end);


% Standardize the data:
% 1) Compute the mean and standard deviation for each feature dimension using the train set only.
% 2) Subtract the mean and dividing by the stdev for each sample. 
% 3) Append a 1 for each feature vector, which will correspond to the bias that our model learns.

% 1)
% means = single row vector containing mean of each feature dimension
means = mean(training_x);

% standard_devs = single row vector containing standard deviation of each
% feature dimension.
standard_devs = std(training_x);

% 2) 
% For each sample (row), subtract mean and divide by stdev
% Initialize standardized matrix to all zeros
standardized_training_data_x = zeros(size(training_x));
standardized_testing_data_x = zeros(size(testing_x));

for sample = 1:size(training_data,1)
    standardized_training_data_x(sample, :) = (training_x(sample, :) - means) ./ standard_devs; 
    standardized_testing_data_x(sample, :) = (testing_x(sample, :) - means) ./standard_devs;
end


% 3) 
% Append a 1 for each feature vector, which will correspond to the bias that our model learns.
standardized_training_data_x = [ones(size(standardized_training_data_x,1),1) standardized_training_data_x];
standardized_testing_data_x = [ones(size(standardized_testing_data_x,1),1) standardized_testing_data_x]; 

% 2.
% Find the direct closed-form solution and evaluate the accuracy on 
% the test set, by computing the L2 distance between the predicted vector 
% y_pred and the ground-truth vector y_test. Print the L2 error in your 
% script, with an appropriate description for what is being printed; 
% use fprintf. Include it in your report.

w = lr_solve_closed(standardized_training_data_x, training_y);

% Use calculated w to predict labels of test data
y_pred = zeros(size(training_y, 1), 1);

for i = 1:size(training_y,1)
   y_pred(i) = lr_predict(standardized_testing_data_x(i,:), w); 
end

% Calculate L2 error 
l2_norm = norm(y_pred - y_test);

% Print to console
fprintf('L2 error using closed-form solution: %f\n',l2_norm)


% 3. 
% Now compute and evaluate the gradient descent solution. Use 50 iterations, 
% and experiment with the following values for the learning rate: 10.^(-6:-1). 
% Evaluate the L2 distance between predicted and ground-truth test labels as 
% above. Print the errors for each learning rate and include them in your report.

iters = 50;
learning_rates = 10.^(-6:-1);

for k = 1: size(learning_rates,2)
    eta = learning_rates(k);
    
    % Use gradient descent to get weights
    w = lr_solve_gd(standardized_training_data_x, training_y, iters, eta);
    
    % Predict labels using weights
    for i = 1:size(training_y,1)
        y_pred(i) = lr_predict(standardized_testing_data_x(i,:), w'); 
    end
    
    % Calculate L2 error
    l2_norm = norm(y_pred - y_test);
    
    % Print to console
    fprintf('L2 error using gradient solution and eta = %f: %f\n',eta, l2_norm)
end









