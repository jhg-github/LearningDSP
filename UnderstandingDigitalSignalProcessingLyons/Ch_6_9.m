close all
clear

%a
H1b = [1 0 0 1];
H1a = [1 -1];

subplot(2,2,1);
zplane(H1b,H1a);

subplot(2,2,2);
[h1,t]=impz(H1b,H1a);
stem(t,h1);

%b
H2b = [1 0 0 -1];
H2a = [1 -1];

subplot(2,2,3);
zplane(H2b,H2a);

subplot(2,2,4);
[h2,t]=impz(H2b,H2a);
stem(t,h2);