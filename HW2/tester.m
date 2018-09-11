
clc
rawr = [1 2 5 
        2 1 6 
        3 1 1
        1 8 2
        5 4 2
        1 4 4
        1 4 4
        9 2 3];

[ids, means, ssd] = restarts( rawr, 3, 3, 3);

means;
ids;
ssd;

segment()
