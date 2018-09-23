


function [w] = lr_solve_gd(X_train, y_train, iters, eta)
    
    % Add 1's to X_train
    X_train = [ones(size(X_train,1),1)  X_train];

    % 1. First, initialize the weights in some way (use either 
    % random values or all zeros).
    w = zeros(1, size(X_train,2));
       
    % 2. Second, repeat the following iters times. 
    % In each iteration: 
    % 1) compute the loss function gradient using all training data 
    % points. To do this, you need to use lr_predict.m. 
    % 2) adjust the weights in the direction opposite to the gradient.
    % w(t+1) = w(t) + [y-y_hat] * x * eta
    for i = 1 : iters
        for row = 1: size(X_train,1)
            y = y_train(row, 1);
            x = X_train(row,1);
            y_hat = lr_predict(x, w);
            y_diff = y - y_hat;
            loss = y_diff * x * eta;
            
            % 3. Then, adjust the weights in the direction opposite to the gradient.
            % w(t+1) = w(t) + [y-y_hat] * x * eta 
            w = w + loss;
        end 
    end
end

