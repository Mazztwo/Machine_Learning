clc, clear

% Read in file
raw_data = csvread('pima.data');
cols = size(raw_data,2)-1;

% Discard last 8 rows
x_data = raw_data(1:760,1:cols);
y_data = raw_data(1:760,end);

% 2.
% Normalize data
means = mean(x_data);
std_devs = std(x_data);
standardized_x_data = zeros(size(x_data));

for i = 1:size(x_data,1)
    standardized_x_data(i, :) =  (x_data(i, :) - means) ./ std_devs;
end

% Split the data into 10 folds
folds = zeros(76,cols,10);
folds_y = zeros(76,1,10);
st = 1;
en = 76;

for fold = 1:10
    folds(:,:,fold) = standardized_x_data(st:en,:);
    folds_y(:,:,fold) = y_data(st:en,1);
    st = st + 76;
    en = en + 76;
end

accuracies = [];

for iters = [10, 20, 50]
    
   curr_accuracies = zeros(10,1);
    
   for i = 1:10
        % Create testing data
        test_x = folds(:,:, i);

        % Create training data
        train_x = [];
        train_y = [];
        for j = 1:10
            if(i == j)
                curr_test_fold = j;
                continue;
            else
                curr_fold = folds(:,:,j);
                curr_y = folds_y(:,:,j);
                train_x = [train_x; curr_fold];
                train_y = [train_y; curr_y];
            end
        end

        % Run adaboost
        y_test_temp = adaboost(train_x,train_y,test_x,iters);
        
        % Calculate accuracy for current fold test/training data
        curr_correct = 0;
        for m = 1:76
            if ( folds_y(m,1,curr_test_fold) == y_test_temp(m) )
                curr_correct = curr_correct + 1;
            end
        end
        
        curr_accuracy = curr_correct / 76;
        curr_accuracies(i) = curr_accuracy;
        
    end
    
    % Average accuracies for current value of K
    mean_accuracy = mean(curr_accuracies);
    accuracies = [accuracies; mean_accuracy];
    
end

% Display accuracies
it = [10,20,50];
for a = 1:3
    fprintf("Accuracy for %i iterations: ", it(a))
    disp(accuracies(a));
end





