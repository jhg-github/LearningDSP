close all
clear

%-- signal --
xn = [0 0 0.5 1 1];

%-- filter --
hk = [.75 1 .75];

%-- filtered signal --
% yn = filter(hk,1,xn);
% convolution length: L = P + Q - 1
% L convolution length
% P hk length
% Q xn length
% so xn has to be padded with zeros to get the complete convolution
yn = filter( hk, 1, [xn zeros(1, length(xn)+length(hk)-1-length(xn))]);

%-- filtered signal convolution --
ynconv = conv(hk,xn);

%-- plots --
figure
subplot(4,1,1)
stem((0:length(xn)-1),xn)
grid on
title('Signal')
xlabel('n')
ylabel('x(n)')

subplot(4,1,2)
stem((0:length(hk)-1),hk) 
grid on
title('Filter coefficients')
xlabel('k')
ylabel('h(k)')

subplot(4,1,3)
stem((0:length(yn)-1),yn)
grid on
title('Filtered signal')
xlabel('n')
ylabel('y(n)')

subplot(4,1,4)
stem((0:length(ynconv)-1),ynconv)
grid on
title('Filtered signal with convolution')
xlabel('n')
ylabel('y(n)')

