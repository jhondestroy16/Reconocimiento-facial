vid = videoinput('winvideo', 2);
set(vid, 'ReturnedColorSpace', 'RGB');
%Panel de video
preview(vid);

  %verificacion de carpetas
        nFolder=dir('FaceDatabaseATT\');
        nFolder=size(nFolder);
        nFolder=nFolder(1)-2;
        nFolder=nFolder+1;
       
%crea los folder si no exixte
        if ~exist(strcat('FaceDatabaseATT\s',num2str(nFolder)), 'dir')
            mkdir(strcat('FaceDatabaseATT\s',num2str(nFolder)))
        end

for i=1:10
    uiwait(msgbox(strcat('Tomar Foto: ',num2str(i),' Success',' modal')));
    
     img = getsnapshot(vid);
     imwrite(img,strcat('Captura','.pgm'));
     img_gray=imread(strcat('Captura','.pgm'));
     
     pout_imadjust = imadjust(img_gray);
     pout_histeq = histeq(img_gray);
     pout_adapthisteq = adapthisteq(img_gray);
     
     resize_adapthisteq=imresize(pout_adapthisteq,[112 92]);
   
         
%       imwrite(resize_adapthisteq,strcat(num2str(i),'.pgm'));
        imwrite(resize_adapthisteq,strcat('FaceDatabaseATT\s',num2str(nFolder),'\',num2str(i),'.pgm'));      
end
closepreview;