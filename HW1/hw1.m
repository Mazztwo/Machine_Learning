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

% Initialize new array
randNums_plus_one = zeros(size(randNums));

% Get initial cpu time
initial_time = cputime;

% # size(array, 1) gets number of rows in vector randNums 
for i = 1:size(randNums, 1)
    randNums_plus_one(i) = randNums(i) + 1;
end

% Get total time elapsed
total_time = cputime - initial_time;

disp(['Total time with loop: ', num2str(total_time), ' seconds.'])


% 3. 
% Now add 1 to every value in the original random vector, without using a loop. 
% Time this operation, print the time and write it down. Use a different way to 
% print the number than the method you used above. (See ways to print numbers 
% at the beginning of the Matlab tutorial script.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get initial cpu time
initial_time = cputime;

randNums_plus_one_again = 1.+randNums;

% Get total time elapsed
total_time = cputime - initial_time;

fprintf('Total time without loop: %.2f seconds.\n', total_time)

% 4. 
% Plot the exponential function 2.^x, for non-negative even values of x smaller 
% than 100, without using loops.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_values = 0:2:99;
y_values = 2.^x_values;
plot(x_values,y_values)







