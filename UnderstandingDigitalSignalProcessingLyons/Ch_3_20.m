close all
clear


N=16;%N=256;
n=[-3:N-4]';
xn=zeros(N,1);
xn(4)=1;
xn(5)=1;
% xn(6)=1;xn(7)=1;
y = fft(xn);                             % Compute DFT of x
m = abs(y);                               % Magnitude
y(m<1e-6) = 0;
p = unwrap(angle(y));                     % Phase
figure
subplot(2,1,1)
stem(n,xn)
title('x(n)')
subplot(2,1,2)
stem((0:N-1),m)
title('Magnitude')
