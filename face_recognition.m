%% Reconocimiento facial
% Este algoritmo utiliza el sistema de cara propia (basado en el componente pricipal
% de análisis - PCA) para reconocer caras. Para obtener más información sobre este método
% se refiere a http://cnx.org/content/m12531/latest/

%% Descarga la base de datos de rostros
% Puede encontrar la base de datos en el siguiente enlace,
% http://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html
% La base de datos contiene 400 imágenes de 40 sujetos. Descarga el zip
% database y descomprímalo en el mismo directorio que este archivo.

%% Loading the database into matrix v
w=load_database();

%% Initializations
% We randomly pick an image from our database and use the rest of the
% images for training. Training is done on 399 pictues. We later
% use the randomly selectted picture to test the algorithm.
%------------------------------------------------------------------------
%verificacion de carpetas
nFolder=dir('FaceDatabaseATT\');
nFolder=size(nFolder);
nFolder=nFolder(1)-2;
nFolder=nFolder-1;
%var = (nFolder*10)+1;

ri=(nFolder*10)+1;
%ri=round(var*rand(1,1));           % Elija un índice al azar.
r=w(:,ri);                          % r contiene la imagen que usaremos más adelante para probar el algoritmo
v=w(:,[1:ri-1 ri+1:end]);           % v contiene el resto de las 399 imágenes. 

N=20;                               % Number of signatures used for each image.
%% Subtracting the mean from v
O=uint8(ones(1,size(v,2))); 
m=uint8(mean(v,2));                 % m es la media de todas las imágenes.
vzm=v-uint8(single(m)*single(O));   % vzm es v con la media eliminada. 

%% Cálculo de autovectores de la matriz de correlación
% Elegimos N de las 400 caras propias.
L=single(vzm)'*single(vzm);
[V,D]=eig(L);
V=single(vzm)*V;
V=V(:,end:-1:end-(N-1));            % Elija los vectores propios correspondientes a los diez valores propios más grandes.


%% Calcular la firma de cada imagen
cv=zeros(size(v,2),N);
for i=1:size(v,2)
    cv(i,:)=single(vzm(:,i))'*V;    % Cada fila de la variable cv es la firma de una imagen.
end


%% Recognition 
%  Ahora, ejecutamos el algoritmo y vemos si podemos reconocer correctamente la cara. 
subplot(121); 
imshow(reshape(r,112,92));title('Identidad a verificar','FontWeight','bold','Fontsize',18,'color','blue');

subplot(122);
p=r-m;                              % Subtract the mean
s=single(p)'*V;
z=[];
for i=1:size(v,2)
    z=[z,norm(cv(i,:)-s,2)];
    if(rem(i,20)==0),imshow(reshape(v(:,i),112,92)),end;
    drawnow;
end

[a,i]=min(z);
subplot(122);

if(a<=6000000)
    imshow(reshape(v(:,i),112,92));title(nFolder,'FontWeight','bold','Fontsize',18,'color','blue');
else
    no_user=imread('NoUser.pgm');
    imshow(reshape(no_user,112,92));title('Usuario Desconocido','FontWeight','bold','Fontsize',18,'color','red');
end

disp(a);