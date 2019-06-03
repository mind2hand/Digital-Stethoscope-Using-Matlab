function h = fir_ls(N,cut_freq,max_freq,sample_rate)

%% Filtro FIR passa-baixas por M�todo dos M�nimos Quadrados 

% Converte a ordem do filtro em comprimento das matrizes
M = (N-1)/2;

% Define as frequ�ncias angulares de corte
w_cl = 2*pi*cut_freq/sample_rate; 
w_ch = 2*pi*max_freq/sample_rate;

% Normaliza as frequ�ncias �ngulares por conveni�ncia 
f_cl = w_cl/pi;
f_ch = w_ch/pi;

% Calcula Q1 Q2 e Q para m�todo LS com W=1 
Q1 = 0.5*diag(ones(1,M+1));
Q2 = 0.5*hankel([1,zeros(1,M)]);
Q = Q1 + Q2;

% Calcula b
b=f_ch*sinc(f_ch*[0:M]')-f_cl*sinc(f_cl*[0:M]');

% Soluciona o sistema linear de equa��es
a  = Q\b;

% Cria uma matriz de janelamento de ordem N e alpha 0.54 (Hamming)
alpha=0.5;
window = windowing(N,alpha);

% Forma a resposta de frequ�ncia de dimens�o N 
h  = [a(M+1:-1:2)/2; a(1); a(2:M+1)/2].*window;

end
