
% Inputs:
% an NxD matrix X of features, where N is the number of samples and D is the number of feature dimensions,
% an Nx1 vector y containing the ground-truth labels for the N samples,
% a scalar M containing the number of hidden layers to use,
% a scalar iters defining how many iterations to run (one sample used in each), and a scalar eta defining the learning rate to use.

% Outputs:
% MxD matrix W1 of weights between the first and second layer of the network, where M is the number of hidden neurons, and
% 1xM matrix W2 of weights between the second and third layer of the network, where there is a single neuron at the output layer
% an itersx1 vector error_over_time that contains the error on the sample used in each iteration.

function [W1, W2, error_over_time] = backward(X, y, M, iters, eta)

    % Number of rows in training set
    len = size(X,1);

    % Standardize data
    means = mean(X);
    std_devs = std(X);
    for sample = 1:size(len,1)
        X(sample, :) = (X(sample, :) - means) ./ std_devs; 
    end

    % Create the weight matrices and initialize the weights to small random numbers
    D = size(X,2);
    W1 = rand(M,D);
    W2 = rand(1,M);
    
    error_over_time = zeros(iters,1);

    % iterate: 
    %   pick a training sample
    %   compute the error at the output
    %   then backpropagate to the hidden layer
    %   update the weights with the resulting error.
    for i = 1: iters
        ind = randi(len, 1);
        sample = X(ind, :);
        
        % Call activation computation function
        [y_pred, Z] = forward(sample, W1, W2);
        
        % delta = yk (1-yk) (yk-tk)
        yk = y_pred;
        tk = y(ind);
        delta_y = yk * (1 - yk) * (yk - tk);
        
        % Compute error
        error_over_time(i) = abs(y_pred - y(ind));
        
        
        % update W2
        for j = 1:M
            err = delta_y * Z(j);
            W2(j) = W2(j) - (eta * err);
        end
        
        % update W1
        for h = 1:M
           zj = Z(h);
           delta_z = zj * (1-zj) * (W2(1,h)*delta_y);
           curr_w = W1(h,:);
           W1(h,:) = curr_w - (eta * delta_z * sample);
        end
        
    end

end

