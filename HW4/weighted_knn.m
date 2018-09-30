

function [y_test] = weighted_knn(X_train, y_train, X_test, k, sigma)
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
        
        % weigh all samples
        weights = size(distances);
        
        for i = 1: N
            weights(i) = exp( -1*(distances(i)*distances(i)) / (sigma*sigma) );
        end
        
        
        % Pick the k weights that are the highest
        [~, indicies] = maxk(weights,k);
        
        % Get the label that occurs most in the k - weightiest 
        k_labels = zeros(k, 1);
        for j = 1:k
            k_labels(j) = y_train(indicies(j));
        end
        
        % assing most frequent label as y_test
        y_test(row) = mode(k_labels); 
    end    

end

