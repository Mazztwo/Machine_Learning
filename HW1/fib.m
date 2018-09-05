% 11. 
% Create a function function [val] = fib(n) that returns the n-th 
% number (n >= 1) in the Fibonacci sequence 1, 1, 2, 3, 5, 8, 13...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [val] = fib(n)
    if ( n == 0)
        val =  0;
    elseif (n == 1)
        val = 1;
    else
        val = fib(n-1) + fib(n-2);
    end
end

