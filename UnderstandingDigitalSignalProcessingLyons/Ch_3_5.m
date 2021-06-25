close all

% % a
% N=8;
% n=[0:N-1]';
% xn=9*ones(N,1)
% figure
% stem(n,[xn])
% y = fft(xn);                             % Compute DFT of x
% m = abs(y);                               % Magnitude
% y(m<1e-6) = 0;
% p = unwrap(angle(y));                     % Phase
% figure
% subplot(2,1,1)
% stem(n,m)
% title('Magnitude')
% subplot(2,1,2)
% stem(n,p*180/pi)
% title('Phase')

% b
N=8;
n=[0:N-1]';
xn=zeros(N,1);
xn(1)=1
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

% c
N=8;
n=[0:N-1]';
xn=zeros(N,1);
xn(2)=1
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