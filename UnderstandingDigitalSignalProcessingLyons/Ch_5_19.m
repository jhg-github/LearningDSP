close all
clear

%-- common --
% Fs = 1000;            % Sampling frequency                    
% T = 1/Fs;             % Sampling period       
L = 128;             % Length of signal
% t = (0:L-1)*T;        % Time vector
% f1 = 20;
% fpass = 240;
% fstop = 250;
% firOrder = 16;
% ntaps = firOrder + 1;
% f = Fs*(0:(L/2))/L;
% 
% %-- signal --
% xn = sin(2*pi*f1*t);
% 
% %-- signal fft --
% Xm = fft(xn);
% P2 = abs(Xm/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);

%-- lowpass filter --
b = 0
hk0 = [b 0 256-b 0 b];
Hm = fft( [hk0 zeros(1, L - length(hk0))] );
Hm_P2 = abs(Hm/L);    % don't divide because filter coefficients are already scaled ???
Hm_P1 = Hm_P2(1:L/2+1);
Hm_P1(2:end-1) = Hm_P1(2:end-1);
Hm0 = Hm_P1;

b = 64
hk64 = [b 0 256-b 0 b];
Hm = fft( [hk64 zeros(1, L - length(hk64))] );
Hm_P2 = abs(Hm/L);    % don't divide because filter coefficients are already scaled ???
Hm_P1 = Hm_P2(1:L/2+1);
Hm_P1(2:end-1) = Hm_P1(2:end-1);
Hm64 = Hm_P1;

b = 128
hk128 = [b 0 256-b 0 b];
Hm = fft( [hk128 zeros(1, L - length(hk128))] );
Hm_P2 = abs(Hm/L);    % don't divide because filter coefficients are already scaled ???
Hm_P1 = Hm_P2(1:L/2+1);
Hm_P1(2:end-1) = Hm_P1(2:end-1);
Hm128 = Hm_P1;

b = 192
hk192 = [b 0 256-b 0 b];
Hm = fft( [hk192 zeros(1, L - length(hk192))] );
Hm_P2 = abs(Hm/L);    % don't divide because filter coefficients are already scaled ???
Hm_P1 = Hm_P2(1:L/2+1);
Hm_P1(2:end-1) = Hm_P1(2:end-1);
Hm192 = Hm_P1;

%-- plots --
subplot(2,1,1)
stem( (0:length(hk0)-1), [hk0' hk64' hk128' hk192'] )
grid on
title('Lowpass filter coefficients')
xlabel('k')
ylabel('h(k)')

subplot(2,1,2)
plot( (0:L/2)/(L/2), [Hm0' Hm64' Hm128' Hm192'])
grid on
title('Single-Sided Amplitude Spectrum of Hl(m)')
xlabel('Normalized Frequency (x\pi rad/sample)')
ylabel('|Hlm_P1(f)|')
