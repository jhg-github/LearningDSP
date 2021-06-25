close all
clear

N=8;
n=[0:N-1]';
fs=4000;
ts=1/fs;
f0=fs/2;
th=pi/4;%0;%pi/2;
xn=sin(2*pi*f0*n*ts + th);
figure
stem(n,[xn])

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
m(N/2+1)
