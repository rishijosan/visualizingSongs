%function to add color tinge to the files
function [ imOut ] = colorTinge( im , color )


imr = im2double(im(:,:,1));
img = im2double(im(:,:,2));
imb = im2double(im(:,:,3));

factor = 1.1;

if color == 'r'
    
imr = factor*(imr);
imr = min(factor*(imr),1);
img = img/factor;
imb = imb/factor;
    
elseif color == 'g'
        
img = factor*(img);
img = min(factor*(img),1);

imr = imr/factor;
imb = imb/factor;
        
    
    elseif color == 'b'
        
imb = factor*(imb);
imb = min(factor*(imb),1);

img = img/factor;
imr = imr/factor;
        
else
    display('Color should be r/g/b');
end



imri = im2uint8(imr);
imgi = im2uint8(img);
imbi = im2uint8(imb);

imOut(:,:,1) = imri;
imOut(:,:,2) = imgi;
imOut(:,:,3) = imbi;



end

