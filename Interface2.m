function varargout = Interface2(varargin)
% INTERFACE2 MATLAB code for Interface2.fig
%      INTERFACE2, by itself, creates a new INTERFACE2 or raises the existing
%      singleton*.
%
%      H = INTERFACE2 returns the handle to a new INTERFACE2 or the handle to
%      the existing singleton*.
%   
%      INTERFACE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE2.M with the given input arguments.
%
%      INTERFACE2('Property','Value',...) creates a new INTERFACE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface2

% Last Modified by GUIDE v2.5 19-Nov-2020 22:32:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface2_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface2_OutputFcn, ...
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


% --- Executes just before Interface2 is made visible.
function Interface2_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface2 (see VARARGIN)

% Choose default command line output for Interface2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interface2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.proceso,'Visible','off');
set(handles.tomarfoto,'Visible','off');
set(handles.cerrarcamara,'Visible','Off');
set(handles.atras,'Visible','Off');


% --- Outputs from this function are returned to the command line.
function varargout = Interface2_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in abrir camara.
function activarcamara_Callback(~, ~, handles)
% hObject    handle to activarcamara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xObjeto
 
set(handles.Image, 'Visible', 'on');
axes(handles.Image);
 
xObjeto = videoinput('winvideo', 2);
xObjeto.ReturnedColorSpace = 'rgb';
 
vidRes = get(xObjeto, 'VideoResolution');
nBands = get(xObjeto, 'NumberOfBands');

hImage = image( zeros(vidRes(2), vidRes(1), nBands ));
preview(xObjeto, hImage);

set(handles.activarcamara,'Visible','Off');
set(handles.tomarfoto,'Visible','On');
set(handles.cerrarcamara,'Visible','On');
set(handles.proceso,'Visible','off');
set(handles.nuevousuario,'Visible','on');
set(handles.salir,'Visible','On');
set(handles.atras,'Visible','Off');



% --- Executes on button press in cerrarcamara.
function cerrarcamara_Callback(~, ~, handles)
% hObject    handle to cerrarcamara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Image, 'visible', 'off');
closepreview;
fondo=imread('ut.jpg');
noImg = imread('ut.jpg');
axes(handles.Image);
imshow(noImg);
set(handles.activarcamara,'Visible','On');
set(handles.tomarfoto,'Visible','Off');
set(handles.cerrarcamara,'Visible','off');
set(handles.proceso,'Visible','Off');
set(handles.nuevousuario,'Visible','on');
set(handles.salir,'Visible','On');
set(handles.atras,'Visible','Off');



% --- Executes on button press in tomarfoto.
function tomarfoto_Callback(~, ~, handles)
% hObject    handle to tomarfoto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xObjeto
 
set(xObjeto, 'ReturnedColorSpace', 'RGB');
img = getsnapshot(xObjeto);
imagen_g=rgb2gray(img);

facedetector=vision.CascadeObjectDetector();
%OJOS
eyesdetector=vision.CascadeObjectDetector('EyePairBig');
Rostro=step(facedetector,img);
Ojos=step(eyesdetector,img);

if isempty(Rostro) || isempty(Ojos)
    imgno = imread('FotoNoDisponible.jpg');
    axes(handles.View);
    imshow(imgno);
    errordlg('Rostro no detectado, Intentelo de nuevo','Error en obtener foto');
    set(handles.proceso,'Visible','off');
    
    return
else
recortar=imcrop(img,Rostro(1,:));
%OJOS
recortar1=imcrop(img,Rostro(1,:));
area=imresize(recortar,[112 92]);
%OJOS
area1=imresize(recortar1,[112 92]);
axes(handles.View);  
imshow(img)
imwrite(area,'Identidad_Validar.jpg','jpg');
imwrite(area,strcat('0','.pgm'));
    rectangle('position', Rostro(1,:),'edgecolor','b','linewidth',1);
%---------------------------------------------------------------------------
%OJOS
imwrite(area1,'Identidad_Validar.jpg','jpg');
imwrite(area1,strcat('0','.pgm'));
    rectangle('position', Ojos(1,:),'edgecolor','red','linewidth',2);
    
set(handles.activarcamara,'Visible','Off');
set(handles.tomarfoto,'Visible','On');
set(handles.cerrarcamara,'Visible','Off');
set(handles.proceso,'Visible','On');
set(handles.nuevousuario,'Visible','on');
set(handles.salir,'Visible','Off');
set(handles.atras,'Visible','On');
end

% --- Executes on button press in proceso.
function proceso_Callback(~, ~, handles)
% hObject    handle to nuevousuario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.activarcamara,'Visible','Off');
set(handles.tomarfoto,'Visible','Off');
set(handles.cerrarcamara,'Visible','Off');
set(handles.proceso,'Visible','Off');
set(handles.nuevousuario,'Visible','off');
set(handles.salir,'Visible','on');
face_recognition();


% --- Executes on button press in nuevousuario.
function nuevousuario_Callback(~, ~, ~)
% hObject    handle to nuevousuario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nFolder=dir('FaceDatabaseATT\');
nFolder=size(nFolder);
nFolder=nFolder(1)-2;
nFolder=nFolder+1;
%crea carpeta si no existe
if ~exist(strcat('FaceDatabaseATT\s',num2str(nFolder)),'dir')
    mkdir(strcat('FaceDatabaseATT\s',num2str(nFolder)))

end
close(Interface2);
CrearUsuarios();


% --- Executes on button press in salir.
function salir_Callback(~, ~, ~)
% hObject    handle to salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();


% --- Executes on button press in atras.
function atras_Callback(~, ~, ~)
% hObject    handle to atras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
Interface2();

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.tomarfoto,'Visible','Off');
set(handles.cerrarcamara,'Visible','Off');
set(handles.salir,'Visible','Off');
set(handles.proceso,'Visible','Off');
set(handles.nuevousuario,'Visible','Off');
delete(hObject);


% --- Executes on button press in Instrucciones.
function Instrucciones_Callback(hObject, eventdata, handles)
% hObject    handle to Instrucciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiwait(msgbox({'OPCIONES';' ';'1 - ACTIVAR CAMARA'; '-Realiza la activacion de la camara';' ';'2 - TOMAR FOTO'; '-Toma la imagen del usuario';' ';'3 - CERRAR CAMARA'; '-Se cierra el cuadro de la foto';' ';'4 - PROCESAR IMAGEN'; '-Realiza el proceso de reconocimiento y comparacion en la base de datos';' ';'5 - NUEVO USUARIO'; '-Se crea un registro de imagenes de usuario, en la base de datos';' ';} ,'INSTRUCCIONES DE USO !','modal'));


% --- Executes on button press in inicio.
function inicio_Callback(hObject, eventdata, handles)
% hObject    handle to inicio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
menuPrincipal();
