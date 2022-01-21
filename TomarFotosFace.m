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
    f = (msgbox(strcat('Foto ',num2str(i),' debe de aparecer su rostro')));%coinciden
    
    uiwait(f);
    img = getsnapshot(vid);%coinciden
    imwrite(img,strcat('Identidad_Validar','.pgm'));
    img_gray=imread(strcat('Identidad_Validar','.pgm'));
    
    pout_adapthisteq = adapthisteq(img_gray);

    %%Extracción del rostro
    % Detección - Reconocimiento de Rostro en la Imagen
            facedetector=vision.CascadeObjectDetector();
            Rostro=step(facedetector,pout_adapthisteq);

            % Extracción de Rostro de la Imagen Original
                RostroX=imcrop(pout_adapthisteq,Rostro);
                figure, imshow(RostroX);
                title(strcat('Rostro Detectado No. ',num2str(i)));

                %Ajusta tamaño para FaceDataBase
                %Guarda imagen en formatp PGM
                resize_RostroX=imresize(RostroX,[112 92]);
                imwrite(resize_RostroX,strcat(strcat(num2str(i),'.pgm')));
    %%Extracción del rostro
end

%Cierra Video una vez se captura la imagen
closepreview(vid);

cd ..
cd ..