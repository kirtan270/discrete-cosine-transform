# gen_coeff_scaled.py
import math, pathlib
N, Q = 16, 15               # 16‑point, Q1.15

def q15(x):
    v = int(round(x * (1 << Q)))
    return f"{(v + (1<<16)) & 0xFFFF:04X}"

alpha0  = math.sqrt(2) / N   # ≈0.088388
alphak  = 2.0 / N            # 0.125

with open("coeff_scaled.mem", "w") as f:
    for k in range(N):
        a = alpha0 if k == 0 else alphak
        line = " ".join(q15(a * math.cos(math.pi/N * (n+0.5) * k))
                        for n in range(N))
        f.write(line + "\n")
print("coeff_scaled.mem written.")
