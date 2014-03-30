function [Img,blah] =   ImageNetSrch(myDbInputPath, word)
homefolder = myDbInputPath;
%homefolder = 'C:\users\neha\builtdb\nouns';        %set homefolder to a path where you want to store the synset 
userName = 'rishijosan';
accessKey = 'bac24bc33cca4f359596f1c1d89120b2d091e770';
isRecursive = 0; 

display('getting inside imagenet search');
imgdb = myDbInputPath;
%imgdb = 'C:\users\neha\builtdb\nouns\';
Img=0;
%Load mapping list
%mapping = tdfread('words.txt');

%Transfer wnid and words to string cells
%wnid = cellstr(mapping.wnid);
%words = cellstr(mapping.word);
%mapTable(:,1) = cellstr(mapping.wnid);
%mapTable(:,2) = cellstr(mapping.word);

display('***************');
display(word);
if(isempty(char(word))==1)
    display('blank word');
    display('ignoring');
    blah=0;
    return;
end
noWords = 82115;
load mapping.mat;
load mapTable.mat;
load wnid_avail.mat

%Find EXACT word in ImageNet db
Index = find(strcmpi(word, mapTable(:,2)));

%No. of matching Synsets
noSynsets = numel(Index);

%Get WordnetIds in one cell
wordid = mapTable(Index(:), 1);

wnid_final = {};

%Check  if images available  on ImageNet
for i=1:noSynsets
isMatch =  strmatch(wordid{i}, wnid_avail);

if(~isempty(isMatch))
wnid_final{end + 1} = wordid{i};
end
end


%Exact match not found, search for closest matches
if (isempty(wnid_final))
    
% %Find Close words in ImageNet db
% IndexCl = strmatch(word, mapTable(:,2));
% 
% %No. of matching Synsets
% noSynsets = numel(IndexCl);
% 
% %Get WordnetIds in one cell
% wordid = mapTable(IndexCl(:), 1);
% 
% wnid_final = {};
% 
% %Check  if images available  on ImageNet
% for i=1:noSynsets
% isMatch =  strmatch(wordid{i}, wnid_avail);
% 
% if(~isempty(isMatch))
% wnid_final{end + 1} = wordid{i};
% end
% end  

display('Exact Match not Found!');
blah = 0
return;


end


url = 'http://www.image-net.org/api/text/imagenet.synset.geturls?wnid=';

noSets = numel(wnid_final);

%Get Image URLs
for i=1:noSets
    
    imgUrl{i} = strcat(url, wnid_final{i});
    s{i} = urlread(imgUrl{i});
    ImageLinks{i} = textscan(s{i}, '%s');
    
end


if (noSets ~= 0)
    
    
    
%Check existence of folder

wordDir = strcat(imgdb,word);
if (exist(wordDir) == 7)
    
    %Directory Exists
else
    mkdir(imgdb,word);    
end


noImg = 5;

%Pick Random Set

for i=1:noImg

finPath = strcat(wordDir , '\' , int2str(i), '.jpg');   
test = 1;
while(test)
  try   
    blah=1;
    a = randi(noSets);
    noElem = numel(ImageLinks{1,a}{1,1});
    b = randi(noElem);

    Img = imread(ImageLinks{1,a}{1,1}{b,1});
    test = 0;
    catch
        display('Could not retreive image from link');
    end
end

imwrite(Img, finPath);

end

else
    blah=0;
    display('No Images for this word');
    display('blah=0');
end

%urlwrite(ImageLinks{1,a}{1,1}{b,1}, finPath); 

end
