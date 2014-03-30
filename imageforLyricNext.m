function [imageSearch,word] = imageforLyricNext(myDbInputPath,myDbFinalPath,word,imhisto)

%imageList = dir(fullfile(imageDir,'*.jpg'));
dirList =  dir (myDbInputPath);
imageSearch=0;
%nameoffile = strcat(word,'.jpg');

    %handling , ? !
    %handling er/ed/ing/s
    k=findstr(word,',');
    if(length(k)~=0)
        word(k)='';
    end
    k=findstr(word,'?');
    if(length(k)~=0)
        word(k)='';
    end
    k=findstr(word,'!');
    if(length(k)~=0)
        word(k)='';
    end
    k=findstr(word,'"');
    if(length(k)~=0)
        word(k)='';
    end
     k=findstr(word,'.');
    if(length(k)~=0)
        word(k)='';
    end
    
    %check from all folders if a folder exists
    for var=1:length(dirList)
        if(strcmpi(dirList(var).name,char(word))==1)
            imageSearch=1;
        end    
    end
    
    if(length(char(word))>2 && (strcmpi(char(word),'the')==0))
                        %CASE 1 : Image found in local database
                        if(imageSearch==1)
                              display('Found image in local db');
                              next = findBestMatch(myDbInputPath,word,imhisto);
                              saveImageToCentralPlace(myDbInputPath,myDbFinalPath,next,word);
                              return;
                        %CASE 2 : Image not found in local database
                        else
                            display('Image not found in local db');
                            [Img,ret] = ImageNetSrch(myDbInputPath,word);
                                    if(ret==0)
                                        display('Image still not found');
                                        imageSearch=0;
                                    elseif(ret==1)
                                        display('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                        display('Image downloaded from imagenet plain text');
                                        display('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                        val = findBestMatch(myDbInputPath,word,imhisto);
                                        saveImageToCentralPlace(myDbInputPath,myDbFinalPath,val,word);
                                        imageSearch=1;
                                        return;
                                    end
                        end
                        
                        if(imageSearch==0)
                            if((strcmp(word(length(word)-1:length(word)),'ed'))==1)
                                word(length(word)-1)='';
                                word(length(word))='';
                                
                            elseif((strcmp(word(length(word)-1:length(word)),'er'))==1)
                                word(length(word)-1)='';
                                word(length(word))='';
                            elseif((strcmp(word(length(word)-2:length(word)),'ing'))==1)
                                word(length(word)-2)='';
                                word(length(word)-1)='';
                                word(length(word))='';
                                
                            elseif(( strcmp(word(length(word):length(word)),'s'))==1)
                                
                                word(length(word))='';
                            end
                            display('Word after stripping');
                            display(word);
                            %TO CHECK AGAIN THIS WORD IF EXISTS IN DB
                            for var=1:length(dirList)
                                 
                                if(strcmpi(dirList(var).name,char(word))==1)
                                    display('Inside 2nd check');
                                    imageSearch=1;
                                end    
                            end
                             
                            %HANDLING IMAGE FOUND AFTER REMOVING
                            if(imageSearch==1)
                              display('Now Found image in local db ;) ');
                              next = findBestMatch(myDbInputPath,word,imhisto);
                              saveImageToCentralPlace(myDbInputPath,myDbFinalPath,next,word);
                              return;
                            end    
                            
                             %STILL IMAGE NOT FOUND , CREATE DATABASE USING
                             %IMAGENET
                             if(imageSearch==0)
                             
                                    display('Image not found in local db');
                                    [Img,ret] = ImageNetSrch(myDbInputPath,word);
                                    if(ret==0)
                                        display('Image still not found');
                                        imageSearch=0;
                                        display(word);
                                    elseif(ret==1)
                                        display('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                        display('Image downloaded from imagenet plain text');
                                        display('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                        val = findBestMatch(myDbInputPath,word,imhisto);
                                        saveImageToCentralPlace(myDbInputPath,myDbFinalPath,val,word);
                                        imageSearch=1;
                                        return;
                                    end
                             
                             end    
                        end 
    else
        display('Too short a word');
    end
end

