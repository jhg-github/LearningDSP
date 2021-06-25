close all
clear

%-- common --
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1000;             % Length of signal
t = (0:L-1)*T;        % Time vector
f1 = 20;
fpass = 240;
fstop = 250;
firOrder = 16;
ntaps = firOrder + 1;

%-- signal --
xn = sin(2*pi*f1*t);

%-- signal fft --
f = Fs*(0:(L/2))/L;
Xm = fft(xn);
P2 = abs(Xm/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%-- lowpass filter --
hl_f =   [0 (fpass/Fs) (fstop/Fs) 1];
hl_mag = [1 1          0          0];
hl_k = fir2(firOrder,hl_f,hl_mag);

%-- lowpass filter fft --
Hlm = fft( [hl_k zeros(1, L - length(hl_k))] );
Hlm_P2 = abs(Hlm/1);    % don't divide because filter coefficients are already scaled ???
Hlm_P1 = Hlm_P2(1:L/2+1);
Hlm_P1(2:end-1) = Hlm_P1(2:end-1);

%-- lowpass filtered signal --
xln = filter(hl_k,1,xn);

%-- lowpass filtered signal fft --
Xlm = fft(xln);
Xlm_P2 = abs(Xlm/L);
Xlm_P1 = Xlm_P2(1:L/2+1);
Xlm_P1(2:end-1) = 2*Xlm_P1(2:end-1);

%-- lowpass filter half band --
hl_hb = firhalfband(firOrder,fstop/Fs);

%-- lowpass filter half band fft --
Hlhbm = fft( [hl_hb zeros(1, L - length(hl_hb))] );
Hlhbm_P2 = abs(Hlhbm/1);    % don't divide because filter coefficients are already scaled ???
Hlhbm_P1 = Hlhbm_P2(1:L/2+1);
Hlhbm_P1(2:end-1) = Hlhbm_P1(2:end-1);

%-- lowpass half band filtered signal --
xlhbn = filter(hl_hb,1,xn);

%-- lowpass filtered signal fft --
Xlhbm = fft(xlhbn);
Xlhbm_P2 = abs(Xlhbm/L);
Xlhbm_P1 = Xlhbm_P2(1:L/2+1);
Xlhbm_P1(2:end-1) = 2*Xlhbm_P1(2:end-1);

%-- plots --
figure
subplot(5,2,1)
plot(t, xn)
grid on
title('Signal')
xlabel('t (s)')
ylabel('x(n)')

subplot(5,2,2)
plot(f,P1) 
grid on
title('Single-Sided Amplitude Spectrum of Signal')
xlabel('f (Hz)')
ylabel('|P1(f)|')

subplot(5,2,3)
stem((0:firOrder), hl_k)
grid on
title('Lowpass filter coefficients')
xlabel('k')
ylabel('hl(k)')

subplot(5,2,4)
plot(f,Hlm_P1) 
grid on
title('Single-Sided Amplitude Spectrum of Hl(m)')
xlabel('f (Hz)')
ylabel('|Hlm_P1(f)|')

subplot(5,2,5)
stem(t(1:4*ntaps)', [xn(1:4*ntaps)', xln(1:4*ntaps)'] )
grid on
title('Lowpass Filtered Signal')
xlabel('t (s)')
ylabel('xl(n)')

subplot(5,2,6)
plot(f,Xlm_P1) 
grid on
title('Single-Sided Amplitude Spectrum of Lowpass Filtered Signal')
xlabel('f (Hz)')
ylabel('|Xlm_P1(f)|')

subplot(5,2,7)
stem((0:firOrder), hl_hb)
grid on
title('Lowpass filter half band coefficients')
xlabel('k')
ylabel('hl_hb(k)')

subplot(5,2,8)
plot(f,Hlhbm_P1) 
grid on
title('Single-Sided Amplitude Spectrum of Hl half band(m)')
xlabel('f (Hz)')
ylabel('|Hlhbm_P1(f)|')

subplot(5,2,9)
stem(t(1:4*ntaps)', [xn(1:4*ntaps)', xlhbn(1:4*ntaps)'] )
grid on
title('Lowpass Half band Filtered Signal')
xlabel('t (s)')
ylabel('xlhbn(n)')

subplot(5,2,10)
plot(f,Xlhbm_P1) 
grid on
title('Single-Sided Amplitude Spectrum of Lowpass Half band Filtered Signal')
xlabel('f (Hz)')
ylabel('|Xlhbm_P1(f)|')