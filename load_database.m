function out=load_database()
% Cargamos la base de datos la primera vez que ejecutamos el programa.

persistent loaded;
persistent w;
%--------------------------------
%verificación de carpetas
nFolder=dir('FaceDatabaseATT\');
nFolder=size(nFolder);
nFolder=nFolder(1)-2;%(1)-2
nFolder=nFolder-1;
%--------------------------------
if(isempty(loaded))
    %v=zeros(10304,400);
    ri=(nFolder*10)+1;
    v=zeros(10304,ri);
    for i=1:nFolder
       cd(strcat('FaceDatabaseATT\s',num2str(i)));
        %cd(strcat('s',num2str(i)));
        for j=1:10
            a=imread(strcat(num2str(j),'.pgm'));
            v(:,(i-1)*10+j)=reshape(a,size(a,1)*size(a,2),1);
            %-------
            disp(strcat( 'i: ',num2str(i), ' - j: ', num2str(j), '(i-1)*10+j):', num2str((i-1)*10+j) ))
            max_index=(i-1)*10+j;
        end
        cd ..
        cd ..
        
        %% Carga Imagen Foto Capturada
        a=imread('0.pgm');
        v(:,max_index+1)=reshape(a,size(a,1)*size(a,2),1);
        
    end
    w=uint8(v); % Convert to unsigned 8 bit numbers to save memory. 
end
%loaded=1;  % Set 'loaded' to aviod loading the database again. 
out=w;