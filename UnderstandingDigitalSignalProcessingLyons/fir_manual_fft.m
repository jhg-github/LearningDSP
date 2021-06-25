% https://se.mathworks.com/help/signal/ug/fir-filter-design.html
% https://se.mathworks.com/help/signal/ref/fir2.html

close all
clear


atten_db = 60
atten_mag = 10^(-atten_db/20)
fs = 1000
fpass = 400
fstop = 420
nfir = atten_db / ( 22 * ( (fstop/fs) - (fpass/fs) ))
nfir = floor( nfir / 2) * 2 + 2

f =  [0 (fpass/fs) (fstop/fs) 1];
mh = [1 1          atten_mag  atten_mag];
% mh = [atten_mag  atten_mag 1 1];
h = fir2(nfir,f,mh);
figure(1)
freqz(h,1);

N = 1024
Hm = fft( [h zeros(1, N - length(h))] );                             % Compute DFT of x
Hm = abs(Hm);  
Hm_db = 20*log10(Hm);

figure
subplot(3,1,1)
stem(h)
title('h(k)')
subplot(3,1,2)
% plot( (0:N/2)*2/N, Hm(1:N/2+1) );
plot( (0:N/2)*2/N, Hm_db(1:N/2+1) );
grid on
title('H(m) db')