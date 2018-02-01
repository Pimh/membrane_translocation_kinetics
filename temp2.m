imshow(im)

N = zeros(368,368);
c = ginput(1)
box_x = [0,20,20,0,0];
box_y = [0,0,10,10,0];
N(min(box_y+c(2)):max(box_y+c(2)) ,min(box_x+c(1)):max(box_x+c(1))) = 0.2;
R = imrotate(N,30);

redChannel = 255 * zeros(368, 368, 'uint8');
greenChannel = 255 * ones(368, 368, 'uint8');
blueChannel = 255 * zeros(368, 368, 'uint8');
green = cat(3, redChannel, greenChannel, blueChannel);

hold on
h = imshow(green);
set(h, 'AlphaData', R)


%figure(2)
%R = imrotate(N,30);
%imshow(R)