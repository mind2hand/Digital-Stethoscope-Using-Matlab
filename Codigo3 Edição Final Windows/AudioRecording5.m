function [recorder,Y,T,data,handles] = AudioRecording5(sample_rate,handles,recorder,fil,amp,Y,T,data,res,resy,resy_auto,lat)
    
    %% Declaração das Variáveis Utilizadas

    % Declaração do Índice do Último sample da gravação
    lastSampleIdx = 0;
    
    % Declaração do tempo de gravação
    atTimSecs = 0;
    
    % Declaração dos Índices das telas dos plots em tempo real
    graphidx=0;
    waveidx=0;
    
    % Reinicializa as variáveis de saída
    global Y;
    Y=[];
    global T;
    T=[];
    global data;
    data=[];
    
    % Atribui um timer de tempo igual a 1at para o gravador
    % Executa a fução audioTimer Callback a cada ocorrência do timer
    set(recorder,'TimerPeriod',lat,'TimerFcn',@audioTimerCallback);
    
    %% Declaração das Propriedades do Gráfico em Formato de Onda em Tempo Real
    
    % Plotam-se gráficos vazios
    graph_plot=plot(handles.graph,NaN,NaN);

    % Configura a resolução do eixo vertical do gráfico em tempo real
    if resy_auto == 0
        ylim(handles.graph,[-resy resy]);
    end
       
    % Descreve o eixo horizontal e vertical
    ylabel(handles.graph,'Amplitude Normalizada');
    xlabel(handles.graph,'Segundos');
    
    %% Declaração das Propriedades do Gráfico de Análise de Frequências em Tempo Real 
   
    %Plotam-se gráficos vazios
    spec_plot=plot(handles.spec,NaN,NaN);

    %Define a resolução do eixo horizontal
    xlim(handles.spec,[20 3000]);
    xticks(handles.spec,[20 200 2000]);
    yticks(handles.spec,10.^[-8:2:4]);
    
    %Descreve o eixo horizontal
    xlabel(handles.spec,'Frequência (Hz)');
    
    %Define a resolução do eixo vertical
    ylim(handles.spec,[10^-10 1000]);
    ylabel(handles.spec,'Magnitude');
    set(handles.spec,'XScale','log','YScale','log');
    
    %% Declaração das Propriedades do Gráfico em Formato de Onda em Tempo Real Ampliado
    
    %Plotam-se Gráficos Vazios
    wave_plot=plot(handles.wave,NaN,NaN);
 
    %Configura a resolução do eixo vertical do gráfico em tempo real
    if resy_auto == 0
        ylim(handles.wave,[-resy resy]);
    end

    %Descreve eixo horizontal 
    xlabel(handles.wave,'Segundos');
    ylabel(handles.wave,'Amplitude Normalizada');

    %% Inicializa a Gravação e os Gráficos
    
    %Começa a Gravação
    record(recorder);
    
    %Define o Callback das ocorrências do timer
    function audioTimerCallback(hObject,~)
        
        % Lê os samples gravados
        samples  = getaudiodata(hObject,'double');
        
        % Retorna caso a gravação tenha número de bits menor que a 
        %profundidade de bits dos gráficos 
        if length(samples)<lastSampleIdx+1+lat*sample_rate
            return;
        end
       
        % Cria as matrizes de dados
        X = samples(lastSampleIdx+1:lastSampleIdx+lat*sample_rate);
        data = [data; X];
        
        t = linspace(0,lat-1/sample_rate,lat*sample_rate) + atTimSecs;
        T=[T t];
        
        %% Filtragem dos Dados 
        
        % Declara os parâmetros recursivos do Filtro como sendo 1
        %ou seja, são não-recursivos
        a = 1;
        
        % Executa a primeira filtragem do Áudio com o filtro escolhido pelo
        % usuário
        X_filt=amp*filtfilt(fil,a,X);
        
        % Declara a ordem do filtro do fonocardiograma
        L=4097;

        % Obtêm os parâmetros do filtro do fonocardiograma
        b = fir_ls(L,44.1,4410,sample_rate);
        
        % Executa a filtragem do fonocardiograma
        X_fir=filtfilt(b,a,X_filt);
        
        % Salva a gravação filtrada
        Y=[Y; X_fir];
        
        %% Inicialização do Gráfico em Formato de Onda em Tempo Real
        
        % Plota o gráfico de picos em tempo real de acordo com a resolução
        xlim(handles.graph,[graphidx/sample_rate graphidx/sample_rate+res]);
        
        if graphidx < length(X_fir)-res*sample_rate
             set(graph_plot,'XData',T(graphidx+1:graphidx+res*sample_rate),'YData',Y(graphidx+1:graphidx+res*sample_rate));
         else
             set(graph_plot,'XData',T(graphidx+1:end),'YData',Y(graphidx+1:end));
         end
         
         if  lastSampleIdx >= graphidx+res*sample_rate
             graphidx=graphidx+res*sample_rate;
         end    

        %% Inicialização do Gráfico da Análise de Frequências em Tempo Real

        % Cria uma matriz de janelamento usando a função Hann
        NFFT = length(X_fir);
        alpha=0.5;
        window = windowing(NFFT,alpha);
        % Efetua a Transformada Rápida de Fourier e Plota em função 
        % da Frequência 
        FFT = fft_rec(X_fir.*window(1:NFFT));
        m=abs(FFT);
        f = ((0:1/NFFT:1-1/NFFT)*sample_rate).';
        set(spec_plot,'XData',f(1:NFFT/2),'YData',m(1:NFFT/2));
        
        %% Inicialização do Gráfico em Formato de Onda em Tempo Real Ampliado
        
        % Plota o gráfico de formato de onda em tempo real de acordo com 
        %a resolução
        
        xlim(handles.wave,[waveidx/sample_rate waveidx/sample_rate+10]);
         if waveidx < length(X_fir)-10*sample_rate
             set(wave_plot,'XData',T(waveidx+1:waveidx+10*sample_rate),...
                 'YData',Y(waveidx+1:waveidx+10*sample_rate));
         else
             set(wave_plot,'XData',T(waveidx+1:end),'YData',...
                 Y(waveidx+1:end));
         end
         
         if  lastSampleIdx >= waveidx+10*sample_rate
             waveidx=waveidx+10*sample_rate;
         end  

        %% Incrementos dos passos
        
        % Incrementa o índice da Última amostra
        lastSampleIdx = lastSampleIdx + lat*sample_rate;
        
        % Incrementa o tempo referente a Última amostra 
        atTimSecs     = atTimSecs + lat; 
    end
end