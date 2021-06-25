close all
clear

%-- signal --
xn = csvread('/home/javi/Documents/crypto/binance/closes.csv');
%xn=xn(1:end-1); %Warning: Integer operands are required for colon operator when used as index 
%xn=xn(1:end-1); 

%-- common --
T = 1;%60*60;             % Sampling period  = 1 hour
Fs = 1/T;            % Sampling frequency 
L = length(xn);             % Length of signal
t = (0:L-1)*T;        % Time vector
fc = (Fs/32)/Fs;
nfir = 32;

%-- signal fft --
f = Fs*(0:(L/2))/L;
Xm = fft(xn);
P2 = 20*log10(abs(Xm/L));
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%-- lowpass filter --
hl_k = fir1(nfir,fc);
csvwrite('/home/javi/Documents/crypto/binance/filter_coef.csv',hl_k)

%-- lowpass filter fft --
Hlm = fft( [hl_k zeros(1, L - length(hl_k))] );
Hlm_P2 = 20*log10(abs(Hlm/1));    % don't divide because filter coefficients are already scaled ???
Hlm_P1 = Hlm_P2(1:L/2+1);
Hlm_P1(2:end-1) = Hlm_P1(2:end-1);

%-- lowpass filtered signal --
xln = filter(hl_k,1,xn);

%-- lowpass filtered signal fft --
Xlm = fft(xln);
Xlm_P2 = 20*log10(abs(Xlm/L));
Xlm_P1 = Xlm_P2(1:L/2+1);
Xlm_P1(2:end-1) = 2*Xlm_P1(2:end-1);



%-- avg filter --
ha_k= 1/(nfir+1)*ones(nfir+1,1)';

%-- avg filter fft --
Ham = fft( [ha_k zeros(1, L - length(ha_k))] );
Ham_P2 = 20*log10(abs(Ham/1));    % don't divide because filter coefficients are already scaled ???
Ham_P1 = Ham_P2(1:L/2+1);
Ham_P1(2:end-1) = Ham_P1(2:end-1);

%-- avg filtered signal --
xan = filter(ha_k,1,xn);


%-- plots --
figure
subplot(2,2,1)
plot(t, xn)
grid on
title('Signal')
xlabel('t (s)')
ylabel('x(n)')

subplot(2,2,2)
% plot(f,P1) 
plot(f,P1,f,Hlm_P1,f,Ham_P1) 
grid on
title('Single-Sided Amplitude Spectrum of Signal')
xlabel('f (Hz)')
ylabel('|P1(f)|')

subplot(2,2,3)
% plot(t, xln)
plot(t, xn, t, xln, t, xan)
grid on
title('Lowpass Filtered Signal')
xlabel('t (s)')
ylabel('xl(n)')

subplot(2,2,4)
plot(f,Xlm_P1) 
grid on
title('Single-Sided Amplitude Spectrum of Lowpass Filtered Signal')
xlabel('f (Hz)')
ylabel('|Xlm_P1(f)|')

figure
plot(t, xn, t, xln , t, 1.01*xln)
% plot(t, xn, t, xln , t, xan, t, 1.01*xln, t, 1.01*xan)
% plot(t, xn, t, 1.01*xln)
grid on
