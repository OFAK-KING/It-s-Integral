function varargout = PDF(varargin)
% PDF M-file for PDF.fig
%      PDF, by itself, creates a new PDF or raises the existing
%      singleton*.
%
%      H = PDF returns the handle to a new PDF or the handle to
%      the existing singleton*.
%
%      PDF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PDF.M with the given input arguments.
%
%      PDF('Property','Value',...) creates a new PDF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PDF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PDF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
 
% Edit the above text to modify the response to help PDF
 
% Last Modified by GUIDE v2.5 29-Sep-2011 19:55:54
 
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PDF_OpeningFcn, ...
                   'gui_OutputFcn',  @PDF_OutputFcn, ...
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
 
 
% --- Executes just before PDF is made visible.
function PDF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PDF (see VARARGIN)
 
% Choose default command line output for PDF
handles.output = hObject;
 
% Update handles structure
guidata(hObject, handles);
 
% UIWAIT makes PDF wait for user response (see UIRESUME)
% uiwait(handles.figure1);
 
 
% --- Outputs from this function are returned to the command line.
function varargout = PDF_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Get default command line output from handles structure
varargout{1} = handles.output;
 
 
% --- Executes on button press in ofak1.
function ofak1_Callback(hObject, eventdata, handles)
% hObject    handle to ofak1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ofaking3 = str2num(get(handles.ofak3,'String'));
ofaking4 = str2num(get(handles.ofak4,'String'));
ofaking5 = str2num(get(handles.ofak5,'String'));
ofaking6 = str2num(get(handles.ofak6,'String'));
ofaking7 = str2num(get(handles.ofak7,'String'));
ofaking8 = str2num(get(handles.ofak8,'String'));
ofaking9 = str2num(get(handles.ofak9,'String'));
axes(handles.ofak10)
 
%% Initial Variables
N=1;           % Number of Underlying stocks
T = ofaking3;           % Months to take under account.
n = ofaking4;          % Price observations per month
t=T*n;         % Number of prices to generate until maturity
Sim = ofaking5;
 
delta = (1/t)*ones(t,N); % Times used in Stochastic Pricing Process (ones(t,N)
 
K = ofaking6;           % Strike Price
sigma =[ofaking7];      % Volatility
X0 =[ofaking8];         % Initial Price
mu = ofaking9;          % Risk-free interest rate
CurrentTime = 1;
 
SimulationsITO=ones(t,N);
FinalSimPriceITOSum=0;
 
 
 
%for S=1:Market  %%Market 
%% Process
 
for SPath=1:Sim
epsilon=randn(t,N);    
 
for j=1:N 
PriceITO=X0(j)*exp((((mu-  (sigma(j)^2))/2)*delta(:,j))+sigma(j)*epsilon(:,j).*sqrt(delta(:,j)));
 
end
 
SimulationsITO(:,SPath)=PriceITO; %%Each column is a simulation of n*t prices for N Stocks
FinalSimPriceITOSum=FinalSimPriceITOSum+SimulationsITO(t,SPath);
 
 
end
 
FinalSimPriceITOAverage=FinalSimPriceITOSum/Sim;
 
%% Option Prices
PayOffITO=max(FinalSimPriceITOAverage-K,0);
OptionPriceITO=PayOffITO*exp(-mu*T);
 
 
%% Ouputs
%%Market end
 
plot(SimulationsITO)
xlabel('Days')
ylabel('Price')
Title('Price Simulation ITô')
ofaking10 = num2str(OptionPriceITO);
set(handles.ofak,'string',ofaking10);
guidata(hObject, handles);
% --- Executes on button press in ofak2.
function ofak2_Callback(hObject, eventdata, handles)
% hObject    handle to ofak2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ofak3,'String',0)
set(handles.ofak4,'String',0)
set(handles.ofak5,'String',0)
set(handles.ofak6,'String',0)
set(handles.ofak7,'String',0)
set(handles.ofak8,'String',0)
set(handles.ofak9,'String',0)
cla(handles.ofak10,'reset')
guidata(hObject, handles);
 
function ofak3_Callback(hObject, eventdata, handles)
% hObject    handle to ofak3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of ofak3 as text
%        str2double(get(hObject,'String')) returns contents of ofak3 as a double
 
 
% --- Executes during object creation, after setting all properties.
function ofak3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ofak3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
 
function ofak4_Callback(hObject, eventdata, handles)
% hObject    handle to ofak4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of ofak4 as text
%        str2double(get(hObject,'String')) returns contents of ofak4 as a double
 
 
% --- Executes during object creation, after setting all properties.
function ofak4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ofak4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
 
function ofak5_Callback(hObject, eventdata, handles)
% hObject    handle to ofak5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of ofak5 as text
%        str2double(get(hObject,'String')) returns contents of ofak5 as a double
 
 
% --- Executes during object creation, after setting all properties.
function ofak5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ofak5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
 
function ofak6_Callback(hObject, eventdata, handles)
% hObject    handle to ofak6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of ofak6 as text
%        str2double(get(hObject,'String')) returns contents of ofak6 as a double
 
 
% --- Executes during object creation, after setting all properties.
function ofak6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ofak6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
 
function ofak7_Callback(hObject, eventdata, handles)
% hObject    handle to ofak7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of ofak7 as text
%        str2double(get(hObject,'String')) returns contents of ofak7 as a double
 
 
% --- Executes during object creation, after setting all properties.
function ofak7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ofak7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
 
function ofak8_Callback(hObject, eventdata, handles)
% hObject    handle to ofak8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of ofak8 as text
%        str2double(get(hObject,'String')) returns contents of ofak8 as a double
 
 
% --- Executes during object creation, after setting all properties.
function ofak8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ofak8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
 
function ofak9_Callback(hObject, eventdata, handles)
% hObject    handle to ofak9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of ofak9 as text
%        str2double(get(hObject,'String')) returns contents of ofak9 as a double
 
 
% --- Executes during object creation, after setting all properties.
function ofak9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ofak9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
