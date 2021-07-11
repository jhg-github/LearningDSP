
import matplotlib.pyplot as plt
from numpy.lib.scimath import log10
from scipy import signal
import numpy as np
from numpy.random import default_rng



def SingleSidedFFT(y, fs):
    """ len(y) must be even """
    l = len(y)
    Y = np.fft.fft(y)               # fft
    Y = np.abs(Y)                   # abs to get magnitude
    Y = Y/l                         # to scale it back
    Y = Y[:l//2+1]                  # only positive frequencies
    Y[1:] = Y[1:]*2                 # scale for single sided spectrum
    l = len(y)
    f = np.arange(0,l//2+1)*fs/l    # from 0 to Nyquist
    return f, Y


# constants
L = 1000
FS_Hz = 1000
print('Frequency resolution: {}Hz'.format(FS_Hz/L) )

# signal
DC_V = 1
NOISE_VAR_V = 0.001
F0 = 50
F0_V = 0.01
t = np.arange(0,L)/FS_Hz
rng = default_rng()
sig = DC_V + rng.normal(0,NOISE_VAR_V,size=L) + F0_V * np.sin(2*np.pi*F0*t)
f_sig, Y_sig = SingleSidedFFT(sig, FS_Hz)
Y_sig_db = 20*log10(Y_sig/max(Y_sig))


# moving average with period T has a null in the frequency response
# at k*(1/T) with k integer
# filter 1, T=4*TS=4/FS
# - k=1, f_null=1*(1/T)=1/(4/FS)=1*FS/4
# - k=2, f_null=2*(1/T)=2/(4/FS)=2*FS/4=FS/2

# filter 1
N = 50
FC_Hz = 14
filt1 = signal.firwin(N, FC_Hz/(FS_Hz/2))
w1, H1 = signal.freqz(filt1, fs=FS_Hz, worN=int(FS_Hz/2))
H1 = abs(H1)
H1_dB = 20*log10(H1/max(H1))
for h in filt1:
    print('{:.20f} - {}'.format(h, hex(int(h*2**32)) ))

# # filter 2
# filt2 = np.ones(20)/20  # this will have a null at 50Hz for FS=1000Hz
#                         # k=1, f_null=1*(1/T)=1/(20/FS)=1*FS/20=50
# w2, H2 = signal.freqz(filt2, fs=FS_Hz, worN=501, include_nyquist=True)
# H2 = abs(H2)

# signal filtered
filtered_signal1 = signal.convolve(sig, filt1)
filtered_signal1 = filtered_signal1[0:L]
f_sig_filt1, Y_sig_filt1 = SingleSidedFFT(filtered_signal1, FS_Hz)
Y_sig_filt1_db = 20*log10(Y_sig_filt1/max(Y_sig_filt1))

# filtered_signal2 = signal.convolve(sig, filt2)
# filtered_signal2 = filtered_signal2[0:L]
# f_sig_filt2, Y_sig_filt2 = SingleSidedFFT(filtered_signal2, FS_Hz)


# plots
fig, axes = plt.subplots(3, 2)

axes[0][0].plot(t, sig, label ='signal')
# axes[0][1].plot(f_sig, Y_sig, label ='signal FFT')
axes[0][1].plot(f_sig, Y_sig_db, label ='signal FFT dB')

axes[1][0].plot(filt1, label ='filt1')
# axes[1][1].plot(w1, H1, label ='filt1 FFT')
axes[1][1].plot(w1, H1_dB, '.', label ='filt1 FFT dB')

axes[2][0].plot(t, filtered_signal1, '.', label ='signal filtered 1')
# axes[2][1].plot(f_sig_filt1, Y_sig_filt1, '.', label ='signal filtered 1 FFT')
axes[2][1].plot(f_sig_filt1, Y_sig_filt1_db, '.', label ='signal filtered 1 FFT dB')

for ax_r in axes:
    for ax_c in ax_r:
        ax_c.legend()
        ax_c.grid()
plt.show()
