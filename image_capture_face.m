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

% Detección - Reconocimiento de Rostro en la Imagen
facedetector=vision.CascadeObjectDetector();
Rostro=step(facedetector,pout_adapthisteq);
figure, imshow(pout_adapthisteq);
rectangle('position',Rostro(1,:),'edgecolor','g','linewidth',2);
title('Rostro Detectado');

% Extracción de Rostro de la Imagen Original
RostroX=imcrop(pout_adapthisteq,Rostro);
figure, imshow(RostroX);
title('Rostro Extraido');

% Ajusta tamaño para FaceDataBase
% Guarda imagen en formatp PGM
resize_RostroX=imresize(RostroX,[112 92]);
imwrite(resize_RostroX,strcat('0','.pgm'));

