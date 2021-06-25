close all

N=8;
n=[0:N-1]';
fs=8000;
ts=1/fs;
fa=1000;
tha=0;
fb=2000;
thb=3*pi/4;
xin=sin(2*pi*fa*n*ts + tha) + 0.5*sin(2*pi*fb*n*ts + thb);
stem(n,[xin])

y = fft(xin);                             % Compute DFT of x
m = abs(y);                               % Magnitude
y(m<1e-6) = 0;
p = unwrap(angle(y));                     % Phase

subplot(2,1,1)
stem(n,m)
title('Magnitude')
subplot(2,1,2)
stem(n,p*180/pi)
title('Phase')
