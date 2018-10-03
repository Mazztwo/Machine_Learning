%1. 
% Download the data file. The last value in each row contains the target 
% label for that row, and the remaining values are the features. Split the 
% data into 10 approximately equally-sized "folds". Your results reported 
% below should be an average of the results when you train on the first 9 
% folds and test on the remaining 1, then if you train on the folds numbered 
% 1 through 8 and the 10th fold and testing on the 9th fold, etc. For 
% simplicity, you can use folds of size 76 and drop the remaining 8 instances.

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

% 3.
% Apply your KNN function and compute the accuracy over all folds, then average the results. To
% compute accuracy, check the ratio of test samples whose predicted labels are the same as the ground-
% truth labels, out of all test samples.
kays = 1:2:15;
accuracies = [];

for K = 1:2:15
    
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

        % Run k means
        y_test_temp = my_knn(train_x, train_y, test_x, K);
        
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


% 4. 
% Experiment with the following values: K = 1:2:15. Plot the 
% results (with values of K on the x-axis and accuracy on the y-axis) and 
% include the plot in a file report.pdf/docx.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(kays,accuracies);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 5. So far, we have been weighing neighbors equally. Now we want to 
% experiment with weighing them according to their distance to the test sample 
% of interest. Experiment with 3 different values of the bandwidth parameter 
% ?, create a plot with ? on the x-axis and accuracy on the y-axis, and 
% include the plot in the report file.
sigs = 1:20:41;
accuracies = [];


for sig = 1:20:41
    
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

        % Run weighted k means
        y_test_temp = weighted_knn(train_x, train_y, test_x, sig);
        
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(sigs,accuracies);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

