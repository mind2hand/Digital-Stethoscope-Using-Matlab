function varargout = config(varargin)
% CONFIG MATLAB code for config.fig
%      CONFIG, by itself, creates a new CONFIG or raises the existing
%      singleton*.
%
%      H = CONFIG returns the handle to a new CONFIG or the handle to
%      the existing singleton*.
%
%      CONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIG.M with the given input arguments.
%
%      CONFIG('Property','Value',...) creates a new CONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before config_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to config_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help config

% Last Modified by GUIDE v2.5 07-Feb-2019 00:02:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @config_OpeningFcn, ...
                   'gui_OutputFcn',  @config_OutputFcn, ...
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


% --- Executes just before config is made visible.
function config_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to config (see VARARGIN)

% Choose default command line output for config
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes config wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = config_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in spec_resx.
function spec_resx_Callback(hObject, eventdata, handles)
% hObject    handle to spec_resx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns spec_resx contents as cell array
%        contents{get(hObject,'Value')} returns selected item from spec_resx


% --- Executes during object creation, after setting all properties.
function spec_resx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spec_resx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in spec_resy.
function spec_resy_Callback(hObject, eventdata, handles)
% hObject    handle to spec_resy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns spec_resy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from spec_resy


% --- Executes during object creation, after setting all properties.
function spec_resy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spec_resy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amp_Callback(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp as text
%        str2double(get(hObject,'String')) returns contents of amp as a double


% --- Executes during object creation, after setting all properties.
function amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in bit_depth.
function bit_depth_Callback(hObject, eventdata, handles)
% hObject    handle to bit_depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns bit_depth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bit_depth


% --- Executes during object creation, after setting all properties.
function bit_depth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bit_depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sample_rate.
function sample_rate_Callback(hObject, eventdata, handles)
% hObject    handle to sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sample_rate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sample_rate


% --- Executes during object creation, after setting all properties.
function sample_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
