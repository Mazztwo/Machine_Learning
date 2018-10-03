

function [y_test] = weighted_knn(X_train, y_train, X_test, sigma)
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
        weights = zeros(size(distances));
        
        for i = 1: N
            weights(i) = exp( -1*(distances(i)*distances(i)) / (sigma*sigma) );
        end
        
        weighted_distances = zeros(size(distances));
        % Multiply the distances by the weights
        for i = 1:N
            weighted_distances(i) = weights(i) * distances(i);
        end
        
        
        % Pick the highest weighted item 
        [~, index] = maxk(weighted_distances,1);
        
        % Assing most frequent label as y_test
        y_test(row) = y_train(index); 
    end    

end

