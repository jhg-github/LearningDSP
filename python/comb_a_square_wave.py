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

def SquareSignal(f, fs, number_periods):
    period_len = fs // f
    high = np.ones(period_len // 2)
    low = np.ones(period_len // 2) * -1
    # square = np.concatenate((high,low))
    square = np.empty(0)
    for i in range(number_periods):
        square = np.concatenate((square,high))
        square = np.concatenate((square,low))
    t = np.arange(number_periods * period_len) / fs
    return t, square

def AddGaps(signal, gap_period, gap_len):
    i = 0
    while i < len(signal):
        signal[i:i+gap_len] = 0
        i += gap_period
    return signal


# constants
FS_Hz = 800
L = FS_Hz
print('Frequency resolution: {}Hz'.format(FS_Hz/L) )

# ideal square signal
F0 = 10
PERIODS = 10
t, sig_ideal = SquareSignal(F0, FS_Hz, PERIODS)
f_sig_ideal, Y_sig_ideal = SingleSidedFFT(sig_ideal, FS_Hz)
Y_sig_ideal_dB = 20 * np.log10(Y_sig_ideal)

# real square signal
offset = -4
gain = 10
sig_real = sig_ideal + (gain*t) + offset
sig_real = AddGaps(sig_real, FS_Hz // F0 // 2, 8)
f_sig_real, Y_sig_real = SingleSidedFFT(sig_real, FS_Hz)

# comb filter
comb1=np.zeros(L)
comb1[0] = 1
comb1[40] = -1
f_comb1, Y_comb1 = SingleSidedFFT(comb1, FS_Hz)

# signal filtered comb1
sig_filt1 = signal.convolve(sig_real, comb1) / 2
sig_filt1 = sig_filt1[0:L]
f_sig_filt1, Y_sig_filt1 = SingleSidedFFT(sig_filt1, FS_Hz)

# signal filtered comb2
sig_filt2 = signal.convolve(sig_filt1, comb1) / 2
sig_filt2 = sig_filt2[0:L]
f_sig_filt2, Y_sig_filt2 = SingleSidedFFT(sig_filt2, FS_Hz)

# signal filtered comb3
sig_filt3 = signal.convolve(sig_filt2, comb1) / 2
sig_filt3 = sig_filt3[0:L]
f_sig_filt3, Y_sig_filt3 = SingleSidedFFT(sig_filt3, FS_Hz)

# plots
fig, axes = plt.subplots(4, 3)


axes[0][0].plot(t, sig_ideal, '.-', label ='ideal')
axes[0][0].plot(t, sig_real, '.-', label ='real')

axes[0][2].plot(f_sig_ideal, Y_sig_ideal, label ='ideal FFT')
axes[0][2].plot(f_sig_real, Y_sig_real, label ='real FFT')

axes[1][0].plot(t, sig_filt1, '.-', label ='filt1')
axes[1][0].plot(t, sig_filt2, '.-', label ='filt2')
axes[1][0].plot(t, sig_filt3, '.-', label ='filt3')

axes[1][1].plot(f_comb1, Y_comb1, label ='comb1 FFT')

axes[1][2].plot(f_sig_ideal, Y_sig_ideal, label ='ideal FFT')
axes[1][2].plot(f_sig_filt1, Y_sig_filt1, label ='filt1 FFT')
axes[1][2].plot(f_sig_filt2, Y_sig_filt2, label ='filt2 FFT')
axes[1][2].plot(f_sig_filt3, Y_sig_filt3, label ='filt3 FFT')


for ax_r in axes:
    for ax_c in ax_r:
        ax_c.legend()
        ax_c.grid()
plt.subplots_adjust(wspace=0.15, hspace=0.15)
# plt.tight_layout()
plt.show()