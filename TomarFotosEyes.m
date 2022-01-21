%verificacion de carpeta
nFolder=dir('FaceDatabaseATT\');
nFolder=size(nFolder);
nFolder=nFolder(1)-2;
nFolder=nFolder+1;
%Crear carpeta si no existe
if ~exist(strcat('FaceDatabaseATT\s', num2str(nFolder)),'dir')
    mkdir(strcat('FaceDatabaseATT\s',num2str(nFolder)))   
end

carpeta=nFolder;
cd(strcat('FaceDatabaseATT\s',num2str(carpeta)));

vid = videoinput('winvideo', 2);
set(vid, 'ReturnedColorSpace', 'RGB');

%Panel de video
preview(vid);

for i=1 : 10
    f = msgbox(strcat('Foto ',num2str(i)));
    uiwait(f);
    img = getsnapshot(vid);
    imwrite(img,strcat('Identidad_Validar','.pgm'));
    img_gray=imread(strcat('Identidad_Validar','.pgm'));
    
    pout_adapthisteq = adapthisteq(img_gray);

    %%Extracción de los ojos
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
     %%Extracción de los ojos
end

%Cierra Video una vez se captura la imagen
closepreview(vid);

cd ..
cd ..