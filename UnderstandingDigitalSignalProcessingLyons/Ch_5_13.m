close all
clear

%-- common --
Fs = 2*pi;            % Sampling frequency                    
L = 640;             % Length of signal
f = Fs*(0:(L/2))/L;

%-- lowpass filter H1 --
h1_k = [1 2 1];

%-- lowpass filter H1 fft --
H1m = fft( [h1_k zeros(1, L - length(h1_k))] );
% H1m_P2 = abs(H1m/1);    % don't divide because filter coefficients are already scaled ???
H1m_P2 = 20*log10(abs(H1m/1));    % don't divide because filter coefficients are already scaled ???
H1m_P1 = H1m_P2(1:L/2+1);
H1m_P1(2:end-1) = H1m_P1(2:end-1);

%-- lowpass filter H2 --
h2_k = [1 1];

%-- lowpass filter H2 fft --
H2m = fft( [h2_k zeros(1, L - length(h2_k))] );
% H2m_P2 = abs(H2m/1);    % don't divide because filter coefficients are already scaled ???
H2m_P2 = 20*log10(abs(H2m/1));    % don't divide because filter coefficients are already scaled ???
H2m_P1 = H2m_P2(1:L/2+1);
H2m_P1(2:end-1) = H2m_P1(2:end-1);

%-- plots --
figure
plot(f,H1m_P1, f, H2m_P1) 
grid on
title('Single-Sided Amplitude Spectrum of H1(m) and H2(m)')
xlabel('f (Hz)')
ylabel('|Hlm(f)|')
set(gca,'XTick',0:pi/2:pi) 
set(gca,'XTickLabel',{'0','\pi/2','\pi'})

fvtool(h1_k, 1, h2_k, 1);