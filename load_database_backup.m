function out=load_database()
% Cargamos la base de datos la primera vez que ejecutamos el programa.

persistent loaded;
persistent w;
if(isempty(loaded))
    v=zeros(10304,400);
    for i=1:40
       cd(strcat('FaceDatabaseATT\s',num2str(i)));
        %cd(strcat('s',num2str(i)));
        for j=1:10
            a=imread(strcat(num2str(j),'.pgm'));
            v(:,(i-1)*10+j)=reshape(a,size(a,1)*size(a,2),1);
        end
        cd ..
        cd ..
    end
    w=uint8(v); % Convierta a números de 8 bits sin signo para ahorrar memoria.
end
loaded=1;  % Obtenga 'cargado' para evitar cargar la base de datos nuevamente.
out=w;