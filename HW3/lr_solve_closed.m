
% Write a function [w] = lr_solve_closed(X_train, y_train) that computes 
% the closed- form least-squares solution to linear regression, using the 
% Moore-Penrose inverse, as derived in class. Use the Matlab function pinv. 
% The body of this function only requires one line of code.
function [w] = lr_solve_closed(X_train,y_train)
    w = pinv( X_train ) * y_train;
end

