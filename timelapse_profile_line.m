function mat_profile = timelapse_profile_line(stack1_file,stack_mask,imask)

% Add the image folder to the search path
addpath('images')

% Read image stacks 
info_im1 = imfinfo(stack1_file);
nImage1 = length(info_im1);
nrow1 = info_im1(1).Height;
ncol1 = info_im1(1).Width;

info_mask = imfinfo(stack_mask);
nImage_mask = length(info_mask);
nrow_mask = info_mask(1).Height;
ncol_mask = info_mask(1).Width;

color_mat = [158,1,66;213,62,79;244,109,67;253,174,97;254,224,139]/255;

im_mask = imread(stack_mask,'Index',imask);
mask = (im_mask==0);

fprintf('Processing mask %d \n', imask)
mat_profile = [];

j=1;
for iplane = 1:nImage1
    im = imread(stack1_file,'Index',iplane);
    im1 = double(im);
    ROI_im1 = im1.*mask;
    line_profile = ROI_im1(ROI_im1>0);
    mat_profile = [mat_profile; line_profile'];

    fprintf('\t Processing plane %d... \n',iplane)

    if iplane == 1||iplane ==4||iplane == 8||iplane == 14||iplane == 20
        figure(1)
        plot(line_profile,'color',color_mat(j,:),'linewidth',2)
        hold on
        %axis([1550 1750 0 5.5])
        j=j+1;
    end
end

   

