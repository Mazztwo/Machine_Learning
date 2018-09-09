
clc
rawr = [1 2 5 
        2 1 6 
        3 5 1];

[ids, means, ssd] = my_kmeans( rawr, 3, 5);

means
ids
