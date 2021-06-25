%Use Fourier transforms to find the frequency components of a signal buried in noise.

close all
clear

%Specify the parameters of a signal with a sampling frequency of 1 kHz and a signal duration of 1.5 seconds.
Fs = 8000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 8;             % Length of signal
t = (0:L-1)*T;        % Time vector

%Form a signal containing a 50 Hz sinusoid of amplitude 0.7 and a 120 Hz sinusoid of amplitude 1.
S = sin(2*pi*1000*t) + 0.5*sin(2*pi*2000*t+3*pi/4)

%Define the frequency domain f and plot the single-sided amplitude spectrum P1. The amplitudes are not exactly at 0.7 and 1, as expected, because of the added noise. On average, longer signals produce better frequency approximations.
f = Fs*(0:(L/2))/L;

%Now, take the Fourier transform of the original, uncorrupted signal and retrieve the exact amplitudes, 0.7 and 1.0.
Y = fft(S)
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

stem(f,P1) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')