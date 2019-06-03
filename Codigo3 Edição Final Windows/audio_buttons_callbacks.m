function [Y,T,recorder,l,DEV,data,f_report,h_report] = audio_buttons_callbacks(l,handles,sample_rate,bit_rate,audio_dev,amp,fil,res,resy,resy_auto,lat,spec_resx,spec_resy)

    %% Inicialização das Variáveis de Saída
    
    % Deleta os valores das variáveis globais Y, T e data caso existentes
    clear global Y;
    clear global T;
    clear global data;
    global Y;
    global T;
    global data;
    
    % Cria uma matriz vazia para obtenção dos dispositivos de gravação
    DEV = [];
    
    %% Inicialização da Interface Gráfica da Janela de relatório
    
    % Áudio em Forma de Onda
    f_report = openfig('Fig/report.fig','reuse');
    h_report = guihandles(f_report);
    guidata(f_report,h_report);
    set(f_report,'CloseRequestFcn','set(f_report,"Visible","off");');
    
    %% Inicialização do Objeto de Gravação
    
    recorder = audiorecorder(sample_rate,bit_rate,1,audio_dev);
    
    %% Declaração dos callbacks dos botões de gravar, parar e reproduzir
    
    rec_callback=['[l,str,Y,handles,recorder,DEV,data] = record_callback(recorder,handles,l,str,res,resy,resy_auto,sample_rate,fil,amp,lat);'];
    set(handles.gravar, 'Callback', rec_callback);
   
    stop_callback = ['[T,Y,data,l,str,f_report,h_report] = stop_callback(recorder,handles,l,str,f_report,h_report,amp,fil,sample_rate,spec_resx,spec_resy);'];
    set(handles.parar, 'Callback', stop_callback);
    
    play_callback = ['[l,str] = play_callback(data,recorder,handles,l,str,sample_rate,bit_rate,amp,fil);'];
    set(handles.rep,'Callback', play_callback);
    
end