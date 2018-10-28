

% Inputs:
%   X_train = an NxD feature matrix where N is the number of training instances and D is the feature dimension
%   y_train = an Nx1 label vector for the training instances
%   X_test = an MxD feature matrix where M is the number of test instances
%   C = a scalar, denoting the misclassification cost in an SVM.
%
% Outputs:
%   y_pred = an Mx1 predicted label vector for the test instances.
function [y_pred] = svm_quadprog(X_train, Y_train, X_test, C)
    
    len = size(X_train,1);
    
    H = zeros(len);
    
    % Set up Hassian matrix
    for row = 1:len
       for col = 1:len
           H(row, col) = X_train(row,:)*X_train(col,:)'*Y_train(row)*Y_train(col);
       end
    end
    
    % Set up rest of quadprog arguments
    f = -1 * ones(len,1);
    A = [];
    b = [];
    Aeq = Y_train';
    beq = 0;
    lb = zeros(len,1);
    ub = C*ones(len,1);
    
    alphas = quadprog(H, f, A, b, Aeq, beq, lb, ub);
    
    
    % Calculate weight vector
    w = zeros(1, len);
    
    for i = 1: len
        rawr = (alphas(i) * Y_train(i));
        % Add bias to curr sample
        curr = [X_train(i, :) 1];
        % Get temp weight
        w_temp = rawr * curr;
        w =  w + w_temp;
    end
    
    % Extract bias from weight
    bias = w(1,end);
    w = w(1,1:end-1);
    
    % Use bias and weight to predict y 
    % y_pred = sign (w dot x + b)
    y_pred = zeros(len,1);
    
    for i = 1: size(X_test,1)
        
        temp = dot(w, X_test(i,:)) + bias;
        if (temp < 0)
            y_pred(i) = -1;
        else
            y_pred(i) = 1;
        end
    end
    
end





