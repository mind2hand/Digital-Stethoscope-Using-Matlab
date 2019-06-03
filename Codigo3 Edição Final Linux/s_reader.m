function [DF,df,Xs,SFFT,freq,str2,nstr]=s_reader(data,fil,amp,T,sample_rate,handles,nstr,str2,spec_resx,spec_resy)
    
    %% Inicialização da Janela do Leitor de Frequência Cardíaca
    %Declaração das variáveis a serem utilizadas
    screen_time = 0;
    Xs=[];
    DF=[]; 
    SFFT=[];
    
    %Cria a figura de acordo com a resolução da tela
    fig_sreader=figure; 
    RES=get(0, 'screensize');
    set(fig_sreader,'Position', [0, RES(4)/6, RES(3), 2*RES(4)/3],'Name', 'Leitor da Duração das Bulhas Cardíacas','NumberTitle', 'off');
    
    %% Filtragem dos dados completos não processados
    a = 1;
    data_filt=amp*filtfilt(fil,1,data);
    L=4097;
    b = fir_ls(L,44.1,4410,sample_rate);
    data_fir=filtfilt(b,a,data_filt);
    
    %% Inicialização dos Gráficos dos dados
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
            '* Favor pressionar a tecla Enter para finalizar a obtenção da duração das bulhas cardíacas.');
        
        %Lê as entradas do mouse e armazena suas posições
        [x,y]=ginput;
        Xs=[Xs; x];
        %Ao pressionar enter desloca o gráfico em 5s
        screen_time=screen_time+5;
    end
    
    %% Cálculo da Média da Duração das Bulhas Cardíacas (s)
    
    %Obtêm a duração da bulha cardíaca
    for i=[2:2:length(Xs)] 
        DF=[DF; Xs(i)-Xs(i-1)]; 
    end
    
    %Faz a média das durações
    df=mean(DF);
    
    %% Cálculo do Histograma da Duração das Bulhas Cardíacas (s)

    % Utiliza a Regra de Freedman–Diaconis para calcular o comprimento
    % das barras do histograma
    h=2*iqr(DF)/(length(DF)^(1/3));
    % Cálcula o número de barras do histograma através do comprimento destas
    n=(max(DF)-min(DF))/h;
    n_aprox=round(n);
    
    %Plota o histograma da duração da bulha cardíaca
    f_s_hist=figure;
    set(f_s_hist,'Name', 'Histograma da Duração e Frequência das Bulhas Cardíacas','NumberTitle', 'off');
    subplot(2,1,1);
    hist(DF,n_aprox);
    title('Histograma da Duração das Bulhas Cardíacas');
    ylabel('Nº de Ocorrências'); 
    xlabel('Duração das Bulhas Cardíacas (s)');
   
    %% Cálculo da Média da Frequência das Bulhas Cardíacas (s)
    %Obtêm a frequência da bulha cardíaca
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
    %Faz a média das frequências
    freq=mean(SFFT);
    
    %% Cálculo do Histograma da Frequência das Bulhas Cardíacas (s)
    
    % Utiliza a Regra de Freedman–Diaconis para calcular o comprimento
    % das barras do histograma
    h=2*iqr(SFFT)/(length(SFFT)^(1/3));
    % Cálcula o número de barras do histograma através do comprimento destas
    n=(max(SFFT)-min(SFFT))/h;
    n_aprox=round(n);
    
    % Plota o histograma da frequência das bulhas cardíacas
    subplot(2,1,2);
    hist(SFFT,n_aprox);
    title('Histograma de Frequência das Bulhas Cardíacas'); 
    ylabel('Nº de Ocorrências'); 
    xlabel('Frequência das Bulhas Cardíacas (Hz)');
    
    %% Notificações dos Valores Médios
    nstr=nstr+1; 
    
    str3 = sprintf('Média da Duração do Som Cardíaco nº %d: %d ms.', nstr, round(df*1000));
    str4 = sprintf('Média da Frequência do Som Cardíaco nº %d: %d Hz.', nstr, round(freq));
    
    str2 = sprintf('%s \n %s \n %s', str2, str3, str4);
    set(handles.inf,"String", str2);
    
    end
    
    
    
    
    