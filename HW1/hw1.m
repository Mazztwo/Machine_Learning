% CS1675 - Machine Learning
% Homework 1
% Recitation Friday 1pm
%
% Alessio Mazzone
% ALM388
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear command window
clc


% 1. 
% Generate a 1000000x1 (one million by one) vector of random numbers from 
% a Gaussian (normal) distribution with mean of 0 and standard deviation of 5. 
% Use Matlab's randn function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stdDev = 5;
avg = 0;
randNums = stdDev.*randn(1000000, 1) + avg;

% Verify that mean ~ 0 and standard deviation ~ 5
statistics = [mean(randNums) std(randNums)];



% 2. 
% Add 1 to every value in the previous list, by using a loop. To determine 
% how many times to loop, use Matlab's size function. Time this operation and 
% print the number in the code. (Use Matlab's documentation to find out how 
% to time operations.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get initial cpu time
initial_time = cputime;

% # size(array, 1) gets number of rows in vector randNums 
for i = 1:size(randNums, 1)
    val = randNums(i);
    randNums(i) = val + 1;
end

total_time = cputime - initial_time;
loop_display = ['Total time with loop: ', num2str(total_time), ' seconds.'];
disp(loop_display)


