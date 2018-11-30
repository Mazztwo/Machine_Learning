
% Inputs:
% X_train, y_train, X_test, and
% a scalar iters defining how many iterations of AdaBoost to run (denoted as M in Bishop).

% Outputs:
% an Mx1 vector y_pred_final, containing the final labels on the test set, using all iters classifiers.


function [y_pred_final] = adaboost(X_train,y_train_,X_test,iters)

    % 1. Initialize all weights to 1/N. 
    N = size(X_train, 1);
    M = size(X_test,1);
    weights = repmat(1/N, N, 1);

    alphas = zeros(iters,1);
    y_preds = zeros(76,iters);
    
    % Then iterate:
    for i = 1:iters
        
        % 2. Find the best decision stump, and evaluate the 
        % quantities alpha and epsilon.
        [correct_train, y_preds(:,i)] = decision_stump_set(X_train, y_train_, weights, X_test);
        
        top = 0;
        
        for j = 1:N

            % When y == ground truth, indicator = 1, 0 otherwise
            if ( correct_train(j) == 0 )
                indicator = 0;
            else
                indicator = 1;
            end
            
            top = top + weights(j)*indicator;
            
        end
        
        epsilon = top / sum(weights);
      
        alpha = log(((1 - epsilon) / epsilon));
        
        % If some classifier produces an alpha value less than 0, set the 
        % latter to 0 (which effectively discards this classifier) and 
        % exit the iteration loop
        if ( alpha >= 0 )
            alphas(i) = alpha;
        else
            alphas(i) = 0;
            continue
        end
       
        
        % 3. Recompute the weights.
        for k = 1:N
            
            % When y != ground truth, indicator = 1, 0 otherwise
            if ( correct_train(k) == 0 )
                indicator = 0;
            else
                indicator = 1;
            end
            
            weights(i) = weights(i) * exp(alphas(i) * indicator);
        end
        
        % Normalize the weights
        mx = max(weights);
        mn= min(weights);
        
        for t = 1:N 
            weights(t) = (weights(t) - mn) / (mx-mn); 
        end

    end
    
    
    % 4. Compute the final labels on the test set, using all 
    % classifiers (one per iteration).
    y_pred_final = zeros(M,1);
    
    
    for q = 1:M
        y_pred_final(q) = sign( sum(y_preds(q,:) * alphas) );
    end
    
    % Convert -1 to 0s
    for z = 1:iters
        if (y_pred_final(z) == -1 || isnan(y_pred_final(z)) )
            y_pred_final(z) = 0;
        end
    end
    
end

