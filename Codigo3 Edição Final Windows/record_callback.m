function [l,str,Y,handles,recorder,DEV,data] = record_callback(recorder,...
    handles,l,str,res,resy,resy_auto,sample_rate,fil,amp,lat)
    %% Limpeza dos dados passados

    % Reinicializa��o das Vari�veis de Sa�da
    data=[];
    Y=[];
    T=[]; 
    DEV = [];

    set(get(handles.graph, 'Parent'), 'HandleVisibility', 'on');
    axes(handles.graph);
    cla(handles.graph,'reset');
    
    %% Notifica��es e Inicializa��o da Grava��o
    
    % Inicializa a grava��o caso ainda n�o tenha sido inicializada
    if recorder.Running == "off"
            
            % Inicializa a grava��o e os gr�ficos em tempo real
            [recorder,Y,T,data,handles] = AudioRecording5(sample_rate,...
                handles,recorder,fil,amp,Y,T,data,res,resy,resy_auto,lat);
            
   % Envia o status da reprodu��o como notifica��o 
            str2 = "Grava��o foi iniciada.";          
            if l >= 7
                str=str2;
                l=0;
            else
                str=sprintf("%s\n%s",str,str2);
            end
            l=l+1;
            set(handles.not,"String",str);
    else
           
            str2="Error: Grava��o j� foi iniciada.";
            if l >= 7
                str=str2;
                l=0;
            else
                str=sprintf("%s\n%s",str,str2);
            end
            l=l+1;
            set(handles.not,"String",str);
    end
