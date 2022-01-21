vid = videoinput('winvideo', 2);
set(vid, 'ReturnedColorSpace', 'RGB');

%Panel de video
preview(vid);
f = msgbox('Tomar foto');
uiwait(f);
%Tomar fotos

img = getsnapshot(vid);
%imshow(img)
%figure, imshow(img); 
title('Identidad a Validar');
%write(img,'myfirstimage.jpg'); 
imwrite(img,strcat('Identidad_Validar','.jpg')); 

%% DSP
% Convertir a escala de grises
imwrite(img,strcat('Identidad_Validar','.pgm'));
img_gray=imread(strcat('Identidad_Validar','.pgm'));

pout_imadjust = imadjust(img_gray);
pout_histeq = histeq(img_gray);
pout_adapthisteq = adapthisteq(img_gray);

%figure, imshow(img_gray);
%title('Gray Scale');

%figure, imshow(pout_imadjust);
%title('Imadjust');

%figure, imshow(pout_histeq);
%title('Histeq');

figure, imshow(pout_adapthisteq);
title('Adapthisteq');

resize_adapthisteq=imresize(pout_adapthisteq,[112 92]);
imwrite(resize_adapthisteq,strcat('0','.pgm'));