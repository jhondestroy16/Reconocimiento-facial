function varargout = menuPrincipal(varargin)
% MENUPRINCIPAL MATLAB code for menuPrincipal.fig
%      MENUPRINCIPAL, by itself, creates a new MENUPRINCIPAL or raises the existing
%      singleton*.
%
%      H = MENUPRINCIPAL returns the handle to a new MENUPRINCIPAL or the handle to
%      the existing singleton*.
%
%      MENUPRINCIPAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MENUPRINCIPAL.M with the given input arguments.
%
%      MENUPRINCIPAL('Property','Value',...) creates a new MENUPRINCIPAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before menuPrincipal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to menuPrincipal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help menuPrincipal

% Last Modified by GUIDE v2.5 14-Nov-2020 10:30:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @menuPrincipal_OpeningFcn, ...
                   'gui_OutputFcn',  @menuPrincipal_OutputFcn, ...
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


% --- Executes just before menuPrincipal is made visible.
function menuPrincipal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to menuPrincipal (see VARARGIN)

% Choose default command line output for menuPrincipal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes menuPrincipal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = menuPrincipal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Ingresar.
function Ingresar_Callback(hObject, eventdata, handles)
% hObject    handle to Ingresar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
Interface2();


% --- Executes on button press in Salir.
function Salir_Callback(hObject, eventdata, handles)
% hObject    handle to Salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();


% --- Executes on button press in CrearUsuario.
function CrearUsuario_Callback(hObject, eventdata, handles)
% hObject    handle to CrearUsuario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------------------------------------------------------
nFolder=dir('FaceDatabaseATT\');
nFolder=size(nFolder);
nFolder=nFolder(1)-2;
nFolder=nFolder+1;
%crea carpeta si no existe
if ~exist(strcat('FaceDatabaseATT\s',num2str(nFolder)),'dir')
    mkdir(strcat('FaceDatabaseATT\s',num2str(nFolder)))
end
close();
CrearUsuarios();

% --- Executes on button press in Instrucciones.
function Instrucciones_Callback(hObject, eventdata, handles)
% hObject    handle to Instrucciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiwait(msgbox({'OPCIONES';' ';'1 - RECONOCIMIENTO ROSTRO'; '-Abre una interfaz donde te tomas la foto y se hace el reconocimiento si estas o no en la base de datos';' ';'2 - CREAR USUARIO'; '-Abre una interfaz donde permite tomar las 10 fotos y crear el respectivo usuario para que lo reconozca en la interfaz RECONOCIMIENTO ROSTRO';' ';} ,'INSTRUCCIONES DE USO !','modal'));
