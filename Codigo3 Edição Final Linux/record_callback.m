function [l,str,Y,handles,recorder,DEV,data] = record_callback(recorder,...
    handles,l,str,res,resy,resy_auto,sample_rate,fil,amp,lat)
    %% Limpeza dos dados passados

    % Reinicialização das Variáveis de Saída
    data=[];
    Y=[];
    T=[]; 
    DEV = [];

    set(get(handles.graph, 'Parent'), 'HandleVisibility', 'on');
    axes(handles.graph);
    cla(handles.graph,'reset');
    
    %% Notificações e Inicialização da Gravação
    
    % Inicializa a gravação caso ainda não tenha sido inicializada
    if recorder.Running == "off"
            
            % Inicializa a gravação e os gráficos em tempo real
            [recorder,Y,T,data,handles] = AudioRecording5(sample_rate,...
                handles,recorder,fil,amp,Y,T,data,res,resy,resy_auto,lat);
            
   % Envia o status da reprodução como notificação 
            str2 = "Gravação foi iniciada.";          
            if l >= 7
                str=str2;
                l=0;
            else
                str=sprintf("%s\n%s",str,str2);
            end
            l=l+1;
            set(handles.not,"String",str);
    else
           
            str2="Error: Gravação já foi iniciada.";
            if l >= 7
                str=str2;
                l=0;
            else
                str=sprintf("%s\n%s",str,str2);
            end
            l=l+1;
            set(handles.not,"String",str);
    end
