% CS1675 - Machine Learning
% Homework 1
% Recitation Friday 1pm
%
% Alessio Mazzone
% ALM388
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear command window
clc


% 1. Generate a 1000000x1 (one million by one) vector of random numbers from 
% a Gaussian (normal) distribution with mean of 0 and standard deviation of 5. 
% Use Matlab's randn function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stdDev = 5;
avg = 0;
randNums = stdDev.*randn(1000000, 1) + avg;

% Verify that mean ~ 0 and standard deviation ~ 5
statistics = [mean(randNums) std(randNums)];



