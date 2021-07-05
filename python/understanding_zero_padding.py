import numpy as np
import matplotlib.pyplot as plt

ORIGINAL_L = 16
k = 3
N = ORIGINAL_L


n = np.arange(ORIGINAL_L)
sig = np.sin(2*np.pi*k*n/N)

sig_dft_len = (len(sig)//2)+1
sig_dft_freqs = np.arange(sig_dft_len)
sig_dft_mag = np.fft.fft(sig)       # fft
sig_dft_mag = np.abs(sig_dft_mag)   # abs to get magnitude  # no amplitude compensation
sig_dft_mag = sig_dft_mag[0:sig_dft_len]

sig_pad16 = np.pad(sig, (0,16))
sig_pad16_dft_len = (len(sig_pad16)//2)+1
sig_pad16_dft_freqs = np.arange(sig_pad16_dft_len)
sig_pad16_dft_mag = np.fft.fft(sig_pad16)       # fft
sig_pad16_dft_mag = np.abs(sig_pad16_dft_mag)   # abs to get magnitude  # no amplitude compensation
sig_pad16_dft_mag = sig_pad16_dft_mag[0:sig_pad16_dft_len]

sig_pad128 = np.pad(sig, (0,112))
sig_pad128_dft_len = (len(sig_pad128)//2)+1
sig_pad128_dft_freqs = np.arange(sig_pad128_dft_len)
sig_pad128_dft_mag = np.fft.fft(sig_pad128)       # fft
sig_pad128_dft_mag = np.abs(sig_pad128_dft_mag)   # abs to get magnitude  # no amplitude compensation
sig_pad128_dft_mag = sig_pad128_dft_mag[0:sig_pad128_dft_len]

fig, axes = plt.subplots(3, 2)
axes[0][0].plot(sig, '.-', label ='sig')
axes[0][1].plot(sig_dft_freqs, sig_dft_mag, '.-', label ='sig_dft_mag')
axes[1][0].plot(sig_pad16, '.-', label ='sig_pad16')
axes[1][1].plot(sig_pad16_dft_freqs, sig_pad16_dft_mag, '.-', label ='sig_pad16_dft_mag')
axes[2][0].plot(sig_pad128, '.-', label ='sig_pad128')
axes[2][1].plot(sig_pad128_dft_freqs, sig_pad128_dft_mag, '.-', label ='sig_pad128_dft_mag')
for ax_r in axes:
    for ax_c in ax_r:
        ax_c.legend()
        ax_c.grid()
plt.show()