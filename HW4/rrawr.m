clc
clear

X_train = [1 2 3 4; 5 6 7 4; 8 9 10 3; 2 1 3 4; 3 6 4 1];
y_train = [1;1;0;1;0];
X_test = [1 2 2 6; 5 2 7 3; 1 9 3 3];
k = 2;
sigma = 3;

%[y_test] = my_knn(X_train,y_train,X_test,k)
[z_test] = weighted_knn(X_train,y_train,X_test, sigma)

A = [12 36 91; 45 29 48; 33 25 11];
A(1);
A(2);
A(3);
A(4);

B = [1;1;1;1;0;0;0;0;1;0;1;0;0;];

C = unique(B);
