function menu_callbacks(handles,f_config,h_config,h_report,f_report,data,T,fil)
    %% Definição dos Callbacks dos Menus

    %Define o callback do menu de preferências
    set(handles.config,'Callback','set(f_config,"Visible","on");');
    
    %Define o callback do menu de salvar 
    save_callback = [...
        '[save_filename,save_path] = uiputfile("*.mat", "Salvar Como");'...
        'save_path_name = sprintf("%s%s",save_path,save_filename);'...
        'save(save_path_name);'];
    set(handles.save, 'Callback', save_callback);
    
    %Define o callback do menu de abrir
    open_callback = ['[handles,f_config,h_config,f_report,h_report,data,T,fil]=openfile_callback;'];
    set(handles.m_open, 'Callback', open_callback);   
    
    %Define o callback do Menu de exportar
    export_callback = [...
        '[audio_ex_filename,audio_ex_path] = uiputfile("*.wav", "Exportar como Audio", 600, 200);'...
        'audio_ex_path_name = sprintf("%s%s",audio_ex_path,audio_ex_filename);'...
        'ex_filename=char(audio_ex_path_name);'...
        'fdata=amp*filter(fil,1,data);'...
        'audiowrite(ex_filename,fdata,sample_rate);'];
    set(handles.export,'Callback', export_callback);
    
    %Define o callback do Menu de Novo
    new_callback = [...
        'close all force;'...
        'cod1;'];
    set(handles.new,'Callback', new_callback);
    
    %Define o callback do Menu de Sair
    close_callback = ['close all force;'];
    set(handles.close,'Callback', close_callback);
end