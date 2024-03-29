

% Inputs:
% an NxD matrix X_train (N training samples, D features),
% an Nx1 vector y_train of ground-truth labels for the training set,
% an Nx1 vector w_train containing the weights for the N training samples, 
% an MxD matrix X_test (M test samples, D features).
% 
% Outputs:
% an Nx1 binary vector correct_train containing 1 for training samples 
%   that are correctly classified by the best decision stump, and 0 for 
%   incorrectly classified training samples, and
% an Mx1 vector y_pred containing the label predictions on the test set.

function [correct_train, y_pred] = decision_stump_set(X_train, y_train, w_train, X_test)

    % Choose 1 feature
    % Decide threshold
    % Assigns opposite predictions if the feature is >= or < the threshold.
    
    
    % For each decision stump, use the training labels to determine the 
    % accuracy on each sample of the training data.
    % Weight that accuracy vector by the N x 1 vector of weights, and sum.
    % Use the best-performing classifier to generate predictions for the test dataset.


    % 1) Each decision stump operates on a single feature dimension and uses 
    % a threshold over that feature dimension to make positive/negative predictions. 
    % This function should iterate over all feature dimensions, and consider 10 
    % approximately equally spaced thresholds for each feature.
    
    % Number of training samples
    N = size(X_train,1);
    
    % Num feature dimensions
    D = size(X_train,2);
    
    % Initialize correct_train to 0's
    correct_train = zeros(N,1);
    
    % Current best stump
    best_stump = 0;
    % Go through this for each feature dimension
    for dim = 1:D
        
        curr_dim = X_train(:, dim);
        
        mx = max(curr_dim);
        mn = min(curr_dim);
        
        % Create threshold increment for curr feature
        threshold_increment = (mx - mn) / 10;
        
        % Create all stumps for this current feature and 
        % check against best stump.
        
        % 20 stumps created for each dimension
        %   10 thresholds * 2 labels
        threshold = threshold_increment;
        
        for stump_row = 1:10
            
            for label =  1:2
            
                if (label == 1)
                    curr_label = 1;
                else
                    curr_label = -1;
                end
                
                % Classify each sample based on threshold
                classification = zeros(N,1);
                for i = 1:N
                    if ( curr_dim(i) >= threshold )
                        classification(i) = curr_label;
                    else
                        classification(i) = -1*curr_label;
                    end
                end
                
               % Calculate weighted accuracy for current stump
               % weighted acc = # correct / N
               % Don't forget to count 0's as -1's
               num_correct = 0;
               for i = 1:N
                   if (y_train(i) == 0)
                       if (classification(i) == -1)
                           num_correct = num_correct + 1;
                           correct_train(i) = 1;
                       else
                           correct_train(i) = 0;
                       end
                   else    
                       if (classification(i) == 1)
                           num_correct = num_correct + 1;
                           correct_train(i) = 1;
                       else
                           correct_train(i) = 0;
                       end
                   end
               end
               
               % Sum (weights * which were correct)
               curr_weighted_acc = w_train' * correct_train;
               
               % If the current accuracy is greater than the best we've
               % seen so far, then update the best stump to this one
               
               if ( best_stump == 0)
                   best_stump = [dim, threshold, curr_label, curr_weighted_acc];
               elseif ( curr_weighted_acc > best_stump(4) )
                   best_stump = [dim, threshold, curr_label, curr_weighted_acc];
               end
           
               
                
            end
            
            % Update Threshold
            threshold = threshold + threshold_increment;
        end
        
    end
    
    % If here, we have our best stump & correct_train. Proceed to make 
    % predictions on X_test.
    
    % Number of test samples
    M = size(X_test,1);
    
    % Initialize y_pred
    y_pred = zeros(M,1);
    
    % Make predictions
    for i = 1:M
        dimension = best_stump(1);
        threshold = best_stump(2);
        label = best_stump(3);
             
        if ( X_test(i,dimension) >= threshold)
            if ( label == 1 ) 
                y_pred(i) = 1;
            else
                y_pred(i) = 0;
            end
        else
            if ( label == 1 ) 
                y_pred(i) = 0;
            else
                y_pred(i) = 1;
            end
        end
    end
    
end

