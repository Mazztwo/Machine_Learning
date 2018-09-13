


function [] = segment()

% 1. 
% Download the following images: panda, cardinal, and pittsburgh. 
% Load them in Matlab using im = imread(filename);. This will return a HxWx3 
% matrix per image, where H and W denote height and width, and the image has 
% three channels (R, G, B). Convert the image to double format. To avoid a 
% long run of your code, downsample the images (reduce their size) 
% e.g. using im = imresize(im, [100 100]);.


% Read in images
panda_original = imread('panda.jpg');
cardinal_original = imread('cardinal.jpg');
pittsburgh_original = imread('pittsburgh.png');

% Convert images to double format
panda_double = im2double(panda_original);
cardinal_double = im2double(cardinal_original);
pittsburgh_double = im2double(pittsburgh_original);

% Resize images
panda = imresize(panda_double, [100 100]);
cardinal = imresize(cardinal_double, [100 100]);
pittsburgh = imresize(pittsburgh_double, [100 100]);

% 2. 
% To perform segmentation, you need a representation for every image 
% pixel. We will use a three- dimensional feature representation for each 
% pixel, consisting of the R, G and B values of each pixel. 
% Use im = reshape(im, H*W, 3); to convert the 3D matrix into a 2D matrix 
% with pixels as the rows and channels (features) as the columns. Use the 
% random restarts function you wrote above, to perform clustering over the 
% pixels of the image.
panda_2d = reshape(panda, 100*100, 3);
cardinal_2d = reshape(cardinal, 100*100, 3);
pittsburgh_2d = reshape(pittsburgh, 100*100, 3);

% Use the random restarts function you wrote above, to perform clustering 
% over the pixels of the image.
[ids_panda, means_panda, ssd_panda] = restarts(panda_2d, 15, 15, 15);
[ids_cardinal, means_cardinal, ssd_cardinal] = restarts(cardinal_2d, 5, 10, 10);
[ids_pittsburgh, means_pittsburgh, ssd_pittsburgh] = restarts(pittsburgh_2d, 5, 10, 10);


% 3. Then recolor the pixels of each image according to their cluster 
% membership. In particular, replace each pixel with the average R, G, B values 
% for the cluster to which the pixel belongs (i.e. recolor using the cluster 
% means). Show the recolored image using imshow, but convert it to format 
% uint8 before displaying.

for row = 1: 100
    for col = 1: 100
        
        % Panda image
      	for d = 1: size(means_panda,2)
           panda(row,col,d) =  means_panda(ids_panda(((col-1)*100 + row),1),d);
        end
        
        % Cardinal image
        for d = 1: size(means_cardinal,2)
           cardinal(row,col,d) =  means_cardinal(ids_cardinal(((col-1)*100 + row),1),d);
        end
        
        % Pittsburgh image
        for d = 1: size(means_pittsburgh,2)
           pittsburgh(row,col,d) =  means_pittsburgh(ids_pittsburgh(((col-1)*100 + row),1),d);
        end
        
    end
end
    


% Convert image to uint8....as per professor's piazza answer, there is no
% need to convert if image displays fine...
% panda_2d =  uint8(panda_2d);


% UNCOMMENT TO SEE THE DIFFERENT IMAGES....
% Display images
imshow(panda);
% imshow(cardinal);
% imshow(pittsburgh);

end

