
% K-means is sensitive to the random choice of initial clusters. To improve 
% your odds of getting a good clustering, implement a wrapper function 
% restarts.m to do R random restarts and return the clustering with the 
% lowest SSD error.
%
% All inputs are the same as my_kmeans, except R.
%
% Inputs:
%   R = a scalar denoting how many random restarts to perform.
%
% Outputs:
%   Outputs are the same, execpt that the SSD is the lowest for the R
%   random restarts.
function [ids, means, ssd] = restarts(A, K, iters, R)
    
    % Run function once to get the first ssd
    [ids_least, means_least, ssd_least] = my_kmeans(A, K, iters);

    for restart = 1 : (R-1)
        [ids_temp, means_temp, ssd_temp] = my_kmeans(A, K, iters);
        
        % If the ssd from any subsequent run is less than the first call of
        % the function, then we update the data.
        if (ssd_temp < ssd_least)
            ids_least = ids_temp;
            means_least = means_temp;
            ssd_least = ssd_temp;
        end
    end
    
    % Output data that corresponds with minimized SSD
    ids = ids_least;
    means = means_least;
    ssd = ssd_least;
end

