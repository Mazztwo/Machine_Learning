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
function [y_test] = knn(X_train,y_train,X_test,k)

    y_test = 0;
end

