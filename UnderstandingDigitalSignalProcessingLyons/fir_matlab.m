% https://se.mathworks.com/help/signal/ug/fir-filter-design.html
% https://se.mathworks.com/help/signal/ref/fir2.html

atten_db = 60
atten_mag = 10^(-atten_db/20)
fs = 1000
fpass = 400
fstop = 420
nfir = atten_db / ( 22 * ( (fstop/fs) - (fpass/fs) ))
nfir = floor( nfir / 2) * 2 + 2

f =  [0 (fpass/fs) (fstop/fs) 1];
mh = [1 1          atten_mag  atten_mag];
bh = fir2(nfir,f,mh);
figure(1)
freqz(bh,1);

f =  [0 (fpass/fs) (fstop/fs) 1];
mh = [1 1          0          0];
bh = fir2(nfir,f,mh);
figure(2)
freqz(bh,1);

f =  [0 (fpass/fs) (fstop/fs) 1];         % Frequency band edges
mh = [1 1          atten_mag  atten_mag];  % Amplitudes
bh = firpm(nfir,f,mh);
figure(3)
freqz(bh,1);

f =  [0 (fpass/fs) (fstop/fs) 1];         % Frequency band edges
mh = [1 1          atten_mag  atten_mag];  % Amplitudes
bh = firls(nfir,f,mh);
figure(4)
freqz(bh,1);