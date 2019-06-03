function [HR,hr,X,str2]=bpm_reader(data,fil,amp,T,sample_rate,handles,spec_resx,spec_resy)

    %% Inicializa��o da Janela do Leitor de Frequ�ncia Card�aca
    % Declara��o das vari�veis a serem utilizadas
    screen_time = 0;
    X=[];
    X_dif=[]; 
    
    % Cria a figura de acordo com a resolu��o da tela
    fig_bpm=figure; 
    RES=get(0, 'screensize');
    set(fig_bpm,'Position', [0, RES(4)/6, RES(3), 2*RES(4)/3],'Name', 'Leitor de Batimentos por Minuto','NumberTitle', 'off');
    
    %% Filtragem dos dados completos n�o processados
    a = 1;
    data_filt=amp*filtfilt(fil,a,data);
    L=4097;
    b = fir_ls(L,44.1,4410,sample_rate);
    data_fir=filtfilt(b,a,data_filt);
    
    %% Inicializa��o dos Gr�ficos dos dados
    %Plota os dados filtrados e o espectrograma destes
    while screen_time < T(end)  
        %Plota os dados filtrados
        graph=subplot(2,1,1); 
        plot(graph,T,data_fir); 
        xlabel('Tempo(s)');
        xlim([screen_time screen_time+5]);
    
        %Plota o espectrograma dos dados
        spectro=subplot(2,1,2);
        spectrogram(data_fir,length(data)/spec_resx,spec_resx,spec_resy,sample_rate,'yaxis'); 
        colorbar('off');
        xlabel('Tempo(s)');
        ylabel('');
        set(spectro,'YScale','log');
        ylim([0.01 2]);
        yticks([0.1 1]);
        yticklabels(['10^2'; '10^3']);
        xlim([screen_time screen_time+5]);
        
        %Insere string informativa
        uicontrol('style','text','units','normalized',...
            'position',[0 0 .1 .28],'string',...
            '* Favor pressionar a tecla Enter para finalizar a obten��o dos picos referentes as bulhas card�acas S1.');
    
        %L� as entradas do mouse e armazena suas posi��es
        [x,y]=ginput;
        X=[X; x];
        %Ao pressionar enter desloca o gr�fico em 5s
        screen_time=screen_time+5;
    end
    %% C�lculo da M�dia da Frequ�ncia Card�aca (bpm)
    
    %Obt�m o tempo entre picos
    for i=[2:1:length(X)] 
        X_dif=[X_dif; X(i)-X(i-1)]; 
    end
    
    % Obt�m as frequ�ncias card�acas BPMs
    HR=60./X_dif;
    % Faz a m�dia das frequ�ncias card�acas
    hr=mean(HR);
    
    %Informa a frequ�ncia card�aca m�dia
    str2 = sprintf('M�dia dos Batimentos Card�acos por Minuto: %d.',round(hr));
    set(handles.inf,"String", str2);
    
    %% C�lculo do Histograma da Frequ�ncia Card�aca (bpm)
    
    % Utiliza a Regra de Freedman-Diaconis para calcular o comprimento
    % das barras do histograma
    h=2*iqr(HR)/(length(HR)^(1/3));
    % Calcula o n�mero de barras do histograma atrav�s do comprimento destas
    n=(max(HR)-min(HR))/h;
    n_aprox=round(n);
    
    %Plota o histograma da frequ�ncia card�aca 
    f_bpm_hist=figure;
    set(f_bpm_hist,'Name', 'Histograma dos Batimentos Card�acos por Minuto',...
        'NumberTitle', 'off');
    hist(HR,n_aprox);
    title('Histograma dos Batimentos Card�acos por Minuto');
    ylabel('N� de Ocorr�ncias'); 
    xlabel('Batimentos por Minuto');

end