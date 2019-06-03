function [HR,hr,X,DF,df,Xs,SFFT,freq,str2,nstr] = open_callback(HR, hr, X,DF,df,Xs,SFFT,freq,str2, nstr, f_report,popup_index,data,fil,amp,T,sample_rate,handles,spec_resx,spec_resy)
    %% Definição das Ações a Serem Executadas para cada Janela
    if popup_index == 1
        %Torna a janela do relatório visível 
        set(f_report,'Visible','on');
    elseif popup_index == 2
        %Cria a janela do leitor de BPMs
        [HR,hr,X,str2]=bpm_reader(data,fil,amp,T,sample_rate,handles,spec_resx,spec_resy);
    else
        %Cria a janela do leitor de bolhas cardíacas 
        [DF,df,Xs,SFFT,freq,str2,nstr]=s_reader(data,fil,amp,T,sample_rate,handles,nstr,str2,spec_resx,spec_resy);
    end
    
end