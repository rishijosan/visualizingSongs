%http://www.mathworks.com/matlabcentral/fileexchange/4875-color-image-histogram

function [ imgHist ] = imHist( img )

[~,~,z] = size(img);
if (z ~= 3)
display('Converting image to RGB for histogram computation');
img=reshape([img img img],[size(img) 3]);
end


noBins = 256;

rHist = imhist (img(:,:,1) , noBins);
gHist = imhist (img(:,:,2) , noBins);
bHist = imhist (img(:,:,3) , noBins);

imgHist = zeros(256,3);

imgHist(:,1) = rHist;
imgHist(:,2) = gHist;
imgHist(:,3) = bHist;

end

