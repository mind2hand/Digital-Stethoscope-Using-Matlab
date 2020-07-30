#Digital-Stethoscope-Using-Matlab

Projeto de Estetoscópio Digital usando o Matlab

O objetivo deste projeto foi criar um software de análise e processamento da ausculta cardíaca. Uma interface gráfica foi criada utilizando a ferramenta GUIDE do Matlab. Este projeto foi parte do trabalho de conclusão do curso de Engenharia Física. 

O software utiliza a Interface UMC 204 como entrada de áudio mas pode ser adaptado a outras placas como a placa interna dos computadores notebook.

Também será anexado o esquemático da placa condicionadora do sinal de áudio.  

Resumo: 

Visando difundir o uso das ferramentas de diagnóstico das doenças cardiovasculares, esse trabalho teve o objetivo de projetar um protótipo de estetoscópio digital caracterizado através da criação de: uma placa condicionadora do sinal da ausculta cardíaca, com filtros e amplificadores que enfatizam a faixa de frequências da ausculta e um software de análise e processamento dos sinais da ausculta cardíaca utilizando as ferramentas de desenvolvimento do Matlab. A resposta em frequência do módulo da função de transferência do circuito condicionador (esta função representa a razão entre a tensão de saída e a tensão de entrada do circuito), ou seja, o comportamento do ganho de tensão do circuito em função da frequência do sinal foi estimado teoricamente e também obtido experimentalmente. O valor deste se comportou como esperado no projeto para quase toda a faixa de frequência do sinal da ausculta cardíaca (16 a 1kHz), possuindo somente uma diminuição em relação ao valor esperado perante as frequências mais baixas da faixa da ausculta cardíaca (16 a 20Hz) Já a resposta em frequência do argumento da função de transferência, o qual estabelece o deslocamento de fase entre o sinal de saída e de entrada do circuito, foi somente estimada teoricamente, apresentando uma resposta não linear nas baixas frequências da faixa da ausculta (16 a 20Hz). O software desenvolvido utilizou filtros digitais de respostas ao impulso finitas criados pelo método dos mínimos quadrados para filtrar as frequências não referentes a ausculta. Também utilizou transformadas rápidas de Fourier implementadas pelo método recursivo para analisar o sinal no domínio das frequências. Para minimizar o fenômeno de Gibbs nos filtros digitais e o vazamento espectral nas transformadas rápidas de Fourier foram utilizadas funções janelas de Hann. Para compensar os atrasos introduzidos pelos filtros de resposta ao impulso finita foi utilizada a técnica de filtragem de fase nula. Os resultados demonstraram que as respostas de frequências do software também foram satisfatórias e lineares a altas frequências da ausculta, diferentemente das frequências mais baixas. Em contrapartida, as amostras da ausculta foram filtradas com sucesso no quesito de distinguibilidade das bulhas cardíacas no fonocardiograma, permitindo então que as análises dos batimentos cardíacos por minuto e de duração das bulhas fossem executadas com sucesso.

O trabalho completo pode ser encontrado em https://thesiscommons.org/7kge3 and https://www.researchgate.net/publication/343307214_PROJETO_DE_UM_ESTETOSCOPIO_DIGITAL_PARA_AUSCULTA_CARDIACA. 

Digital Stethoscope Design using Matlab

The objective of the project was to create a software to analyse and process the cardiac auscultation. A graphical interface was created using Matlab GUIDE and a apllication was compiled using Matlab. The language of the software was Portuguese - BR.  The project was part of my undergraduate thesis in Physics Engineering. 

The software analyses the audio input of a Audio Interface UMC 204, but it can be adapted to the pc inboard audio interface. 

It was also part of the project to build the hardware of the digital stethoscope. I'm annexing the hardware squematics and its PCB layout.

The abstract of the thesis was the following:

Trying to spread the use of cardiovascular diseases diagnostic tools, this undergraduate thesis had the purpose of creating a digital stethoscope prototype by creating a signal conditioning board composed by filters and amplifiers that emphasize the auscultation frequency band, and by creating a software for the analysis and processing of the cardiac auscultation signal using Matlab tools. The conditioning circuit transfer function modulus (which represents the input and output voltage ratio) was theorically and experimentally estimated. This value has behaved as expected for almost all the auscultation signal frequency band (16 to 1 kHz), just presenting a signal attenuation under the auscultation low frequencies. (16 to 20 Hz). Now the phase response obtained by the transfer function argument (which represents the output and input phase offset) was only theorically estimated but also presented a nonlinear response at low frequencies (16 to 20 Hz). The developed software made use of finite impulse response digital filters implemented by the least squares method to filter the frequencies not present in the auscultation band. Fast Fourier Transforms implemented by the recursive method were also utilized to analyze the signal in the frequency domain. To minimize the Gibbs phenomenon and the spectral leakage Hann windowing functions were utilized. To compensate the delay introduced by the finite impulse response filters the zero-phase filtering technique were utilized. The results had demonstrated that the software frequency response also was satisfactory at high frequencies, differently that at low frequencies. But in contrast, the auscultation samples were successfully filtered on the question of making the heart sounds distinguishable in the phonocardiograms, making possible that the heart rate and sound duration analysis were successfully executed. 

Key-words: Digital stethoscope. Cardiac Auscultation. Electrical Signals Filters.

The full thesis can be obtained in: https://thesiscommons.org/7kge3 or https://www.researchgate.net/publication/343307214_PROJETO_DE_UM_ESTETOSCOPIO_DIGITAL_PARA_AUSCULTA_CARDIACA.


