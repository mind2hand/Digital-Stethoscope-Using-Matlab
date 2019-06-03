%% Inicializa��o da Interface Gr�fica 

%Caso a Interface j� tenha sido inicializada, fecha todas as janelas abertas
ifopen = evalin( 'base', 'exist(''fig'',''var'') == 1' );
if ifopen
    close all force;
end

% Abre Figura da GUI 
fig = openfig('Fig/guide2.fig', 'new');  %cria uma figura nova a cada ocorr�ncia do openfig

% Cria uma Estrutura com todos os Objetos da Figura
handles = guihandles(fig);

% Armazena os dados dos Objetos da Figura na Estrutura Criada
guidata(fig,handles);

% Configura a Interface para for�ar encerramento de todas janelas abertas ao clicar no �cone fechar
set(fig, 'CloseRequestFcn', 'close all force;');

%% Leitura da Resolu��o da Tela e Configura��o do Tamanho da Interface

% L� a resolu��o da Tela em Pixels
RES=get(0, 'screensize');
reso_x=RES(3);
reso_y=RES(4);

% Configura o Tamanho da Janela para o tamanho da tela
x=RES(3);
y=RES(4)-80;

% Posiciona a Janela no Centro da Tela 
cent_x=(reso_x-x)/2;
cent_y=(reso_y-y)/2;

% Ajusta a figura para o Tamanho e Posi��o Configurados
set(fig,'units', 'pixels', 'Position', [cent_x, cent_y, x, y],'resize', ...
    'off');

% Deleta as vari�veis desnecess�rias
clear cent_x cent_y RES reso_x reso_y x y;

%% Exibi��o da Interface Gr�fica

% Plota a logo do Software e �cones de Espera
imshow("Imagens/estetoscopio7.png", 'Parent', handles.logo);
imshow("Imagens/ampulheta4.png", 'Parent', handles.graph);
imshow("Imagens/ampulheta4.png", 'Parent', handles.spec);
imshow("Imagens/ampulheta4.png", 'Parent', handles.wave);

% Declara��o das vari�veis utilizadas para as notifica��es
l=0;
str=[];

% Envia a notifica��o de inicializa��o da interface
str='A Interface foi inicializada com sucesso.';
set(handles.not,'String',str);
l=l+1;

% Torna a Janela Vis�vel 
set(fig, 'Visible', 'on'); 

%% Leitura da Resolu��o dos Gr�ficos

[handles,res,resy,resy_auto,lat]=Graph_resolution(handles);

%% Declara��o de Valores Padr�es

% Leitura das configura��es escolhidas na janela de prefer�ncias
[f_config,h_config,bit_rate,sample_rate,filter_order,max_freq,cut_freq, ...
    fil,amp,spec_resx,spec_resy] = config_callbacks;

% Configura o dispositivo de entrada de �udio padr�o
devices = audiodevinfo;
in_dev = devices.input;
audio_dev=in_dev(2).ID;
clear devices;

%% Inicializa��o dos Callbacks dos Bot�es de: Gravar, Parar e Reproduzir e dos Gr�ficos do �udio Gravado

[Y,T,recorder,l,DEV,data,f_report,h_report] = ...
    audio_buttons_callbacks(l,handles,sample_rate,bit_rate,audio_dev, ...
    amp,fil,res,resy,resy_auto,lat,spec_resx,spec_resy);


%% Inicializa��o das Janelas de Relat�rio e An�lise dos Picos ou Bulhas Card�acas 

[HR,hr,X,DF,df,Xs,SFFT,freq,str2,nstr,popup_index]= windows(handles, ...
    f_report,h_report,spec_resx,spec_resy);


%% Inicializa��o dos Menus 

menu_callbacks(handles,f_config,h_report,data,T,fil);
