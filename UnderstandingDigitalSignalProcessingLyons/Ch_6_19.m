close all
clear

b = [1 0.3];
a = [1 0.1];
figure(1)
freqz(b,a,2^16);
figure(2)
zplane(b,a);


b = [1 0.1];
a = [1 0.3];
figure(3)
freqz(b,a,2^16);
figure(4)
zplane(b,a);


b = [1 0.5-0.5i];
a = [1 0.5];
figure(5)
freqz(b,a,2^16);
figure(6)
zplane(b,a);

