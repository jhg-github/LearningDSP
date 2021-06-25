close all
clear

b = [1 1];
a = [1 -0.5 0.125];
figure(1)
freqz(b,a,512);
figure(2)
zplane(b,a);
