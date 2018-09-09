
clc
rawr = [1 2 5 
        2 1 6 
        3 5 1
        1 5 2
        5 4 2
        1 2 4
        1 4 4
        9 5 3];

[ids, means, ssd] = my_kmeans( rawr, 3, 3);

means
ids
ssd
