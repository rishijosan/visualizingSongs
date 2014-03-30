Visualizing Songs
=========

Course Project for Computational Photography 
(Spring 2013)

Stony Brook University

Authors : Rishi Josan, Neha Bhatnagar

Abstract :
----
This is a Matlab based system which automatically generates a video composed of images 
related to the lyrics of the song provided by the user. Most of these images are extracted from 
ImageNet, restricting the words used to nouns. The video generation is thus fast as we are 
limiting the number of words. The system has two major components:

* Extracting words and searching for images on ImageNet 
* Applying visual effects to the video to change the look and feel, using themes and color manipulation.  To sync the video with the lyrics, timing is taken into consideration and we get a well synchronized video.


Files :
----

* **Main_RunMe** - Main file to run the whole program - includes choosing the code for uploading the lyrics file,choose the themes,choose seed image, make google search code to download album art,  parsing the lyrics file, make a call to search in the ImageNet database , generate the video

* **imageforLyricNext** - file which is basically responsible for searching the word in the local database or make a call to ImageNet code, also contains the code to handle suffix for words ending with ed/er/s/ing

* **ImageGoogle** - code to make a google api call to retrieve album art according to the song's name.

* **ImageNetSrch** - Code to download images from ImageNet using the synsets ( present in the mappings.mat file) 

* **findBestMatch** - code to find the best image out of the images present for a word using color histogram and ssd.

* **imHist** - code to calculate the color histrogram of any image passed to this function

* **leastSSD** - code to calculate the least ssd and return the index of the image with least ssd i.e most closely matching to the seed image

* **saveImageToCentralPlace**- code to save the chosen images to a central location from where the final video will be generated.

* **colorTinge** -code to add a color tinge to the chosen images

* **Movie_from_frames** - code to generate video using the frames created


Executing Program:
----
Make the following changes in Main_RunMe.m
* **myDbInputPath** - refers to the location of the database of images which is local and also ImageNet code dumps the images in this location 
* **myDbFinalPath**  -  refers to the central location where chosen images will be placed and finally the video will be generated with the name oMovie.avi

Place the strings folder included with the source code and add it to Matlab path so that string operations are available
Also place the themes folder included with the source code and place it under myDbInputPath

Theme can be changed by making changes to theme = 'yellow_theme' ; line in Main_RunMe.m file.

On running , the code will ask you to browse and upload the lrc or lyrics file. Some sample lyrics file have been included in this zip.




