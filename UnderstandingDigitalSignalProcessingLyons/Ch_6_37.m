close all
clear

%H
w0=62.832
H = tf([1 0],[1 w0]);
figure(1)
bode(H)

%Hz
fs=100
a=2*fs
Hz_b = [ (a/(a+w0)) (-a/(a+w0))];
Hz_a = [1 ((-a+w0)/(a+w0))];
figure(2)
freqz(Hz_b,Hz_a,512);



