cd('s41');
for i=1:10
    a=imread(strcat(num2str(i),'.jpg'));
    %b=imresize(a,[92 112]);
    b=imresize(a,[112 92]);
    imwrite(b,strcat(num2str(i),'.pgm'));    
end

cd ..