function varargout = waveform(varargin)
% WAVEFORM MATLAB code for waveform.fig
%      WAVEFORM, by itself, creates a new WAVEFORM or raises the existing
%      singleton*.
%
%      H = WAVEFORM returns the handle to a new WAVEFORM or the handle to
%      the existing singleton*.
%
%      WAVEFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAVEFORM.M with the given input arguments.
%
%      WAVEFORM('Property','Value',...) creates a new WAVEFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before waveform_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to waveform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help waveform

% Last Modified by GUIDE v2.5 03-Jan-2019 21:41:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @waveform_OpeningFcn, ...
                   'gui_OutputFcn',  @waveform_OutputFcn, ...
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


% --- Executes just before waveform is made visible.
function waveform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to waveform (see VARARGIN)

% Choose default command line output for waveform
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes waveform wait for user response (see UIRESUME)
% uiwait(handles.waveform);


% --- Outputs from this function are returned to the command line.
function varargout = waveform_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function export_Callback(hObject, eventdata, handles)
% hObject    handle to export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fig_Callback(hObject, eventdata, handles)
% hObject    handle to fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sheet_Callback(hObject, eventdata, handles)
% hObject    handle to sheet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
