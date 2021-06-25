close all
clear

b = [1 0.1 0.2];
a = [1 -0.5 -0.3];

freqz(b,a,2^16,1000);
H_0= 20*log10(sum(b)/sum(a))
