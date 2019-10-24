# The goal of this small program is to create a ship navigation
# simulation. The ship should have coordinates, and it should be
# able to figure out what to do if an obstacle such as an island
# or another ship comes into it's path.

from classdef import *
if __name__ == '__main__':
	myShip = Ship("USS ME", 0, 0, 0, 0)
	
	print("Current state of " + myShip.name + ":")
	myShip.printShip()
	print()
	
	myTarget = Target("Bahamas", 23, 77)
	print("Destination:")
	myTarget.printTarget()
	print()
	
	myShip.setCourse(myTarget)
	print("Current state of " + myShip.name + ":")
	myShip.printShip()
	print()
	