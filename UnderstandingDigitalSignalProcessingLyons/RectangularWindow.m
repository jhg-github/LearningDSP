close all
clear

N=256;

N_ONES=4
n=[0:N-1]';
xna=zeros(N,1);
xna(1:N_ONES)=1/N_ONES;
y = fft(xna);                             % Compute DFT of x
ma = abs(y);                               % Magnitude

N_ONES=32
n=[0:N-1]';
xnb=zeros(N,1);
xnb(1:N_ONES)=1/N_ONES;
y = fft(xnb);                             % Compute DFT of x
mb = abs(y);                               % Magnitude

figure
subplot(3,1,1)
stem(n,[xna,xnb])
title('x(n)')
subplot(3,1,2)
plot((0:N/2)/N,[ma(1:N/2+1),mb(1:N/2+1)]);
title('Magnitude')
subplot(3,1,3)
ma=20*log10(ma);
mb=20*log10(mb);
plot((0:N/2)/N, [ma(1:N/2+1), mb(1:N/2+1)]);
title('Magnitude dB')