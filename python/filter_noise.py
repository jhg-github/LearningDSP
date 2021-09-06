import numpy as np
from numpy.lib.function_base import average
from scipy import signal
import matplotlib.pyplot as plt
import CommonFunctions


# constants
FS_Hz = 1000
L = FS_Hz
AVG_N = 100

# noise signal
noiseSig = np.random.normal(size=L)
avg = np.zeros(L//2+1)
for i in range(AVG_N):
    noiseSig_f, noiseSig_Y = CommonFunctions.SingleSidedFFT(noiseSig, FS_Hz)
    avg = avg + noiseSig_Y
noiseSig_Y = avg / AVG_N
noiseSig_Y_dB = 20 * np.log10(noiseSig_Y)

# comb filter
comb1=np.zeros(L)
comb1[0] = 1
comb1[50] = -1
comb1 = comb1 / 2

# signal filtered comb1
sig_filt1 = signal.convolve(noiseSig_Y, comb1)
sig_filt1 = sig_filt1[0:L]
f_sig_filt1, Y_sig_filt1 = CommonFunctions.SingleSidedFFT(sig_filt1, FS_Hz)
Y_sig_filt1_dB = 20 * np.log10(Y_sig_filt1)

# signal filtered avg
sig_filt2 = signal.convolve(noiseSig_Y, np.ones(50)/50 )
sig_filt2 = sig_filt2[0:L]
f_sig_filt2, Y_sig_filt2 = CommonFunctions.SingleSidedFFT(sig_filt2, FS_Hz)
Y_sig_filt2_dB = 20 * np.log10(Y_sig_filt2)


# plot
plt.figure()
# plt.plot(noiseSig_f, noiseSig_Y, '-', label ='noise FFT')
plt.plot(noiseSig_f, noiseSig_Y_dB, '-', label ='noise dB FFT')
plt.plot(f_sig_filt1, Y_sig_filt1_dB, '-', label ='filt1 dB FFT')
plt.plot(f_sig_filt2, Y_sig_filt2_dB, '-', label ='filt2 dB FFT')
plt.legend()
plt.grid()
plt.show()