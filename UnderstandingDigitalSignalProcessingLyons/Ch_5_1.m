close all
clear

N=1024;

n=[0:N-1]';
fs=1000;
ts=1/fs;
f0=800;
xn=cos(2*pi*f0*n*ts);
y = fft(xn);                             % Compute DFT of x
m = abs(y)/(N/2);                               % Magnitude

figure
subplot(3,1,1)
stem(n,xn)
title('x(n)')
subplot(3,1,2)
plot((0:N/2)/N,m(1:N/2+1));
title('Magnitude')
subplot(3,1,3)
mdb=20*log10(m);
plot((0:N/2)/N, mdb(1:N/2+1));
title('Magnitude dB')