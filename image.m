function varargout = image(varargin)
% IMAGE MATLAB code for image.fig
%      IMAGE, by itself, creates a new IMAGE or raises the existing
%      singleton*.
%
%      H = IMAGE returns the handle to a new IMAGE or the handle to
%      the existing singleton*.
%
%      IMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE.M with the given input arguments.
%
%      IMAGE('Property','Value',...) creates a new IMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before image_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to image_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help image

% Last Modified by GUIDE v2.5 25-Nov-2021 00:36:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @image_OpeningFcn, ...
                   'gui_OutputFcn',  @image_OutputFcn, ...
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


% --- Executes just before image is made visible.
function image_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to image (see VARARGIN)

% Choose default command line output for image
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes image wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = image_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global face
global img
training = imageset('dataset','recursive');
%[training,test] = partition(faceDatabase,[0.8 0.2]);
trainingFeatures = zeros(size(training,2)*training(1).Count,4680);
featureCount = 1;
for i=1:size(training,2)
    for j = 1:training(i).Count
        trainingFeatures(featureCount,:) = extractHOGFeatures(read(training(i),j));
        trainingLabel{featureCount} = training(i).Description;
        featureCount = featureCount + 1;
    end
    personIndex{i} = training(i).Description;
end

faceClassifier = fitcecoc(trainingFeatures,trainingLabel);

query=imresize(face,[112,92]);
queryFeatures = extractHOGFeatures(img);
personLabel = predict(faceClassifier,queryFeatures);
a=personLabel;
magbox('Person Recognize Successfully','INFO....!!!','MODAL')
a=cell2mat(a);
zzz={'C:\PC\Documents\MATLAB\dataset',s1,'\1.pgm'};
b=imread(zzz);
axes(handles.axes4)
imshow(b)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global face
global img
clc;
[filename, folder]=uigetfile({'*.pgm';'*.pgm';'*.pgm';'*.pgm';'*.pgm';'*.pgm';'*.pgm';'*.pgm';'*.pgm';'*.pgm';},'File Selector')
fullFileName = fullfile(folder, filename);
img = imread(fullFileName);
axes(handle.axes3);
imshow(img);
    faceDetector = vision.CasacadeObjectDetector();
 bbox = step(faceDetector, img);

 videoFrame = insertShape(img, 'Rectangle', bbox);
 faceBBox   = step(faceDetector,videoFrame);
    x = faceBBox(1); y = faceBBox(2); w = faceBBox(3); h = faceBBox(4);
    bboxPolygon = [x, y, x+w, y, x+w, y+1.56*h, x, y+1.56*h];
    face = imcrop(videoFrame,faceBBox);
    axes(handles.axes4);
    imshow(face);
