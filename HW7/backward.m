
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
        ind = randi(len, q);
        sample = X(ind);
        
        % Call activation computation function
        [y_pred, Z] = forward(sample, W1, W2);
        
        % delta = yk (1-yk) (yk-tk)
        yk = y_pred(ind);
        tk = y(ind);
        delta = yk * (1 - yk) * (yk - tk);
        
        % update W2
        for j = 1:M
            err = delta * Z(ind,j);
            W2(j) = W2(j) - (eta * err);
        end
        
        % update W1
        for h = 1:M
            zj = Z(ind,h);
            w = W1(h);
            delta_col = delta.* ones(M,1);
            summation = w * delta_col;
            delta = zj * (1 - zj) * summation;
            err2 = sample * delta;
            W1(j) = W1(j) - (eta * err2);
        end
        
        error_over_time(i) = err;
    end

end

