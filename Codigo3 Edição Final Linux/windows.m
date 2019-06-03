function [HR,hr,X,DF,df,Xs,SFFT,freq,str2,nstr,popup_index] = windows(handles,f_report,h_report,spec_resx,spec_resy)
     
    %% Inicialização das Janelas de Relatório e Leitura dos Batimentos Cardíacos ou Bulhas Cardíacas
    %Inicialização das Variáveis de Saída
    HR=[];
    hr=0;
    X=[];
    DF=[];
    df=0;
    Xs=[];
    SFFT=[];
    freq=0;
    str2='';
    nstr=0;
    
    %Declara o callback da opção de abrir a janela escolhida
    popup_index = get(handles.popup, "Value");
    popup_callback = ['popup_index = get(handles.popup, "Value");'];
    set(handles.popup, 'Callback', popup_callback);
    open_callback = ['[HR,hr,X,DF,df,Xs,SFFT,freq,str2,nstr] = open_callback(HR,hr,X,DF,df,Xs,SFFT,freq,str2,nstr,f_report,popup_index,data,fil,amp,T,sample_rate,handles,spec_resx,spec_resy);'];
    set(handles.open,'Callback',open_callback);
    
end

    
    
    
    