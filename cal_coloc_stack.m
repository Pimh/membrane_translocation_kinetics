function corr = cal_coloc_stack(stack1_file,stack2_file,stack_mask)
% Calculate colocalization for image stacks

% Add the image folder to the search path
addpath('images')

% Read image stacks 
info_im1 = imfinfo(stack1_file);
nImage1 = length(info_im1);
nrow1 = info_im1(1).Height;
ncol1 = info_im1(1).Width;

info_im2 = imfinfo(stack2_file);
nImage2 = length(info_im2);
nrow2 = info_im2(1).Height;
ncol2 = info_im2(1).Width;

info_mask = imfinfo(stack_mask);
nImage_mask = length(info_mask);
nrow_mask = info_mask(1).Height;
ncol_mask = info_mask(1).Width;

% Check if stack1 and stack2 have the same number of images
%is_nImage_equal = (nImage1==nImage2);
is_nImage_equal = 1;
is_nrow_equal = (nrow1==nrow2) & (nrow1==nrow_mask);
is_ncol_equal = (ncol1==ncol2) & (ncol1==ncol_mask);

if is_nImage_equal & is_nrow_equal & is_ncol_equal
    nImage = nImage1;
    
    for imask = 1:nImage_mask
        im_mask = imread(stack_mask,'Index',imask);
        mask = (im_mask==0);
        
        fprintf('Processing mask %d \n', imask)
        
        for iplane = 1:nImage
            im1 = imread(stack1_file,'Index',iplane);
            
            if nImage2 > 1
                iplane2 = iplane;
            else 
                iplane2 = 1;
            end
            
            im2 = imread(stack2_file,'Index',iplane2);
            
            [PCC(iplane),MOC(iplane),m1(iplane),m2(iplane)] = cal_coloc(im1,im2,mask);
            
            fprintf('\t Processing plane %d... \n',iplane)
        end
        
        corr(imask).PCC = PCC;
        corr(imask).MOC = MOC;
        corr(imask).m1 = m1;
        corr(imask).m2 = m2;
        
        figure(1)
        title('Pearsons correlation coefficient (PCC)')
        xlabel('plane no.')
        ylabel('PCC')
        hold on
        plot(corr(imask).PCC,'-or')
        
        figure(2)
        title('Manders overlap coefficient (MOC)')
        xlabel('plane no.')
        ylabel('MOC')
        hold on
        plot(corr(imask).MOC,'-ob')       
    end
    
    
    
else
    disp('ERROR: unequal dimensions or unequal number of images in stacks')
end