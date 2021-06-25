close all
clear

b = [2];
a = [1 exp(-0.88)];
figure(1)
freqz(b,a,512);
figure(2)
zplane(b,a);
