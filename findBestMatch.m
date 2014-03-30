function [bImage]= findBestMatch(myDbInputPath,word,imHisto)
imageDir = myDbInputPath;
%imageDir = 'C:\users\neha\builtdb\nouns\';
str=strcat(imageDir,word);
Number = dir(fullfile(str,'*.jpg'));
imgHistAllImages = {};
cnt=1;
 for var = 1 : length(Number)
    %calculate histogram of each image
    %store in a cell array
  %display('inside findbestimatch');
    imageName=strcat('\',Number(var).name);
    imageLoc=strcat(str,imageName);
    im = imread(imageLoc);
    imgHistAllImages{cnt} = imHist(im);
    cnt=cnt+1;
 end
 
 %compare with the album art image
 
 index = leastSSD(imgHistAllImages,imHisto);
 bImage=index;
end