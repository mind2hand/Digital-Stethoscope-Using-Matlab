function [HR,hr,X,str2]=bpm_reader(data,fil,amp,T,sample_rate,handles,spec_resx,spec_resy)

    %% Inicialização da Janela do Leitor de Frequência Cardíaca
    % Declaração das variáveis a serem utilizadas
    screen_time = 0;
    X=[];
    X_dif=[]; 
    
    % Cria a figura de acordo com a resolução da tela
    fig_bpm=figure; 
    RES=get(0, 'screensize');
    set(fig_bpm,'Position', [0, RES(4)/6, RES(3), 2*RES(4)/3],'Name', 'Leitor de Batimentos por Minuto','NumberTitle', 'off');
    
    %% Filtragem dos dados completos não processados
    a = 1;
    data_filt=amp*filtfilt(fil,a,data);
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
            '* Favor pressionar a tecla Enter para finalizar a obtenção dos picos referentes as bulhas cardíacas S1.');
    
        %Lê as entradas do mouse e armazena suas posições
        [x,y]=ginput;
        X=[X; x];
        %Ao pressionar enter desloca o gráfico em 5s
        screen_time=screen_time+5;
    end
    %% Cálculo da Média da Frequência Cardíaca (bpm)
    
    %Obtêm o tempo entre picos
    for i=[2:1:length(X)] 
        X_dif=[X_dif; X(i)-X(i-1)]; 
    end
    
    % Obtêm as frequências cardíacas BPMs
    HR=60./X_dif;
    % Faz a média das frequências cardíacas
    hr=mean(HR);
    
    %Informa a frequência cardíaca média
    str2 = sprintf('Média dos Batimentos Cardíacos por Minuto: %d.',round(hr));
    set(handles.inf,"String", str2);
    
    %% Cálculo do Histograma da Frequência Cardíaca (bpm)
    
    % Utiliza a Regra de Freedman-Diaconis para calcular o comprimento
    % das barras do histograma
    h=2*iqr(HR)/(length(HR)^(1/3));
    % Calcula o número de barras do histograma através do comprimento destas
    n=(max(HR)-min(HR))/h;
    n_aprox=round(n);
    
    %Plota o histograma da frequência cardíaca 
    f_bpm_hist=figure;
    set(f_bpm_hist,'Name', 'Histograma dos Batimentos Cardíacos por Minuto',...
        'NumberTitle', 'off');
    hist(HR,n_aprox);
    title('Histograma dos Batimentos Cardíacos por Minuto');
    ylabel('Nº de Ocorrências'); 
    xlabel('Batimentos por Minuto');

end