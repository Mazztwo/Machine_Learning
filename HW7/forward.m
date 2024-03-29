

% Inputs:
% NxD matrix X of features, where N is the number of samples and D is the number of feature dimensions,
% MxD matrix W1 of weights between the first and second layer of the network, where M is the number of hidden neurons, and
% 1xM matrix W2 of weights between the second and third layer of the network, where there is a single neuron at the output layer
% 
% Outputs:
% an Nx1 vector y_pred containing the outputs at the last layer for all N samples, 
% an NxM matrix Z containing the activations for all M hidden neurons of all N samples.

function [y_pred, Z] = forward(X, W1, W2)
    
    % Number of neurons
    M = 30;
    
    % Number of rows in training set
    N = size(X,1);
           
    % Standardize data
    means = mean(X);
    std_devs = std(X);
    for sample = 1:N
        X(sample, :) = (X(sample, :) - means) ./ std_devs; 
    end
   
    % Compute activations
    activations = zeros(N,M);
    
    for i = 1:N
        for neuron = 1:M
            curr_sample = X(i,:);
            if (size(curr_sample, 2) == 12)
                curr_sample = curr_sample(:,1:end-1);
            end
            
            activations(i,neuron) = curr_sample * W1(neuron,:)';
        end
    end
    
    % Apply tanh function to each activation
    Z = tanh(activations);
    
    % Compute y_pred
    y_pred = Z * W2';
end

