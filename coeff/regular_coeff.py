#!/usr/bin/env python3
import math

N, Q = 16, 15                    # 16‑point, Q1.15
def q15(x):                      # → 16‑bit hex, saturated
    v = int(round(x * (1 << Q)))
    return f"{(v + (1<<16)) & 0xFFFF:04X}"

with open("coeff_rom.mem", "w") as f:
    for k in range(N):
        for n in range(N):
            c = math.cos(math.pi/N * (n + 0.5) * k)
            f.write(q15(c) + (" " if n != N-1 else ""))
        f.write("\n")
print("coeff_rom.mem written.")
