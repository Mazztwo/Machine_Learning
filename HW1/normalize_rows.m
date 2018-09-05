% 10.
% Write a function function [B] = normalize_rows(A) which uses a single command 
% (one line and no loops) to make the sum in each row of the matrix 1. You may 
% need to use repmat, depending on your Matlab version. Note that the sum of the 
% entries in each row should be 1, in the matrix output by your function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [B] = normalize_rows(A)
    
    % Create an output matrix B that is the same size as input matrix A.
    % B is a matrix that has a single column of ones and the rest of the
    % values being zeros.
    B = [zeros(size(A,1),size(A,2)-1) ((A(:,1)*0)+1)]; 
    
end

