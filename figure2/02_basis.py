

# %%

import numpy as np
import cfl
from matplotlib import pyplot as plt

sig=cfl.readcfl("sig").real
t=np.linspace(0, 4.0851, 1530)
plt.figure(figsize=(8,3.5))
plt.plot(t,sig)
plt.xticks([0,1,2,3,4])
plt.yticks([-1,-0.5,0,0.5,1])
plt.grid()
plt.xlabel("Time [s]")
plt.ylabel("Signal M(t)/M0")
plt.tight_layout()
plt.savefig("signal.png")
plt.close()

sig=cfl.readcfl("basis").real
t=np.linspace(0, 4.0851, 1530)
plt.figure(figsize=(8,3.5))
plt.plot(t,sig[:,0], label="1st basis function")
plt.plot(t,sig[:,1], label="2nd basis function")
plt.plot(t,sig[:,2], label="3rd basis function")
plt.plot(t,sig[:,3], label="4th basis function")
plt.legend()
plt.xticks([0,1,2,3,4])
plt.yticks([-0.1,-0.05,0,0.05,0.1])
plt.grid()
plt.xlabel("Time [s]")
plt.ylabel("Signal [a.U.]")
plt.tight_layout()
plt.savefig("basis.png")


sig=cfl.readcfl("basis").real
t=np.linspace(0, 4.0851, 1530)
plt.figure(figsize=(8,3.5))
plt.plot(t,((t%1.1)<0.55)* sig[:,0], label="1st basis function")
plt.plot(t,((t%1.1)<0.55)* sig[:,1], label="2nd basis function")
plt.plot(t,((t%1.1)<0.55)* sig[:,2], label="3rd basis function")
plt.plot(t,((t%1.1)<0.55)* sig[:,3], label="4th basis function")
plt.legend()
plt.xticks([0,1,2,3,4])
plt.yticks([-0.1,-0.05,0,0.05,0.1])
plt.grid()
plt.xlabel("Time [s]")
plt.ylabel("Signal [a.U.]")
plt.tight_layout()
plt.savefig("sub_basis.png")



# %%
