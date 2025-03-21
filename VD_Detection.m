function varargout = VD_Detection(varargin)
% VD_DETECTION MATLAB code for VD_Detection.fig
%      VD_DETECTION, by itself, creates a new VD_DETECTION or raises the existing
%      singleton*.
%
%      H = VD_DETECTION returns the handle to a new VD_DETECTION or the handle to
%      the existing singleton*.
%
%      VD_DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VD_DETECTION.M with the given input arguments.
%
%      VD_DETECTION('Property','Value',...) creates a new VD_DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VD_Detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VD_Detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VD_Detection

 
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VD_Detection_OpeningFcn, ...
                   'gui_OutputFcn',  @VD_Detection_OutputFcn, ...
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


% --- Executes just before VD_Detection is made visible.
function VD_Detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VD_Detection (see VARARGIN)

% Choose default command line output for VD_Detection
handles.output = hObject;
axes(handles.axes1); axis off
axes(handles.axes2); axis off
set(handles.edit1,'String','**');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VD_Detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VD_Detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count=1;
locate_points=65;
% w = webcam(2);
url = 'http://192.168.72.178:8080/shot.jpg';
I  = imread(url);
img = imresize(I,[300,400]);
for c = 1:count
%     img = w.snapshot;
    axes(handles.axes1); imshow(img) % display the image
    title('Input Info','fontsize',12,'fontname','Times New Roman','color','Black')
    f1=il_rgb2gray(double(img));
  [ysize,xsize]=size(f1);
  nptsmax=locate_points;   
  kparam=0.04;  
  pointtype=1;  
  sxl2=4;       
  sxi2=2*sxl2;  
  [posinit,valinit]=STIP(f1,kparam,sxl2,sxi2,pointtype,nptsmax);
  Test_Feat(c,1:locate_points)=valinit;
   axes(handles.axes2); imshow(f1,[]), hold on
 axis off;
 showellipticfeatures(posinit,[1 1 0]);
 title('Segmented Info with Points','fontsize',12,'fontname','Times New Roman','color','Black')
 posinit=mean(posinit)
 set(handles.edit1,'String','+++++');
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count=80;
locate_points=65;
% w = webcam(2);
url = 'http://100.103.210.231:8080/shot.jpg';


for c = 1:count
%     img = w.snapshot;
I  = imread(url);
img = imresize(I,[300,400]);
    axes(handles.axes1);imshow(img) % display the image
       title('Input Info','fontsize',12,'fontname','Times New Roman','color','Black')
    f1=il_rgb2gray(double(img));
  [ysize,xsize]=size(f1);
  nptsmax=locate_points;   
  kparam=0.04;  
  pointtype=1;  
  sxl2=4;       
  sxi2=2*sxl2;  
  [posinit,valinit]=STIP(f1,kparam,sxl2,sxi2,pointtype,nptsmax);
  Test_Feat(c,1:locate_points)=valinit;
   axes(handles.axes2);imshow(f1,[]), hold on
 axis off;
 showellipticfeatures(posinit,[1 1 0]);
title('Segmented Info with Points','fontsize',12,'fontname','Times New Roman','color','Black')
 posinit=mean(posinit)

 if((posinit(1)<730 && posinit(1)>600))
tts('VIOLENCE DETECTED');
% msgbox('VIOLENCE DETECTED');
set(handles.edit1,'String','VIOLENCE DETECTED');
 end

end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla(handles.axes1); title(''); axis off
axes(handles.axes2); cla(handles.axes2); title(''); axis off
 set(handles.edit1,'String','--');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close 



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
1   