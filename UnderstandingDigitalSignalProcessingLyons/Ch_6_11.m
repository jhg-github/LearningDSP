close all
clear

wc = 2*pi/15;
R = 0.9;
b = [1 -2*cos(wc) 1];
a = [1 -2*R*cos(wc) R^2];

freqz(b,a,256,1800);