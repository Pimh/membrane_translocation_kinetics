function [PCC,MOC,m1,m2]= cal_coloc(im1_file,im2_file,mask)
% Calculate degree of colocalization between im1 and im2
% mask takes logical input (0 or 1), colocalization will be analyzed at the
% region containing value of 1

% Read in the image files
im1 = imread(im1_file);
im2 = imread(im2_file);

im1 = double(im1);
im2 = double(im2);

% Image processing - threshold the images to eliminate background noise
thr_im1 = 450;
thr_im2 = 800;

im1(im1 <= thr_im1) = 0;
im2(im2 <= thr_im2) = 0;

% Calculate Pearsons' correlation coefficeint (PCC)
ROI_im1 = im1.*mask;
ROI_im2 = im2.*mask;

med_im1 = mean(mean(ROI_im1));
med_im2 = mean(mean(ROI_im2));

rel_im1 = ROI_im1 - med_im1;
rel_im2 = ROI_im2 - med_im2;

PCC_num = sum(sum(rel_im1.*rel_im2));
PCC_denom =  sqrt(sum(sum((rel_im1.^2)))*sum(sum((rel_im2.^2))));

if PCC_denom == 0
    PCC = 0;
else
    PCC = PCC_num/PCC_denom;
end

% Calculate Manders overlap coefficient (MOC)
MOC_num = sum(sum(ROI_im1.*ROI_im2));
MOC_denom = sqrt(sum(sum(ROI_im1.^2))*sum(sum(ROI_im2.^2)));

if MOC_denom == 0
    MOC = 0;
else
    MOC = MOC_num/MOC_denom;
end


% Calculate Fractional overlap (m1,m2)
zero_im1 = (ROI_im1==0);
zero_im2 = (ROI_im2==0);

coloc_im1 = ROI_im1;
coloc_im1(zero_im2) = 0;

coloc_im2 = ROI_im2;
coloc_im2(zero_im1) = 0;

m1 = sum(sum(coloc_im1))/sum(sum(ROI_im1));
m2 = sum(sum(coloc_im2))/sum(sum(ROI_im2));






