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

% Generate vector 
randNums = stdDev.*randn(1000000, 1) + avg;

% Verify that mean ~ 0 and standard deviation ~ 5
statistics = [mean(randNums) std(randNums)];



% 2. 
% Add 1 to every value in the previous list, by using a loop. To determine 
% how many times to loop, use Matlab's size function. Time this operation and 
% print the number in the code. (Use Matlab's documentation to find out how 
% to time operations.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize array of zeros
randNums_plus_one = zeros(size(randNums));

% Get initial cpu time
initial_time = cputime;

% # size(array, 1) gets number of rows in vector randNums 
for i = 1:size(randNums, 1)
    randNums_plus_one(i) = randNums(i) + 1;
end

% Get total time elapsed
total_time = cputime - initial_time;

% Display results
disp(['Total time with loop: ', num2str(total_time), ' seconds.'])



% 3. 
% Now add 1 to every value in the original random vector, without using a loop. 
% Time this operation, print the time and write it down. Use a different way to 
% print the number than the method you used above. (See ways to print numbers 
% at the beginning of the Matlab tutorial script.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get initial cpu time
initial_time = cputime;

% Add 1 to every value
randNums_plus_one_again = 1.+randNums;

% Get total time elapsed
total_time = cputime - initial_time;

fprintf('Total time without loop: %.2f seconds.\n', total_time)



% 4. 
% Plot the exponential function 2.^x, for non-negative even values of x smaller 
% than 100, without using loops.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate even numbered x values from 0 to 100 excluding 100
x_values = 0:2:99;

% Generate y values by taking 2^x
y_values = 2.^x_values;

% Plot results
plot(x_values,y_values)



% 5.
% [4 pts] Create two matrices A and B which, when added together, result in 
% a 10x10 matrix C containing all numbers from 1 to 100. In other words,   
% when I add A and B and convert the result to vector form, I should get a 
% vector containing all numbers from 1 to 100. In code, C = A + B;
% assert(all(C(:) == (1:100)') == 1); Each matrix should only be created with 
% a single command (no loops).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate a 10x10 matrix containing numbers 0 to 99 
A = reshape(0:99, 10, 10);

% Generate a 10x10 matrix of only ones
B = ones(10, 10);

% Add the two matricies together to generate a 10x10 matrix
% with values 1 to 100
C = A + B;

% Assert that resulting matrix indeed contains 1 to 100
assert(all(C(:) == (1:100)') == 1);



% 6. Generate two random matrices A and B, and compute their product by hand, 
% using loops. The size of the first matrix should be [5, 3] and of the 
% second [3, 5]. Check your code by comparing the loop- computed product with 
% the product that you get from Matlab's A*B. You can use loops.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate two random matricies of integers, one 5x3 and one 3x5
A = randi(100,5,3);
B = randi(100,3,5);

% Initialize a 5x5 array of zeros
C = zeros(5,5);

% Calculate matrix multiplication of A and B via Matlab shortcut
D = A*B;

% Calculate matrix multiplication of A and B longhand using loops
for r = 1:size(A,1)
    for c = 1:size(B,2)
        C(r,c) = (A(r,1)*B(1,c)) + (A(r,2)*B(2,c)) + (A(r,3)*B(3,c));
    end
end

% Assert that both methods yield the same result
assert(isequal(C,D))

    

% 7. Show three ways to compute an inner product between two vectors.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize two vectors
A = [1,2,3];
B = [4,5,6];

% Calculate the inner prooduct between two vectors in three different ways
dotprod1 = A(1)*B(1) + A(2)*B(2) + A(3)*B(3);
dotprod2 = dot(A,B);
dotprod3 = A*B';



% 8.
% Compute and print the L1-norm and L2-norm for each of the following 
% two vectors: x1 = [0.5 0 1.5] and x2 = [1 1 0]. Verify your answer 
% against the Matlab function norm.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate L1-norm and L2-norm longhand and then via the Matlab norm()
% function for x1
x1 = [0.5 0 1.5];
l1_x1 = x1(1) + x1(2) + x1(3);
l2_x1 = sqrt(sum(x1.^2));
l1_x1_easy = norm(x1,1);
l2_x1_easy = norm(x1,2);

% Calculate L1-norm and L2-norm longhand and then via the Matlab norm()
% function for x2
x2 = [1 1 0];
l1_x2 = x2(1) + x2(2) + x2(3);
l2_x2 = sqrt(sum(x2.^2));
l1_x2_easy = norm(x2,1);
l2_x2_easy = norm(x2,2);

% Display results of longhand calculations
disp(['L1-norm for vector x1: ', num2str(l1_x1)])
disp(['L2-norm for vector x1: ', num2str(l2_x1)])
disp(['L1-norm for vector x2: ', num2str(l1_x2)])
disp(['L2-norm for vector x2: ', num2str(l2_x2)])

% Assert that longhand method and Matlab's norm() function yield same
% results
assert(l1_x1 == l1_x1_easy)
assert(l2_x1 == l2_x1_easy);
assert(l1_x2 == l1_x2_easy);
assert(l2_x2 == l2_x2_easy);



% 9. 
% Use Matlab to solve the system of linear equations: 
% 2x + y + 3z = 1; 
% 2x + 6y + 8z = 3; 
% 6x + 8y + 18z = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Put into form AX = B
% A = matrix of scalar coefficients of variables
% B = matrix of what equations are equal to
% X = solutions to variables --> [x;y;z]

A = [2 1 3; 2 6 8; 6 8 18];
B = [1;3;5];
X = A\B; % --> --> X = [x;y;z]


out = normalize_rows([1 2 3 4 4 ; 5 6 4 4 5; 4 4 8 9 8])

