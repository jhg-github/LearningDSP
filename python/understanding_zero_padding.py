import numpy as np
import matplotlib.pyplot as plt

ORIGINAL_L = 16
k = 3
N = 16
n = np.arange(ORIGINAL_L)
sig = np.sin(2*np.pi*k*n/N)

fig, axes = plt.subplots(3, 2)
axes[0][0].plot(n, sig, '.', label ='signal')
# axes[0][1].stem(f_sig, Y_sig, use_line_collection=True, label ='signal FFT')
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