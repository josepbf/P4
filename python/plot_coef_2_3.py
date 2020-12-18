import matplotlib.pyplot as plt
import numpy as np

lp_2_3 = np.loadtxt('python/lp_2_3.txt')
lpcc_2_3 = np.loadtxt('python/lpcc_2_3.txt')
mfcc_2_3 = np.loadtxt('python/mfcc_2_3.txt')

plt.figure()

plt.subplot(311)
plt.plot(lp_2_3[:,0], lp_2_3[:,1],'r,')
plt.title('LP')
plt.grid()

plt.subplot(312)
plt.plot(lpcc_2_3[:,0], lpcc_2_3[:,1],'r,')
plt.title('LPCC')
plt.grid()

plt.subplot(313)
plt.plot(mfcc_2_3[:,0], mfcc_2_3[:,1],'r,')
plt.title('MFCC')
plt.grid()

plt.subplots_adjust(top=0.92, bottom=0.08, left=0.10, right=0.95, hspace=0.45,
                    wspace=0.35)

plt.show()