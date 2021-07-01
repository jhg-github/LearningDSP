from numpy.random import default_rng
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal


def CalcStadistics(signal):
    calc_mean = np.mean(signal)
    calc_var = np.var(signal)
    calc_std = np.std(signal)
    return calc_mean, calc_var, calc_std

def GetStadisticsLines( length, mean, std):
    mean_line = np.ones(length)*mean
    std_pos_line = mean_line + np.ones(length)*std
    std_neg_line = mean_line - np.ones(length)*std
    return mean_line, std_pos_line, std_neg_line


ORIGINAL_L = 2000
ORIGINAL_MEAN = 10
ORIGINAL_STD = 2

rng = default_rng()

# original signal
# original = rng.standard_normal(10)
# original = rng.random(ORIGINAL_L)
original = rng.normal(ORIGINAL_MEAN,ORIGINAL_STD,size=ORIGINAL_L)
x_original = np.arange(ORIGINAL_L)

original_mean, original_var, original_std = CalcStadistics(original)
print('original_mean', original_mean)
print('original_var', original_var)
print('original_std', original_std)

mean_line, std_pos_line, std_neg_line = GetStadisticsLines( len(original), original_mean, original_std)

# averaged signal N=4
filt_avg_N4 = np.ones(4)/4
filtered_signal_avg_N4 = signal.convolve(original, filt_avg_N4, mode='full')[0:len(original)]
x_filt_avg_N4 = x_original


fig, axes = plt.subplots(1, 1)
axes.plot(x_original,original, '.-', label='original')
axes.plot(x_filt_avg_N4,filtered_signal_avg_N4, '.-', label='filtered avg N=4')
axes.plot(mean_line, 'r', label='mean = {:.2f}'.format(original_mean))
axes.plot(std_pos_line, 'r--', label='std = {:.2f}'.format(original_std))
axes.plot(std_neg_line, 'r--')
axes.legend()
plt.show()

# try to divide and avg of size N (avg+decimation) and see that std_new = std_original/sqrt(N)
