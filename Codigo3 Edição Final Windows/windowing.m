function window = windowing(N,alpha)
%% Função de Janelamento de Hann ou Hamming de ordem N
if ~rem(N,2)
   % Janelas de Comprimento Ímpar
   M = N/2;
   % Cria a matriz de janelamento
   w = alpha+(1-alpha)*cos(pi*[0:M]/M);
   window  = [w(M:-1:2) w(1) w(2:M) 0]';
else
   % Janelas de Comprimento Par
   M = (N-1)/2;
   % Cria a matriz de janelamento
   w = alpha+(1-alpha)*cos(pi*[0:M]/M);
   window  = [0 w(M:-1:2) w(1) w(2:M) 0]';
end
    
end