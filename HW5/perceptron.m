
clc
clear

% 1.
% First, represent the data and labels, with samples as the rows and 
% features (coordinates) as the columns. Use all the data for training 
% since we won't test but will only visualize what the method is learning. 
X = [-1 -4 ; -3 -1 ; -3 -2 ; -2 1 ; -1 -1 ; 4 5 ; 1 3 ; 4 0  ; 3 2 ; 5 3];
Y = [1;1;1;1;1;-1;-1;-1;-1;-1];

% Set the learning rate n to 0.1.
n = 0.1;

% Initialize the weight to a vector of random numbers.
w = rand(2,1);


% 2. 
% Compute the predicted label vector Y_pred by multiplying the weights and 
% features, and checking the sign of the result. Use the Matlab function 
% sign. If the predicted label is 0, set it to 1.
Y_pred = zeros(size(X,1),1);

for row = 1:size(X,1)
    Y_pred(row) = sign(X(row,:)*w);
    
    if ( Y_pred(row) == 0 )
        Y_pred(row) = 1;
    end
end

% 3.
% Compute the accuracy of the current prediction for each training sample.
% While the accuracy for some sample is not 1, loop as follows.
cont = true;
row = 1;
ct = 1;
while (cont)
    
    if ( Y_pred(row) ~= Y(row) )
        % 4.
        % Find a sample whose label isn't accurately predicted. If there 
        % are multiple such samples, choose at random. Compute the weight 
        % update for that misclassified sample. 
        right = n*X(row,:);
        
        w = w + right';
        
        % Then predict all labels again using the new weights, and check the accuracy.
        for r = 1:size(X,1)
            Y_pred(r) = sign(X(r,:)*w);

            if ( Y_pred(r) == 0 )
                Y_pred(r) = 1;
            end
        end
        
        row = 1;
        plot_points_w(X,w,Y,Y_pred,ct,row)
        ct = ct + 1;
    else
        if ( row < size(X,1) )
            row = row + 1;
        else
            cont = false;
        end
        
    end
end














