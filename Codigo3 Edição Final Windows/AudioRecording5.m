function [recorder,Y,T,data,handles] = AudioRecording5(sample_rate,handles,recorder,fil,amp,Y,T,data,res,resy,resy_auto,lat)
    
    %% Declara��o das Vari�veis Utilizadas

    % Declara��o do �ndice do �ltimo sample da grava��o
    lastSampleIdx = 0;
    
    % Declara��o do tempo de grava��o
    atTimSecs = 0;
    
    % Declara��o dos �ndices das telas dos plots em tempo real
    graphidx=0;
    waveidx=0;
    
    % Reinicializa as vari�veis de sa�da
    global Y;
    Y=[];
    global T;
    T=[];
    global data;
    data=[];
    
    % Atribui um timer de tempo igual a 1at para o gravador
    % Executa a fu��o audioTimer Callback a cada ocorr�ncia do timer
    set(recorder,'TimerPeriod',lat,'TimerFcn',@audioTimerCallback);
    
    %% Declara��o das Propriedades do Gr�fico em Formato de Onda em Tempo Real
    
    % Plotam-se gr�ficos vazios
    graph_plot=plot(handles.graph,NaN,NaN);

    % Configura a resolu��o do eixo vertical do gr�fico em tempo real
    if resy_auto == 0
        ylim(handles.graph,[-resy resy]);
    end
       
    % Descreve o eixo horizontal e vertical
    ylabel(handles.graph,'Amplitude Normalizada');
    xlabel(handles.graph,'Segundos');
    
    %% Declara��o das Propriedades do Gr�fico de An�lise de Frequ�ncias em Tempo Real 
   
    %Plotam-se gr�ficos vazios
    spec_plot=plot(handles.spec,NaN,NaN);

    %Define a resolu��o do eixo horizontal
    xlim(handles.spec,[20 3000]);
    xticks(handles.spec,[20 200 2000]);
    yticks(handles.spec,10.^[-8:2:4]);
    
    %Descreve o eixo horizontal
    xlabel(handles.spec,'Frequ�ncia (Hz)');
    
    %Define a resolu��o do eixo vertical
    ylim(handles.spec,[10^-10 1000]);
    ylabel(handles.spec,'Magnitude');
    set(handles.spec,'XScale','log','YScale','log');
    
    %% Declara��o das Propriedades do Gr�fico em Formato de Onda em Tempo Real Ampliado
    
    %Plotam-se Gr�ficos Vazios
    wave_plot=plot(handles.wave,NaN,NaN);
 
    %Configura a resolu��o do eixo vertical do gr�fico em tempo real
    if resy_auto == 0
        ylim(handles.wave,[-resy resy]);
    end

    %Descreve eixo horizontal 
    xlabel(handles.wave,'Segundos');
    ylabel(handles.wave,'Amplitude Normalizada');

    %% Inicializa a Grava��o e os Gr�ficos
    
    %Come�a a Grava��o
    record(recorder);
    
    %Define o Callback das ocorr�ncias do timer
    function audioTimerCallback(hObject,~)
        
        % L� os samples gravados
        samples  = getaudiodata(hObject,'double');
        
        % Retorna caso a grava��o tenha n�mero de bits menor que a 
        %profundidade de bits dos gr�ficos 
        if length(samples)<lastSampleIdx+1+lat*sample_rate
            return;
        end
       
        % Cria as matrizes de dados
        X = samples(lastSampleIdx+1:lastSampleIdx+lat*sample_rate);
        data = [data; X];
        
        t = linspace(0,lat-1/sample_rate,lat*sample_rate) + atTimSecs;
        T=[T t];
        
        %% Filtragem dos Dados 
        
        % Declara os par�metros recursivos do Filtro como sendo 1
        %ou seja, s�o n�o-recursivos
        a = 1;
        
        % Executa a primeira filtragem do �udio com o filtro escolhido pelo
        % usu�rio
        X_filt=amp*filtfilt(fil,a,X);
        
        % Declara a ordem do filtro do fonocardiograma
        L=4097;

        % Obt�m os par�metros do filtro do fonocardiograma
        b = fir_ls(L,44.1,4410,sample_rate);
        
        % Executa a filtragem do fonocardiograma
        X_fir=filtfilt(b,a,X_filt);
        
        % Salva a grava��o filtrada
        Y=[Y; X_fir];
        
        %% Inicializa��o do Gr�fico em Formato de Onda em Tempo Real
        
        % Plota o gr�fico de picos em tempo real de acordo com a resolu��o
        xlim(handles.graph,[graphidx/sample_rate graphidx/sample_rate+res]);
        
        if graphidx < length(X_fir)-res*sample_rate
             set(graph_plot,'XData',T(graphidx+1:graphidx+res*sample_rate),'YData',Y(graphidx+1:graphidx+res*sample_rate));
         else
             set(graph_plot,'XData',T(graphidx+1:end),'YData',Y(graphidx+1:end));
         end
         
         if  lastSampleIdx >= graphidx+res*sample_rate
             graphidx=graphidx+res*sample_rate;
         end    

        %% Inicializa��o do Gr�fico da An�lise de Frequ�ncias em Tempo Real

        % Cria uma matriz de janelamento usando a fun��o Hann
        NFFT = length(X_fir);
        alpha=0.5;
        window = windowing(NFFT,alpha);
        % Efetua a Transformada R�pida de Fourier e Plota em fun��o 
        % da Frequ�ncia 
        FFT = fft_rec(X_fir.*window(1:NFFT));
        m=abs(FFT);
        f = ((0:1/NFFT:1-1/NFFT)*sample_rate).';
        set(spec_plot,'XData',f(1:NFFT/2),'YData',m(1:NFFT/2));
        
        %% Inicializa��o do Gr�fico em Formato de Onda em Tempo Real Ampliado
        
        % Plota o gr�fico de formato de onda em tempo real de acordo com 
        %a resolu��o
        
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
        
        % Incrementa o �ndice da �ltima amostra
        lastSampleIdx = lastSampleIdx + lat*sample_rate;
        
        % Incrementa o tempo referente a �ltima amostra 
        atTimSecs     = atTimSecs + lat; 
    end
end