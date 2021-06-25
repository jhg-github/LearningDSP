close all
clear

b = 1;
a = [1 -1.8*cos(pi/4) -0.81];

figure(1)
freqz(b,a,2^16,1000);

figure(2)
[h,t]=impz(b,a);
stem(t,h);