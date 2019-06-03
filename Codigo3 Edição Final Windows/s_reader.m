function [DF,df,Xs,SFFT,freq,str2,nstr]=s_reader(data,fil,amp,T,sample_rate,handles,nstr,str2,spec_resx,spec_resy)
    
    %% Inicializa��o da Janela do Leitor de Frequ�ncia Card�aca
    %Declara��o das vari�veis a serem utilizadas
    screen_time = 0;
    Xs=[];
    DF=[]; 
    SFFT=[];
    
    %Cria a figura de acordo com a resolu��o da tela
    fig_sreader=figure; 
    RES=get(0, 'screensize');
    set(fig_sreader,'Position', [0, RES(4)/6, RES(3), 2*RES(4)/3],'Name', 'Leitor da Dura��o das Bulhas Card�acas','NumberTitle', 'off');
    
    %% Filtragem dos dados completos n�o processados
    a = 1;
    data_filt=amp*filtfilt(fil,1,data);
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
            '* Favor pressionar a tecla Enter para finalizar a obten��o da dura��o das bulhas card�acas.');
        
        %L� as entradas do mouse e armazena suas posi��es
        [x,y]=ginput;
        Xs=[Xs; x];
        %Ao pressionar enter desloca o gr�fico em 5s
        screen_time=screen_time+5;
    end
    
    %% C�lculo da M�dia da Dura��o das Bulhas Card�acas (s)
    
    %Obt�m a dura��o da bulha card�aca
    for i=[2:2:length(Xs)] 
        DF=[DF; Xs(i)-Xs(i-1)]; 
    end
    
    %Faz a m�dia das dura��es
    df=mean(DF);
    
    %% C�lculo do Histograma da Dura��o das Bulhas Card�acas (s)

    % Utiliza a Regra de Freedman-Diaconis para calcular o comprimento
    % das barras do histograma
    h=2*iqr(DF)/(length(DF)^(1/3));
    % Calcula o n�mero de barras do histograma atrav�s do comprimento destas
    n=(max(DF)-min(DF))/h;
    n_aprox=round(n);
    
    %Plota o histograma da dura��o da bulha card�aca
    f_s_hist=figure;
    set(f_s_hist,'Name', 'Histograma da Dura��o e Frequ�ncia das Bulhas Card�acas','NumberTitle', 'off');
    subplot(2,1,1);
    hist(DF,n_aprox);
    title('Histograma da Dura��o das Bulhas Card�acas');
    ylabel('N� de Ocorr�ncias'); 
    xlabel('Dura��o das Bulhas Card�acas (s)');
   
    %% C�lculo da M�dia da Frequ�ncia das Bulhas Card�acas (s)
    %Obt�m a frequ�ncia da bulha card�aca
    for i=[2:2:length(Xs)] 
        sdata_filt = data_fir(Xs(i-1)*sample_rate:Xs(i)*sample_rate);
        NFFT=length(sdata_filt);
        
        %window=hanning(NFFT);
        alpha=0.5;
        window=windowing(NFFT,alpha);
        sfft = abs(fft(sdata_filt.*window,NFFT));
        [M,I] = max(sfft);
        f = ((0:1/NFFT:1-1/NFFT)*sample_rate).';
        max_sfft=f(I);
        SFFT=[SFFT; max_sfft];
    end
    %Faz a m�dia das frequ�ncias
    freq=mean(SFFT);
    
    %% C�lculo do Histograma da Frequ�ncia das Bulhas Card�acas (s)
    
    % Utiliza a Regra de Freedman-Diaconis para calcular o comprimento
    % das barras do histograma
    h=2*iqr(SFFT)/(length(SFFT)^(1/3));
    % Calcula o n�mero de barras do histograma atrav�s do comprimento destas
    n=(max(SFFT)-min(SFFT))/h;
    n_aprox=round(n);
    
    % Plota o histograma da frequ�ncia das bulhas card�acas
    subplot(2,1,2);
    hist(SFFT,n_aprox);
    title('Histograma de Frequ�ncia das Bulhas Card�acas'); 
    ylabel('N� de Ocorr�ncias'); 
    xlabel('Frequ�ncia das Bulhas Card�acas (Hz)');
    
    %% Notifica��es dos Valores M�dios
    nstr=nstr+1; 
    
    str3 = sprintf('M�dia da Dura��o do Som Card�aco n� %d: %d ms.', nstr, round(df*1000));
    str4 = sprintf('M�dia da Frequ�ncia do Som Card�aco n� %d: %d Hz.', nstr, round(freq));
    
    str2 = sprintf('%s \n %s \n %s', str2, str3, str4);
    set(handles.inf,"String", str2);
    
    end
    
    
    
    
    