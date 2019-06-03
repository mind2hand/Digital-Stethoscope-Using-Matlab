function [l,str] = play_callback(data,recorder,handles,l,str,sample_rate,bit_rate,amp,fil)
%% Notifica��es e Reprodu��o do �udio Gravado 
        % Envia erro caso a grava��o n�o tenha sido finalizada
        if recorder.Running == "on"
            str2="Erro: Grava��o ainda em Andamento.";
            if l >= 7
                str=str2;
                l=0;
            else
                str=sprintf("%s\n%s",str,str2);
            end
            l=l+1;
            set(handles.not,"String",str);
        else
            % Reproduz o �udio filtrado e amplificado
            fdata=amp*filtfilt(fil,1,data);
            sound(fdata,sample_rate,bit_rate);
            
            % Envia o status da reprodu��o do �udio
            str2="Reprodu��o Efetuada com Sucesso";
            if l >= 7
                str=str2;
                l=0;
            else
                str=sprintf("%s\n%s",str,str2);
            end
            l=l+1;
            set(handles.not,"String",str);
        end