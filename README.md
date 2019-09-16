# Digital-Stethoscope-Using-Matlab

The objective of the project was to create a software to analyse and process the cardiac auscultation. A graphical interface was created using Matlab GUIDE and a apllication was compiled using Matlab. The language of the software was Portuguese - BR.  The project was part of my undergraduate thesis in Physics Engineering. 

The software analyses the audio input of a Audio Interface UMC 204, but it can be adapted to the pc inboard audio interface. 

It was also part of the project to build the hardware of the digital stethoscope. I'm annexing the hardware squematics and its PCB layout.

The abstract of the thesis was the following:

Trying to spread the use of cardiovascular diseases diagnostic tools, this undergraduate thesis had the purpose of creating a digital stethoscope prototype by creating a signal conditioning board composed by filters and amplifiers that emphasize the auscultation frequency band, and by creating a software for the analysis and processing of the cardiac auscultation signal using Matlab tools. The conditioning circuit transfer function modulus (which represents the input and output voltage ratio) was theorically and experimentally estimated. This value has behaved as expected for almost all the auscultation signal frequency band (16 to 1 kHz), just presenting a signal attenuation under the auscultation low frequencies. (16 to 20 Hz). Now the phase response obtained by the transfer function argument (which represents the output and input phase offset) was only theorically estimated but also presented a nonlinear response at low frequencies (16 to 20 Hz). The developed software made use of finite impulse response digital filters implemented by the least squares method to filter the frequencies not present in the auscultation band. Fast Fourier Transforms implemented by the recursive method were also utilized to analyze the signal in the frequency domain. To minimize the Gibbs phenomenon and the spectral leakage Hann windowing functions were utilized. To compensate the delay introduced by the finite impulse response filters the zero-phase filtering technique were utilized. The results had demonstrated that the software frequency response also was satisfactory at high frequencies, differently that at low frequencies. But in contrast, the auscultation samples were successfully filtered on the question of making the heart sounds distinguishable in the phonocardiograms, making possible that the heart rate and sound duration analysis were successfully executed. 

Key-words: Digital stethoscope. Cardiac Auscultation. Electrical Signals Filters.

The full thesis can be obtained in: https://thesiscommons.org/7kge3 .
