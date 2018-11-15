% 1. 
clc

% Load the wine dataset
all_data = dlmread("winequality-red.csv", ";", 1, 0);

% Define the train/test split as in HW3
rows = size(all_data, 1);
cols = size(all_data, 2);
training_data = all_data(1:rows/2, :);
X = training_data(:, 1:end-1);
y = training_data(:, end);
test_data = all_data((rows/2 + 1):rows , :);
y_test = test_data(:, end);

% Set the number of hidden units
M = 30;

% Set the number of iterations to run
iters = 1000;

% Set the learning rates
learning_rates = [0.1 0.01 0.001];


for i  = 1:3
    eta = learning_rates(i);
    %2. Call the backward function to construct and train the network. 
    %   Use 1000 iterations and 30 hidden neurons.
    W1, W2, error_over_time = backward(X, y, M, iters, eta);
    
    %3. Call the forward function to make predictions and compute the root 
    %   mean squared error between predicted and ground-truth labels.  
    %   Report this number in a file report.pdf/docx
    y_pred, Z = forward(test_data, W1, W2);
    
    rms = sqrt(mean((y_pred - y_test).^2));
    
    plot(error_over_time, rms)
    title(['learning rate: ', eta]);
    xlabel('iteration');
    ylabel('MSE');
    
    fprintf('RMS for eta %f:  %f\n',eta, rms);
    
end


