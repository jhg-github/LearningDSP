close all
clear

%H
R=100
C=1
H = tf([1],[R*C 1]);
% figure(1)
% pzmap(H)
figure(2)
bode(H)

%Ha
Hii_b = [1/(R*C)];
Hii_a = [1 -exp(-1/(R*C))];
figure(3)
freqz(Hii_b,Hii_a,512);
figure(4)
zplane(Hii_b,Hii_a);

%Hb
Hbt_b = [1 1];
Hbt_a = [(1+2*R*C) (1-2*R*C)];
figure(5)
freqz(Hbt_b,Hbt_a,512);
figure(6)
zplane(Hbt_b,Hbt_a);


