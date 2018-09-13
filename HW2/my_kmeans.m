
% Inputs: 
%   A = an NxD data matrix where N is the number of samples 
%       and D is the dimensionality of your feature representation
%
%   K = number of clusters to output
%
%   iters = number of iterations to run for K-means
%
% Outputs:
%   ids = an Nx1 output containing the data membership IDs of each sample 
%         (denoted by indices randing from 1 to K, where K is the number 
%         of clusters)
%
%   means = a KxD matrix containing the mean/center for each cluster
%
%   ssd = a scalar measuring the final SSD error of the clustering, 
%         i.e. the sum of the squared distances between points and their 
%         assigned means, summed over all clusters.
function [ids, means, ssd] = my_kmeans(A, K, iters)


    % 1. 
    % First, initialize the cluster means randomly. 
    % Get the range of the feature space, separately for each 
    % feature dimension (compute max and min and take the difference) 
    % and use this to request random numbers in that range. Check 
    % the documentation for rand.

    % Determine max and min for every dimension
    % ranges = dimensions x 2 (max,min) matrix
    ranges = zeros(size(A,2), 2);
    
    D = size(A,2);
    
    % Calculate range for each dimension
    for dimension = 1: D
        % Calculate min
        ranges(dimension,1) = min(A(:,dimension));
        
        % Calculate max
        ranges(dimension,2) = max(A(:,dimension));
    end
    
    % Initialize random cluster means
    means = zeros(K, D);
    
    for k = 1: K
        for d = 1: D
            means(k, d) = (ranges(d,2)-ranges(d,1)).*rand(1,1) + ranges(d,1);
        end
    end
    
    for q = 1: iters
        
        % 2. 
        % Then, iterate over the following two steps. The first 
        % step is to compute the memberships for each data sample. Use Matlab's 
        % function pdist2 to efficiently compute distances (check its 
        % documentation to see what inputs it expects). Then for each sample, 
        % find the min distance and the cluster that gives this min distance.

        % Now that I have the cluster centers, I have to figure out
        % which cluster center each data point is closest to. 
        % Calculate the distance each point is from each cluster center
        % [ point1fromcluster1 point1fromcluster2 point1fromcluster3 ...]
        distances = pdist2(A, means);

        % initialize ids
        ids = zeros(size(A,1),1);

        for r = 1:size(distances, 1) 
            [~, ids(r)] = min(distances(r, :));
        end

        % 3.
        % The second step is to recompute the cluster means, simply 
        % taking the average across samples assigned to that cluster, for each 
        % feature dimension.

        % Now each point belongs to one of the clusters. I must now take each
        % cluster and recompute its center by taking the mean of each
        % dimension.

        % Total number of points belonging to a cluster
        totalPoints = zeros(K, 1);

        % Holds the temporary sums of each dimension for a cluster
        sums = zeros(1, D);

        for k = 1 : K
            for id = 1 : size(ids)
                if (ids(id) == k)

                    % Get point from A --> A(id, :)
                    point = A(id, :);
                    totalPoints(k, 1) = totalPoints(k, 1) + 1;

                    % Add each  dimension to a sum
                    for d = 1 : D
                        sums(1,d) = sums(1,d) + point(1,  d);
                    end

                    % At end, divide each sum by total data in that cluster and
                    % update the cluster center array (means).
                    if(totalPoints(k,1) ~= 0)
                        for d = 1 : D
                            means(k,d) = sums(1,d) / totalPoints(k,1);
                        end
                    end

                end
            end  
            % Reset sums
            sums = zeros(1, D);
        end 
    end
    
   % 4. Finally, compute the overall SSD error. It helps to keep track of 
   % the min distance per sample as you iterate. 
    ssd = 0; 
    squaredDiff = 0;
    for k = 1 : K
            for id = 1 : size(ids)
                if (ids(id) == k)
                    % Get point from A --> A(id, :)
                    point = A(id, :);
                    
                    % Subtract point from center
                    tempDiff = point - means(k,:);
                    
                    % Take magnitude of the difference
                    magnitude = norm(tempDiff, 2);
                    
                    % Square the magnitude
                    magnitude = magnitude * magnitude;
                    
                    % Add this to counter
                    squaredDiff = squaredDiff + magnitude;
                end
            end
        % Add the sum of cluster to ssd
        ssd = ssd + squaredDiff;
        
        % Reset the squared difference
        squaredDiff = 0;
    end
  
end

