close all
clear

b = 1;
p = -1;
a = [1 -p];

figure(1)
freqz(b,a,2^16,1000);

figure(2)
[h,t]=impz(b,a);
stem(t,h);