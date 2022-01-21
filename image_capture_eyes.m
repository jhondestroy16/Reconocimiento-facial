%CameraData=imaqhwinfo('winvideo')
vid = videoinput('winvideo', 2);
set(vid, 'ReturnedColorSpace', 'RGB');

%Muestra video en vivo
preview(vid);

%Confimación para Captura de Imagen
msgfig = msgbox('Tomar Foto','Success','modal');
uiwait(msgfig);

%Captura Imagen
img = getsnapshot(vid);
figure, imshow(img); 
title('Identidad a Validar');
imwrite(img,strcat('Identidad_Validar','.jpg')); 

%Cierra Video una vez se captura la imagen
closepreview(vid);


%% DSP
% Convertir a escala de grises
imwrite(img,strcat('Identidad_Validar','.pgm'));
img_gray=imread(strcat('Identidad_Validar','.pgm'));

% Procesamiento Digital de la Imagen (DSP) - adapthisteq
pout_adapthisteq = adapthisteq(img_gray);
figure, imshow(pout_adapthisteq);
title('Histograma Adaptado');

% Detección - Reconocimiento de Ojos en la Imagen
eyesdetector=vision.CascadeObjectDetector('EyePairBig');
Ojos=step(eyesdetector,pout_adapthisteq);
figure, imshow(pout_adapthisteq);
rectangle('position',Ojos(1,:),'edgecolor','g','linewidth',2);
title('Ojos Detectados');

% Extracción de Rostro de la Imagen Original
OjosX=imcrop(pout_adapthisteq,Ojos);
figure, imshow(OjosX);
title('Ojos Extraidos');

% Ajusta tamaño para FaceDataBase
% Guarda imagen en formatp PGM
resize_OjosX=imresize(OjosX,[112 92]);
imwrite(resize_OjosX,strcat('0','.pgm'));

