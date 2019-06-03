# Digital-Stethoscope-Using-Matlab

The objective of the project was to create a software to analyse and process the cardiac auscultation. A graphical interface was created using Matlab GUIDE and a apllication was compiled using Matlab. The language of the software was Portuguese - BR.  The project was part of my undergraduate thesis in Physics Engineering. 

The software analyses the audio input of a Audio Interface UMC 204, but it can be adapted to the pc inboard audio interface. 

It was also part of the project to build the hardware of the digital stethoscope. I'm annexing the hardware KiCad files.

The abstract of the thesis was the following, the complete thesis will be uploaded after the presentation. 

This undergraduate thesis had the purpose of creating a digital stethoscope prototype by implementing a signal conditioning board and developing a software for the analysis and processing of the cardiac auscultation signal using Matlab tools. Filters and amplifiers were used in the conditioning board to emphasize the auscultation frequency band. The conditioning board frequency and phase responses were theoretically estimated and the amplification factor was experimentally tested proving that the high frequencies frequency response was satisfactory but the auscultation low frequencies were attenuated. The software made use of finite impulse response digital filters implemented by the least squares method to filter the frequencies not present in the auscultation band. Fast Fourier Transforms implemented by the recursive method were also utilized to analyze the signal in the frequency domain. To minimize the Gibbs phenomenon and the spectral leakage Hann windowing functions were utilized. To compensate the delay introduced by the finite impulse response filters the zero-phase filtering technique were utilized. The results had demonstrated that the Hann windowing and the zero-phase filtering were successful utilized and that the frequency response of the digital filters were acceptable over the auscultation frequency band.

Key-words: Digital stethoscope. Cardiac Auscultation. Matlab. 
