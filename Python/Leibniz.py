#!/usr/bin/python3

pi = 0.0

for i in range(0, 10000000):
	pi += 4 * ((-1.0)**i/(2.0*i + 1.0))

print("pi is ", pi)