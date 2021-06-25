close all
clear

%H
H = tf([5],[1 -0.8 0]);
figure(1)
w = logspace(0,log10(2*pi*500),1024);   % bode up to 500HZ
bode(H,w)

%Hz
fs=1000
a=2*fs
Hz_b = [5 10 5];
Hz_a = [(a^2-0.8*a) (-2*a^2) (a^2+0.8*a)];
figure(2)
freqz(Hz_b,Hz_a,2048);



