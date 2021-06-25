close all
clear

%-- common --
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1000;             % Length of signal
t = (0:L-1)*T;        % Time vector
f1 = 20;
f2 = 100;
fpass = 80;
fstop = 100;
nfir = 64;

%-- signal --
xn = sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t);

%-- signal fft --
f = Fs*(0:(L/2))/L;
Xm = fft(xn);
P2 = abs(Xm/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%-- lowpass filter --
hl_f =   [0 (fpass/Fs) (fstop/Fs) 1];
hl_mag = [1 1          0          0];
hl_k = fir2(nfir,hl_f,hl_mag);

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

%-- highpass filter --
hh_f =   [0 (fpass/Fs) (fstop/Fs) 1];
hh_mag = [0 0          1          1];
hh_k = fir2(nfir,hh_f,hh_mag);

%-- highpass filter fft --
Hhm = fft( [hh_k zeros(1, L - length(hh_k))] );
Hhm_P2 = abs(Hhm/1);    % don't divide because filter coefficients are already scaled ???
Hhm_P1 = Hhm_P2(1:L/2+1);
Hhm_P1(2:end-1) = Hhm_P1(2:end-1);

%-- highpass filtered signal --
xhn = filter(hh_k,1,xn);

%-- highpass filtered signal fft --
Xhm = fft(xhn);
Xhm_P2 = abs(Xhm/L);
Xhm_P1 = Xhm_P2(1:L/2+1);
Xhm_P1(2:end-1) = 2*Xhm_P1(2:end-1);

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
stem((0:nfir), hl_k)
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
plot(t, xln)
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
stem((0:nfir), hh_k)
grid on
title('Highpass filter coefficients')
xlabel('k')
ylabel('hh(k)')

subplot(5,2,8)
plot(f,Hhm_P1) 
grid on
title('Single-Sided Amplitude Spectrum of Hh(m)')
xlabel('f (Hz)')
ylabel('|Hhm_P1(f)|')

subplot(5,2,9)
plot(t, xhn)
grid on
title('Highpass Filtered Signal')
xlabel('t (s)')
ylabel('xh(n)')

subplot(5,2,10)
plot(f,Xhm_P1) 
grid on
title('Single-Sided Amplitude Spectrum of Highpass Filtered Signal')
xlabel('f (Hz)')
ylabel('|Xhm_P1(f)|')
