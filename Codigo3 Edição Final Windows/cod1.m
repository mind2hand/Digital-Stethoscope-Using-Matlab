%% Inicialização da Interface Gráfica 

%Caso a Interface já tenha sido inicializada, fecha todas as janelas abertas
ifopen = evalin( 'base', 'exist(''fig'',''var'') == 1' );
if ifopen
    close all force;
end

% Abre Figura da GUI 
fig = openfig('Fig/guide2.fig', 'new');  %cria uma figura nova a cada ocorrência do openfig

% Cria uma Estrutura com todos os Objetos da Figura
handles = guihandles(fig);

% Armazena os dados dos Objetos da Figura na Estrutura Criada
guidata(fig,handles);

% Configura a Interface para forçar encerramento de todas janelas abertas ao clicar no ícone fechar
set(fig, 'CloseRequestFcn', 'close all force;');

%% Leitura da Resolução da Tela e Configuração do Tamanho da Interface

% Lê a resolução da Tela em Pixels
RES=get(0, 'screensize');
reso_x=RES(3);
reso_y=RES(4);

% Configura o Tamanho da Janela para o tamanho da tela
x=RES(3);
y=RES(4)-80;

% Posiciona a Janela no Centro da Tela 
cent_x=(reso_x-x)/2;
cent_y=(reso_y-y)/2;

% Ajusta a figura para o Tamanho e Posição Configurados
set(fig,'units', 'pixels', 'Position', [cent_x, cent_y, x, y],'resize', ...
    'off');

% Deleta as variáveis desnecessárias
clear cent_x cent_y RES reso_x reso_y x y;

%% Exibição da Interface Gráfica

% Plota a logo do Software e Ícones de Espera
imshow("Imagens/estetoscopio7.png", 'Parent', handles.logo);
imshow("Imagens/ampulheta4.png", 'Parent', handles.graph);
imshow("Imagens/ampulheta4.png", 'Parent', handles.spec);
imshow("Imagens/ampulheta4.png", 'Parent', handles.wave);

% Declaração das variáveis utilizadas para as notificações
l=0;
str=[];

% Envia a notificação de inicialização da interface
str='A Interface foi inicializada com sucesso.';
set(handles.not,'String',str);
l=l+1;

% Torna a Janela Visível 
set(fig, 'Visible', 'on'); 

%% Leitura da Resolução dos Gráficos

[handles,res,resy,resy_auto,lat]=Graph_resolution(handles);

%% Declaração de Valores Padrões

% Leitura das configurações escolhidas na janela de preferências
[f_config,h_config,bit_rate,sample_rate,filter_order,max_freq,cut_freq, ...
    fil,amp,spec_resx,spec_resy] = config_callbacks;

% Configura o dispositivo de entrada de Áudio padrão
devices = audiodevinfo;
in_dev = devices.input;
audio_dev=in_dev(2).ID;
clear devices;

%% Inicialização dos Callbacks dos Botões de: Gravar, Parar e Reproduzir e dos Gráficos do Áudio Gravado

[Y,T,recorder,l,DEV,data,f_report,h_report] = ...
    audio_buttons_callbacks(l,handles,sample_rate,bit_rate,audio_dev, ...
    amp,fil,res,resy,resy_auto,lat,spec_resx,spec_resy);


%% Inicialização das Janelas de Relatório e Análise dos Picos ou Bulhas Cardíacas 

[HR,hr,X,DF,df,Xs,SFFT,freq,str2,nstr,popup_index]= windows(handles, ...
    f_report,h_report,spec_resx,spec_resy);


%% Inicialização dos Menus 

menu_callbacks(handles,f_config,h_report,data,T,fil);
