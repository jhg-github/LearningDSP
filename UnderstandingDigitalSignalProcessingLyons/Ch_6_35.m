close all
clear

%Ha
Ha_b = [2];
Ha_a = [1 -1];
figure(1)
freqz(Ha_b,Ha_a,512);
figure(2)
zplane(Ha_b,Ha_a);

%Hb
Hb_b = [1 1];
Hb_a = [1 -1];
figure(3)
freqz(Hb_b,Hb_a,512);
figure(4)
zplane(Hb_b,Hb_a);

%H
H = tf([1],[1 0]);
pzmap(H)
bode(H)
fs_Hz=0.5;
fs_2_Hz=fs_Hz/2;
fs_2_rad=fs_2_Hz*2*pi;
w = fs_2_rad;
s = j*w;
evalfr(H,s)
freqresp(H,w)
