
% Also write a function [y_pred] = lr_predict(X_test, w) that uses 
% the weights computed above, to predict a label for a new test sample.
function [y_pred] = lr_predict(X_test, w)
    y_pred = X_test * w;
end

