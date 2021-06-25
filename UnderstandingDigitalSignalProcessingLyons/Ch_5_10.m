close all
clear

%-- signal --
xn = [0 2 4 6 8 4 2 0];

%-- filter --
hk = [.5 .5];

%-- filtered signal convolution --
yn = conv(hk,xn);

%-- mixing signal and filtered signal 
% yinterpolated = reshape([ [xn 0]; yn], [], 1)';
yinterpolated = reshape([ yn; [xn 0] ], [], 1)';

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
stem((0:length(yinterpolated)-1),yinterpolated)
grid on
title('Interpolated signal')
xlabel('n')
ylabel('yinterp(n)')

