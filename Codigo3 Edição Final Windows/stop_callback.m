function [T,Y,data,l,str,f_report,h_report] = stop_callback(recorder,...
    handles,l,str,f_report,h_report,amp,fil,sample_rate,spec_resx,spec_resy)

%% Configura��o das Notifica��es
       if recorder.Running == "off"
       % Envia erro caso a grava��o n�o tenha sido inicializada     
           str2 = "Erro: Grava��o n�o foi inicializada";
       % Envia o status da finaliza��o da grava��o
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
           str2 = "A grava��o foi finalizada.";
            if l >= 7
                str=str2;
                l=0;
            else
                str=sprintf("%s\n%s",str,str2);
            end
            
            %% Filtragem dos dados completos
            
            % Chama as vari�veis globais obtidas na grava��o
            global data;
            global T;
            global Y;
            
            % Filtra a grava��o completa n�o processada
            a = 1;
            data_filt=amp*filtfilt(fil,a,data);
            L=4097; 
            b = fir_ls(L,44.1,4410,sample_rate);
            data_fir=filtfilt(b,a,data_filt);
            
            %% Inicializa��o da Janela do Relat�rio 
            
            % Declara os Callbacks da janela do relat�rio
            report_callbacks(h_report,T);
            
            % Plota os dados filtrados na janela de relat�rio
            plot(h_report.graph,T,data_fir);
            xlim(h_report.graph,[0 4]);
            ylabel(h_report.graph,'Amplitude Normalizada');
            
            % Plota um espectrograma dos dados filtrados
            axes(h_report.spectro);
            spectrogram(data_fir,length(data_filt)/spec_resx,spec_resx,...
                spec_resy,sample_rate,'yaxis');
            
            % Descreve e Configura o Espectrograma
            ylabel(h_report.spectro,'Frequ�ncia(kHz)');
            xlabel(h_report.spectro,'Tempo(s)');
            c=colorbar(h_report.spectro); 
            c.Label.String='Magnitude(dB/Hz)';
            set(h_report.spectro,'YScale','log');
            ylim(h_report.spectro,[0.01 2]);
            yticks(h_report.spectro,[0.1 1]);
            yticklabels(h_report.spectro,['10^2';'10^3']);
            xlim(h_report.spectro,[0 4]);
            
            % Envia as Notifica��es
            l=l+1;
            set(handles.not,"String",str);
            
        end
end