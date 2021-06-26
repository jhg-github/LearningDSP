
import matplotlib.pyplot as plt
import numpy as np
from scipy import signal


def SingleSidedFFT(y, fs):
    """ len(y) must be even """
    Y = np.fft.fft(y)               # fft
    Y = np.abs(Y)                   # abs to get magnitude
    Y = Y/L                         # to scale it back
    Y = Y[:L//2+1]                  # only positive frequencies
    Y[1:] = Y[1:]*2                 # scale for single sided spectrum
    l = len(y)
    f = np.arange(0,l//2+1)*fs/l    # from 0 to Nyquist
    return f, Y


# constants
L = 20
FS_Hz = 1000
print('Frequency resolution: {}Hz'.format(FS_Hz/L) )

# signal
F0 = 50
t = np.arange(0,L)/FS_Hz
sig = 3 + np.sin(2*np.pi*F0*t)
f_sig, Y_sig = SingleSidedFFT(sig, FS_Hz)


# moving average with period T has a null in the frequency response
# at k*(1/T) with k integer
# filter 1, T=4*TS=4/FS
# - k=1, f_null=1*(1/T)=1/(4/FS)=1*FS/4
# - k=2, f_null=2*(1/T)=2/(4/FS)=2*FS/4=FS/2

# filter 1
filt1 = np.ones(4)/4
w1, H1 = signal.freqz(filt1, fs=FS_Hz, worN=501, include_nyquist=True)
H1 = abs(H1)

# filter 2
filt2 = np.ones(20)/20  # this will have a null at 50Hz for FS=1000Hz
                        # k=1, f_null=1*(1/T)=1/(20/FS)=1*FS/20=50
w2, H2 = signal.freqz(filt2, fs=FS_Hz, worN=501, include_nyquist=True)
H2 = abs(H2)

# print(f_filt, Y_filt)
# movavg_filter_fft = fft( movavg_filter, 32 )
# input_signal = scipy.array([2,1,1,1,1,1])
# filtered_signal = signal.convolve(input_signal, movavg_filter)

# plots
fig, axes = plt.subplots(2, 2)
axes[0][0].stem(t, sig, use_line_collection=True, label ='signal')
axes[0][1].stem(f_sig, Y_sig, use_line_collection=True, label ='signal FFT')
axes[1][0].stem(filt1, use_line_collection=True, label ='filter1')
axes[1][0].stem(filt2, use_line_collection=True, label ='filter2')
axes[1][1].plot(w1, H1, '.', label ='filter1 FFT')
axes[1][1].plot(w2, H2, '.', label ='filter2 FFT')
for ax_r in axes:
    for ax_c in ax_r:
        ax_c.legend()
        ax_c.grid()
plt.show()
