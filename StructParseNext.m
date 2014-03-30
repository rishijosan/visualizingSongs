addPath('C:\Program Files\MATLAB\R2010b\strings\strings');
addPath('C:\Users\neha\Movie');

myDbInputPath='C:\users\neha\builtdb\nouns\';
myDbFinalPath='C:\users\neha\db\';

%addPath('C:\SB\Sem2\');
[FileName,PathName] = uigetfile('*.lrc','Select the lyrics file');
pathLRC = strcat(PathName,FileName);
text = fileread(pathLRC);

%need to add some code to check if the lyrics file provided as the input
%matches a particular format

%%%%%TODO%%%%%%%%
%how to handle numbers in lyrics--- bug
%offset value there how to handle -- bug

expression = '(?<=\[ar:)(.*?)(?=\])';
artistName = regexp(text,expression,'match');
artistName = strtrim(artistName);
display(artistName);

%extract the song name
songNameRegEx = '(?<=\[ti:)(.*?)(?=\])';
songName = regexp(text,songNameRegEx,'match');
songName = strtrim(songName);
display(songName);

%extract the album name
albumNameRegEx = '(?<=\[al:)(.*?)(?=\])';
albumName = regexp(text,albumNameRegEx,'match');
albumName = strtrim(albumName);
display(albumName);

if(length(albumName)~=0)
    %album art copied
    ImageGoogle(char(albumName));
    ImageGoogle(char(artistName));

    %Replicate for artist

    %location C:\Users\neha\Teenage Dream
    aName= strcat(char(albumName),'\1.jpg');
    aFileName=strcat(myDbInputPath,aName);
    seeImg = imread(aFileName);
    ny=strcat(myDbFinalPath,'album.jpg');
    imwrite(seeImg,ny);
    albumArt= imRead(ny);
    imHistAlbumArt = imHist(albumArt);
else
      nox = 1;
      n=strcat(num2str(nox),'.jpg');
      nt=strcat(myDbInputPath,'crazy_theme\');
      ny = strcat(nt,n);
      %ns = strcat('C:\users\neha\db\','black.jpg');
      seeImg= imread(ny);
      ny=strcat(myDbFinalPath,'album.jpg');
      imwrite(seeImg,ny);
      albumArt= imRead(ny);
     imHistAlbumArt = imHist(albumArt);
end



imageArr= [];
imPath=[];
S = struct ('lyricsLine','0','startTime','0','endTime','0','imageArr',imageArr,'imPath',imPath);
cnt = 1; 
sanityText = text;

[~,eof]= size(sanityText);

remain = sanityText ;

%handling [length: ] existing in the lrc file
%[startIndex,endIndex] = regexp(trial,'\[length: \d*:\d*\]'); 
[startIndex,endIndex] = regexp(remain,'\[length: \d*:\d*\]'); 
remain(startIndex:endIndex)='';

 k = 0;
 str = '';
 timings = [];
 
 for c = 1: length(remain) 
    [token, remain] = strtok(remain, '[]');
    if(findstr(token, '0')>0)
        str= strcat(str,token);
        timings = [timings ; token ];
    end    
 end

 %convert the timings into a cell array so can access element by (1)
 timings= cellstr(timings); %timings(1);
 if(strcmp(timings(1),'00:00.00')==0)
    new = ['00:00.00'];
    new = [new ; timings];
    timings = new;
 end
 modifiedTime = timings;
 %manipulate timings REMOVE THE : 
 
for i=1:length(modifiedTime)
    g =cell2mat(modifiedTime(i));
    g(3)='';
    modifiedTime(i)={g};
      
end

for i=1:length(modifiedTime)
     g =cell2mat(modifiedTime(i));
    if(g(2)~=0)
            val = str2num(g(2));
             
            g(2)='';
            
            x = str2num( g);
            t = val * 60 + x;
            plz = num2str(t);
            modifiedTime(i) = {plz};
            t=0;
        end 
end
cnt=1;
 

 %for each of the tokens , find the index and extract the lyrics in between
 for i=1: length(timings)
    if(i<=length(timings)-1)
        index1 = findstr(sanityText,char(timings(i)));
        index2 = findstr(sanityText , char(timings(i+1)));
        display(text(index1+9:index2-3));
        S(cnt).startTime= modifiedTime(i);
        S(cnt).endTime = modifiedTime(i+1);
        S(cnt).lyricsLine = text(index1+9:index2-3);
        cnt=cnt+1;
    else
       %need to handle for the very last lyrics line
       %extract the last 
       index1 = findstr(sanityText,char(timings(i)));
       index2 = eof ;       
       S(cnt).startTime = modifiedTime(i);
       %still need to find a way to find out how to find the length of song
       %S(cnt).endTime =  timings(i) + 
       S(cnt).lyricsLine = text(index1+9:index2);
       cnt=cnt+1;
    end    
 end    

%scan through the lyrics with each structure and then store images
for cnt = 1 : length(timings)
   k=1;
    %split the lyrics into separate words
    strings=strsplit(S(cnt).lyricsLine,' ');

    %for each string search image and if found image then store in the
    %structure
    for i=1  : length(strings)
     
        [random,word] = imageforLyricNext(char(strings(i)),imHistAlbumArt);
        display(word);
        if(random==0)
            display('no image found');
            %ns = strcat('C:\db\','black.jpg');
            %imageFound= imread(ns);
            %imshow(imageFound);
            %S(cnt).imageArr{k}=imageFound;
            %S(cnt).imPath{k}= ns;
            %k=k+1;
        else
            
            display('found image');
            ns = strcat('C:\users\neha\db\',word);
            nss = strcat(ns,'.jpg');
            imageFound= imread(nss);
            imshow(imageFound);
            S(cnt).imageArr{k}=imageFound;
            S(cnt).imPath{k}= nss;
            k=k+1;
        end
    end
      %display(S(i).lyricsLine);
      %theme based changes
      nox = randi([1, 19]);
      n=strcat(num2str(nox),'.jpg');
      nt=strcat(myDbInputPath,'crazy_theme\');
      ns = strcat(nt,n);
      %ns = strcat('C:\users\neha\db\','black.jpg');
      imageFound= imread(ns);
      inputResizeIm = imresize(imageFound,[200 200]);
      imshow(inputResizeIm);
      imwrite(inputResizeIm,ns);
      if(length(S(cnt).imageArr)==0)
        S(cnt).imageArr{1}=inputResizeIm;
        S(cnt).imPath{1}= ns;
      end    
end

diff=[];
%movie generation 
%frame calculation
%op1 = str2num(char(S(45).startTime));
for i=1:length(timings)-1
    op1= str2num(char(S(i).startTime));
    op2= str2num(char(S(i).endTime));
    diff = [diff ; op2-op1];
    %how to calculate the number of frames for that line
    %what to do if no image is found for that line
end

framex=[];
% 
for i =1 : length(timings)-1
ran=(30* diff(i))/length(S(i).imageArr)   ;
framen = Movie_from_frames(S,i,length(S(i).imageArr),ran);
framex = [framex ;framen];
end

%frame1 = Movie_from_frames(S,77,length(S(77).imageArr),100);
%frame2 = Movie_from_frames(S,44,length(S(44).imageArr),80);
%frame3 = [frame1;frame2];
%test

cd 'C:\users\neha\db'; 
mov = VideoWriter('oMOVIE.avi');
open(mov);
writeVideo(mov,framex);
close all
close(mov);
% 
