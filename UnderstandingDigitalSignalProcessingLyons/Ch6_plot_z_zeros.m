close all
clear

b = [1];
p0 = 0.1;
a = [1 -p0];

subplot(2,6,[1,2]);
zplane(b,a);

subplot(2,6,[3,4]);
[h,t]=impz(b,a);
stem(t,h);

subplot(2,6,[5,6]);
[H,w]=freqz(b,a);
% plot(w/pi, H/max(H));
plot(w/pi, H);
% ylim([0 1])
xlabel('frequency in \pi units');


b = [1 0.5];
p0 = 0.8;
a = [1 -p0];

subplot(2,6,[7,8]);
zplane(b,a);

subplot(2,6,[9,10]);
[h,t]=impz(b,a);
stem(t,h);

subplot(2,6,[11,12]);
[H,w]=freqz(b,a);
plot(w/pi, H/max(H));
ylim([0 1])
xlabel('frequency in \pi units'); 
