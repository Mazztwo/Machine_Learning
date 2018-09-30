clc
clear

X_train = [1 2 3 4; 5 6 7 4; 8 9 10 3; 2 1 3 4; 3 6 4 1];
y_train = [1;1;1;1;1];
X_test = [1 2 2 6; 5 2 7 3; 1 9 3 3];
k = 2;

[y_test] = knn(X_train,y_train,X_test,k);