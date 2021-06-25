close all
clear

N=8;
n=[0:N-1]';
fs=8000;
ts=1/fs;
f0=1.5*fs/N;  % f(m)=m*fs/N
th=0;
xn=sin(2*pi*f0*n*ts + th);
%figure
%stem(n,[xn])

y = fft(xn);                             % Compute DFT of x
m = abs(y);                               % Magnitude
y(m<1e-6) = 0;
p = unwrap(angle(y));                     % Phase

figure
subplot(2,1,1)
stem(n,m)
title('Magnitude')
subplot(2,1,2)
stem(n,p*180/pi)
title('Phase')
