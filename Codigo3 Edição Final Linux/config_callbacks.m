function [f_config,h_config,bit_rate,sample_rate,filter_order,max_freq,cut_freq,fil,amp,spec_resx,spec_resy] = config_callbacks
    %% Declaração das Configurações Padrões
    
    % Inicializa a janela de preferências
    f_config = openfig('Fig/config.fig','reuse');
    h_config = guihandles(f_config);
    guidata(f_config,h_config);
    set(f_config,'CloseRequestFcn','set(f_config,"Visible","off");');
    
    % Obtêm os Valores Padrões das Configurações de Amostragem 
    bit_rate_matrix = get(h_config.bit_depth, "String");
    bit_rate_index = get(h_config.bit_depth,"Value");
    bit_rate=str2num(cell2mat(bit_rate_matrix(bit_rate_index)));
    sample_rate=44100;
      
    % Obtêm os Valores Padrões das Configurações de Filtro  
    bell_value = get(h_config.bell,"Value");
    diaphragm_value = get(h_config.diaphragm,"Value");
    extended_value = get(h_config.extended, "Value");
    
    filt_matrix = [bell_value, diaphragm_value, extended_value];
    
    % Declara a Ordem e as Frequências de Cortes dos Filtros 
    filter_order = 513;
    
    if filt_matrix == [1,0,0]
        max_freq = 220;
        cut_freq = 20;
    elseif filt_matrix == [0,1,0]
        max_freq = 600;
        cut_freq = 50;
    else 
        max_freq = 2000;
        cut_freq = 20;
    end
    
    %Cria um filtro digital com as configurações padrões
    fil = fir_ls(filter_order,cut_freq,max_freq,sample_rate);
    
    %Obtêm o Valor de Amplificação Padrão
    amp=10^(str2num(get(h_config.amp, "String"))/20);
    
    %Obtêm os Valores Padrões das Configurações do Espectrograma 
    spec_resx_matrix = get(h_config.spec_resx, "String");
    spec_resy_matrix = get(h_config.spec_resy, "String");
    
    spec_resx_index = get(h_config.spec_resx, "Value");
    spec_resy_index = get(h_config.spec_resy, "Value");

    spec_resx=str2num(cell2mat(spec_resx_matrix(spec_resx_index)));
    spec_resy=str2num(cell2mat(spec_resy_matrix(spec_resy_index)));
    
    %% Declaração dos Callbacks da Janela de Preferências
    
    %Strings dos Callbacks:
    
    %Profundidade de Bits
    bit_depth_callback = [...
        'bit_rate_matrix = get(h_config.bit_depth, "String");'...
        'bit_rate_index = get(h_config.bit_depth,"Value");'...
        'bit_rate=str2num(cell2mat(bit_rate_matrix(bit_rate_index)));'...
        'clear bit_rate_matrix bit_rate_index'];
    
    
    %Filtro Digital:
    %Campânula
    bell_callback = [...
        'max_freq = 220;'...
        'cut_freq = 20;'...
        'fil = fir_ls(filter_order,cut_freq,max_freq,sample_rate);'];
    
    %Diafragma
    diaphragm_callback = [...
        'max_freq = 600;'...
        'cut_freq = 50;'...
        'fil = fir_ls(filter_order,cut_freq,max_freq,sample_rate);'];
    
    %Modo Extendido
    extended_callback = [...
        'max_freq = 2000;'...
        'cut_freq = 20;'...
        'fil = fir_ls(filter_order,cut_freq,max_freq,sample_rate);'];
    
    
    %Amplificação
    amp_callback = ['amp=10^(str2num(get(h_config.amp, "String"))/20);'];
    
    %Espectrograma 
    %Resolução do eixo horizontal
    spec_resx_callback = [...
        'spec_resx_matrix = get(h_config.spec_resx, "String");'...
        'spec_resx_index = get(h_config.spec_resx, "Value");'...
        'spec_resx=str2num(cell2mat(spec_resx_matrix(spec_resx_index)));'...
        'clear spec_resx_matrix spec_resx_index;'];
    
    %Resolução do eixo vertical
    spec_resy_callback = [...
        'spec_resy_matrix = get(h_config.spec_resy, "String");'...
        'spec_resy_index = get(h_config.spec_resy, "Value");'...
        'spec_resy=str2num(cell2mat(spec_resy_matrix(spec_resy_index)));'...
        'clear spec_resy_matrix spec_resy_index;'];
    
    %Declaração dos Callbacks
    
    set(h_config.bit_depth, 'Callback', bit_depth_callback);
    set(h_config.bell, 'Callback', bell_callback);
    set(h_config.diaphragm, 'Callback', diaphragm_callback);
    set(h_config.extended, 'Callback', extended_callback);
    set(h_config.amp, 'Callback', amp_callback);
    set(h_config.spec_resx, 'Callback', spec_resx_callback);
    set(h_config.spec_resy, 'Callback', spec_resy_callback);
    
end