import numpy as np
from scipy import signal
import matplotlib.pyplot as plt


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
FS_Hz = 800
L = FS_Hz
print('Frequency resolution: {}Hz'.format(FS_Hz/L) )

# square signal
F0 = 10
t = np.linspace(0, 1, FS_Hz, endpoint=False)
sig = signal.square(2 * np.pi * F0 * t)
f_sig, Y_sig = SingleSidedFFT(sig, FS_Hz)
Y_sig_dB = 20 * np.log10(Y_sig)

# plots
fig, axes = plt.subplots(3, 2)
axes[0][0].plot(t, sig, '.', label ='signal')
axes[0][1].plot(f_sig, Y_sig, label ='signal FFT')
# axes[0][1].plot(f_sig, Y_sig_dB, label ='signal FFT dB')
# axes[1][0].stem(filt1, use_line_collection=True, label ='filter1')
# axes[1][0].stem(filt2, use_line_collection=True, label ='filter2')
# axes[1][1].plot(w1, H1, '.', label ='filter1 FFT')
# axes[1][1].plot(w2, H2, '.', label ='filter2 FFT')
# axes[2][0].plot(t, filtered_signal1, '.', label ='signal filtered 1')
# axes[2][0].plot(t, filtered_signal2, '.', label ='signal filtered 2')
# axes[2][1].plot(f_sig_filt1, Y_sig_filt1, '.', label ='signal filtered 1 FFT')
# axes[2][1].plot(f_sig_filt2, Y_sig_filt2, '.', label ='signal filtered 2 FFT')
for ax_r in axes:
    for ax_c in ax_r:
        ax_c.legend()
        ax_c.grid()
plt.show()