class Ship:
	def __init__(self, name, x_speed = 0, y_speed = 0, x_position = 0, y_position = 0):
		self.name = name
		self.x_speed = x_speed
		self.y_speed = y_speed
		self.x_position = x_position
		self.y_position = y_position
		
	def printShip(self):
		print("Ship:      " + self.name)
		print("Position: (" + str(self.x_position) + ", " + str(self.y_position) + ")")
		print("Speed:    <" + str(self.x_speed) + ", " + str(self.y_speed) + ">")
		
	def setCourse(self, dest):
		self.x_speed = dest.x_position - self.x_position
		self.y_speed = dest.y_position - self.y_position
		
		mag = ((self.x_speed**2 + self.y_speed**2)**0.5)
		self.x_speed = self.x_speed / mag * 10
		self.y_speed = self.y_speed / mag * 10

########################################################################################		
		
class Target:
	def __init__(self, name, x_position, y_position):
		self.name = name
		self.x_position = x_position
		self.y_position = y_position
		
	def printTarget(self):
		print("Target:   " + self.name)
		print("Position: (" + str(self.x_position) + ", " + str(self.y_position) + ")")