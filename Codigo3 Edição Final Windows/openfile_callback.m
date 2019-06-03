function [handles,f_config,h_config,f_report,h_report,data,T,fil]=openfile_callback
     %Pergunta pelo caminho do arquivo .mat a ser aberto
     [open_filename,open_path] = uigetfile("*.mat", "Abrir", 600, 200);
         open_path_name = sprintf("%s%s",open_path,open_filename);
         %Fecha as janelas antigas caso o caminho inserido esteja correto
         if ~ open_filename == 0
            close all force; 
            %Reinicializa a Interface Gráfica
            fig = openfig("Fig/guide2.fig", "new");
            handles = guihandles(fig);
            guidata(fig,handles);
            %abre o arquivo selecionado
            load(open_path_name);
            %desabilita a opção de exportar
            set(handles.export, "Visible", "off");
         end
     
end
