close all
clear

N=16;
n=[0:N-1]';
X2m=zeros(N,1);
X2m(3)=4;
X2m(15)=4;
xn=ifft(X2m);
stem(n, xn)
% y = fft(xn);                             % Compute DFT of x
% m = abs(y);                               % Magnitude
% y(m<1e-6) = 0;
% p = unwrap(angle(y));                     % Phase
% figure
% subplot(2,1,1)
% stem(n,xn)
% title('x(n)')
% subplot(2,1,2)
% stem(n(1:N/2+1),m(1:N/2+1))
% title('Magnitude')
