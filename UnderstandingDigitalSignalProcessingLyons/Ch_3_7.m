close all
clear

N=8;
n=[0:N-1]';
fs=4000;
ts=1/fs;
f0=1500;
th=pi/4;
xn=2*cos(2*pi*f0*n*ts + th);
% figure
% stem(n,[xn])

y = fft(xn)                             % Compute DFT of x
m = abs(y);                               % Magnitude
y(m<1e-6) = 0;
p = unwrap(angle(y));                     % Phase

figure
subplot(4,1,1)
stem(n,real(y))
title('Real')
subplot(4,1,2)
stem(n,imag(y))
title('Imaginary')
subplot(4,1,3)
stem(n,m)
title('Magnitude')
subplot(4,1,4)
stem(n,p*180/pi)
title('Phase')

