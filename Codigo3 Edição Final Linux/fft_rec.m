function y = fft_rec(x)
    
    %% Transformada Rápida de Fourier pelo Método Recursivo
    n = length(x);
    %Finaliza o ciclo após r vezes, sendo N = 2^r 
    if n == 1
        y = x;
    %Aplica o método de divisões sucessicas r vezes, sendo N = 2^r
    else
        m = n/2;
        y_par = fft_rec(x(1:2:(n-1)));
        y_impar = fft_rec(x(2:2:n));
        w = exp(-2 * pi * 1i / n) .^ (0:m-1);
        z = w .* y_impar;
    %Une o valor da transformada X(k) com o da transformada a um 
    %ciclo posterior X(k + N/2)
        y = [ y_par + z , y_par - z ];
    end

end