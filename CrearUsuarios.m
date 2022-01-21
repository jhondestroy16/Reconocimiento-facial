function varargout = CrearUsuarios(varargin)
% CREATEUSER MATLAB code for CreateUser.fig
%      CREATEUSER, by itself, creates a new CREATEUSER or raises the existing
%      singleton*.
%
%      H = CREATEUSER returns the handle to a new CREATEUSER or the handle to
%      the existing singleton*.
%
%      CREATEUSER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREATEUSER.M with the given input arguments.
%
%      CREATEUSER('Property','Value',...) creates a new CrearUsuarios or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CreateUser_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CreateUser_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CreateUser

% Last Modified by GUIDE v2.5 18-Nov-2020 21:10:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CrearUsuarios_OpeningFcn, ...
                   'gui_OutputFcn',  @CrearUsuarios_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CreateUser is made visible.
function CrearUsuarios_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CreateUser (see VARARGIN)

% Choose default command line output for CreateUser
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CreateUser wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.Tomarfoto,'Visible','off');


% --- Outputs from this function are returned to the command line.
function varargout = CrearUsuarios_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cameraAc.
function cameraAc_Callback(hObject, eventdata, handles)
% hObject    handle to cameraAc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xObjeto
 
set(handles.NewUser1, 'Visible', 'on');
axes(handles.NewUser1);
 
xObjeto = videoinput('winvideo', 2);
xObjeto.ReturnedColorSpace = 'rgb';
 
vidRes = get(xObjeto, 'VideoResolution');
nBands = get(xObjeto, 'NumberOfBands');
 
hImage = image( zeros(vidRes(2), vidRes(1), nBands ));
preview(xObjeto, hImage);
set(handles.cameraAc,'Visible','off');
set(handles.Tomarfoto,'Visible','on');


% --- Executes on button press in Tomarfoto.
function Tomarfoto_Callback(hObject, eventdata, handles)
% hObject    handle to Tomarfoto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xObjeto;
set(handles.NewUser1, 'Visible', 'on');
axes(handles.NewUser1);
 
%verificacion de carpeta
nFolder=dir('FaceDatabaseATT\');
nFolder=size(nFolder);
nFolder=nFolder(1)-2;
nFolder=nFolder-1;

%crea carpeta si no existe
if ~exist(strcat('FaceDatabaseATT\s',num2str(nFolder)),'dir')
    mkdir(strcat('FaceDatabaseATT\s',num2str(nFolder)))
end
 
for i=1:10
    uiwait(msgbox(strcat('Toma foto: ',num2str(i),' debe de aparecer su rostro y sus ojos')));
    
    img = getsnapshot(xObjeto);
    imwrite(img, strcat('Identidad_Validar','.pgm'));
    img_gray=imread(strcat('Identidad_Validar','.pgm'));
    
    %pout_imadjust = imadjust(img_gray);
    %pout_histeq = histeq(img_gray);
    pout_adapthisteq=adapthisteq(img_gray);
    
    imagen_g=rgb2gray(img);
    %img_gray=rgb2gray(img);
    %Detección - Reconocimiento de Rostro en la Imagen
    facedetector=vision.CascadeObjectDetector();%2
    %Detección - Reconocimiento de los ojos en la Imagen
    eyesdetector=vision.CascadeObjectDetector('EyePairBig');%2
    capt=step(facedetector,pout_adapthisteq);%rostro 2
    capt1=step(eyesdetector,pout_adapthisteq);%ojos
    
    while isempty(capt) || isempty(capt1)

    uiwait(msgbox('ERROR, intentemos de nuevo, ',' debe de aparecer su rostro y sus ojos'));
    uiwait(msgbox(strcat('Toma foto: ',num2str(i),' debe de aparecer su rostro y sus ojos')));
    img=getsnapshot(xObjeto);
    %imshow(img);
    imwrite(img,strcat('Identidad_Validar','.pgm'));
    img_gray=imread(strcat('Identidad_Validar','.pgm'));

    %pout_imadjust = imadjust(img_gray);
    %pout_histeq=histeq(img_gray);
    pout_adapthisteq=adapthisteq(img_gray);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    imagen_g=rgb2gray(img);
    %img_gray=rgb2gray(img);
    facedetector=vision.CascadeObjectDetector();%2
    eyesdetector=vision.CascadeObjectDetector('EyePairBig');%2
    capt = step(facedetector,pout_adapthisteq);
    %ojo
    capt1 = step(eyesdetector,pout_adapthisteq);
  
    end
    rectangle('position',capt(1,:),'edgecolor','r','linewidth',1);
    %Ojo
    rectangle('position',capt1(1,:),'edgecolor','g','linewidth',2);
    recortar=imcrop(imagen_g,capt(1,:));
    %recortar=imcrop(img_gray,capt(1,:));
    %ojo
    recortar1=imcrop(imagen_g,capt1(1,:));
    %recortar1=imcrop(img_gray,capt1(1,:));
    area=imresize(recortar,[112 92]);
    %ojo
    area1=imresize(recortar1,[112 92]);
    
    %axes(handles.NewUser1);
    %delete(axes);
    
    %resize_adapthisteq=imresize(pout_adapthisteq,[112 92]);
           
    imwrite(area,strcat('FaceDatabaseATT\s',num2str(nFolder),'\',num2str(i),'.pgm'));
    %imwrite(area1,strcat('FaceDatabaseATT\s',num2str(nFolder),'\',num2str(i),'.pgm'));
    %---------------------------------------------------------------------------------------------
    %imwrite(resize_adapthisteq,strcat('FaceDatabaseATT\s',num2str(nFolder),'\',num2str(i),'.pgm'));
end

uiwait(msgbox('Usuario creado correctamente'));
rmdir(strcat('FaceDatabaseATT\s',num2str(nFolder+1)));

% --- Executes on button press in Salir.
function Salir_Callback(hObject, eventdata, handles)
% hObject    handle to Salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(CrearUsuarios);


% --- Executes on button press in Instrucciones.
function Instrucciones_Callback(hObject, eventdata, handles)
% hObject    handle to Instrucciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiwait(msgbox({'OPCIONES';' ';'1 - ACTIVAR CAMARA'; '-Realiza la activacion de la camara';' ';'2 - TOMAR FOTO'; '-Toma las 10 fotos del usuario para almacenarlas, debe poner el nombre de usuario';' ';} ,'INSTRUCCIONES DE USO !','modal'));



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Atras.
function Atras_Callback(hObject, eventdata, handles)
% hObject    handle to Atras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
Interface2();
