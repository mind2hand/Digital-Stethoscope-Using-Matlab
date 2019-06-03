function [T,Y,data,l,str,f_report,h_report] = stop_callback(recorder,...
    handles,l,str,f_report,h_report,amp,fil,sample_rate,spec_resx,spec_resy)

%% Configuração das Notificações
       if recorder.Running == "off"
       % Envia erro caso a gravação não tenha sido inicializada     
           str2 = "Erro: Gravação não foi inicializada";
       % Envia o status da finalização da gravação
            if l >= 7
                str=str2;
                l=0;
            else
                str=sprintf("%s\n%s",str,str2);
            end
            l=l+1;
            set(handles.not,"String",str);
       else
           stop(recorder);
           str2 = "A gravação foi finalizada.";
            if l >= 7
                str=str2;
                l=0;
            else
                str=sprintf("%s\n%s",str,str2);
            end
            
            %% Filtragem dos dados completos
            
            % Chama as variáveis globais obtidas na gravação
            global data;
            global T;
            global Y;
            
            % Filtra a gravação completa não processada
            a = 1;
            data_filt=amp*filtfilt(fil,a,data);
            L=4097; 
            b = fir_ls(L,44.1,4410,sample_rate);
            data_fir=filtfilt(b,a,data_filt);
            
            %% Inicialização da Janela do Relatório 
            
            % Declara os Callbacks da janela do relatório
            report_callbacks(h_report,T);
            
            % Plota os dados filtrados na janela de relatório
            plot(h_report.graph,T,data_fir);
            xlim(h_report.graph,[0 4]);
            ylabel(h_report.graph,'Amplitude Normalizada');
            
            % Plota um espectrograma dos dados filtrados
            axes(h_report.spectro);
            spectrogram(data_fir,length(data_filt)/spec_resx,spec_resx,...
                spec_resy,sample_rate,'yaxis');
            
            % Descreve e Configura o Espectrograma
            ylabel(h_report.spectro,'Frequência(kHz)');
            xlabel(h_report.spectro,'Tempo(s)');
            c=colorbar(h_report.spectro); 
            c.Label.String='Magnitude(dB/Hz)';
            set(h_report.spectro,'YScale','log');
            ylim(h_report.spectro,[0.01 2]);
            yticks(h_report.spectro,[0.1 1]);
            yticklabels(h_report.spectro,['10^2';'10^3']);
            xlim(h_report.spectro,[0 4]);
            
            % Envia as Notificações
            l=l+1;
            set(handles.not,"String",str);
            
        end
end