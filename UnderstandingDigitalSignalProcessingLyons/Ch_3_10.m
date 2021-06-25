close all
clear

N=8;
n=[0:N-1]';
a=2;
xn=a.^n

y = fft(xn)                             % Compute DFT of x
m = abs(y);                               % Magnitude
y(m<1e-6) = 0;
p = unwrap(angle(y));                     % Phase

y(2)
r=a*exp(-i*2*pi*2/N)

Xm2=(1 - r^N )/(1 - r)