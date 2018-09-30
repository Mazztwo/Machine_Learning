% Implement KNN. For each test instance, compute its distance to all training 
% instances, pick the closest K training instances, pick the most common among 
% their labels, and return it as the label for that test instance. Use the 
% Matlab function pdist2.

% Inputs:
%   an NxD feature matrix X_train where N is the number of training instances and D is the feature dimension,
%   an Nx1 label vector y_train for the training instances,
%   an MxD feature matrix X_test where M is the number of test instances,
%   a scalar K.
%
% Outputs:
%   an Mx1 predicted label vector y_test for the test instances.
function [y_test] = my_knn(X_train, y_train, X_test, k)
    N = size(X_train,1);
    M = size(X_test,1);
    y_test = zeros(M, 1);
    
    % for each row in test
    for row = 1:M
        distances = zeros(N, 1);
        
        % Curr test data
        curr_row = X_test(row, :);
        
        % compute distance from current test data to all training instances
        for i = 1:N
            distances(i) = pdist2(curr_row, X_train(i,:));
        end
        
        % Pick the closest K training instances and their indicies in
        % X_train
        [~, indicies] = mink(distances,k);
        
        % Get the label that occurs most in the k closest 
        k_labels = zeros(k, 1);
        for j = 1:k
            k_labels(j) = y_train(indicies(j));
        end
        
        % assing most frequent label as y_test
        y_test(row) = mode(k_labels); 
    end    
end

