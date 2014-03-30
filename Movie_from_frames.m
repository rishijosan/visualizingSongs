
function frame = Movie_from_frames(S,cnt,number_of_frames,display_time_of_frame)
%delete oMovie.avi;
cd 'C:\users\neha\db'; 
mov = VideoWriter('oMOVIE.avi');
frame=[];
open(mov);
count=0;
addPath('C:\SB\Sem2');

for i=1:number_of_frames
    display(S(cnt));
    a=imread(S(cnt).imPath{i});
    while count<display_time_of_frame
        count=count+1;
        imshow(a);
		frame = [frame ;getframe];
		%writeVideo(mov,frame);
        %F=getframe(gca);
        %mov=addframe(mov,F);
    end
    count=0;
end

close all
close(mov);
    