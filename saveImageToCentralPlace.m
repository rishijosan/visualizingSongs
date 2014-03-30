function [ret] = saveImageToCentralPlace(myDbInputPath,myDbFinalPath, index ,word)


  
imageLoc = strcat(myDbInputPath,word);
imageListing = dir(fullfile(imageLoc,'*.jpg'));
fileName = imageListing(index).name;
 nameFile=strcat('\',fileName);
 imageLoc = strcat(imageLoc,nameFile);

                inputImg = imread(imageLoc);
                inputImg = im2double(inputImg);
                inputResize = imresize(inputImg,[200 200]);
                str = strcat (myDbFinalPath  ,word );
                str = strcat(str,'.jpg');
                display(str);
                str= cellstr(str);
                imwrite(inputResize,str{1},'jpg');
                ret=1;
end