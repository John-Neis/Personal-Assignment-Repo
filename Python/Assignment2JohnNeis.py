import random
("\
def genRandom():
	return random.randrange(1, 7)

def dispMainMenu(plBalance):
	print("Player balance: $%.2f" % (plBalance))
	print("What would you like to do? (Choose the number of your action)")
	printt1: Place a bet")
	print("\t2: Exit game")

def showDice(roll1, roll2):
	dice = [
		"# # # # #",
		["#       #", "#   O   #", "#       #"],
		["# O     #", "#       #", "#     O #"],
		["# O     #", "#   O   #", "#     O #"],
		["# O   O #", "#       #", "# O   O #"],
		["# O   O #", "#   O   #", "# O   O #"],
		["# O   O #", "# O   O #", "# O   O #"]
	]
	
	print(dice[0] + "\t" + dice[0])
	for i in range(0, 3):
		print(dice[roll1][i] + "\t" + dice[roll2][i])
	print(dice[0] + "\t" + dice[0])

def theBet(plBalance):
	the_point = 0
	betAmount = int(input("Please enter your bet amount ($): ")) 
	
	while betAmount > plBalance:
		betAmount = int(input("You can't bet more money than you have.\nEnter amount to bet: "))
	
	plBalance = plBalance - betAmount
	(roll1, roll2) = (genRandom(), genRandom())
	total = roll1 + roll2
	
	showDice(roll1, roll2)
	print("Dice total this roll:", total, "\n")
	
	if total == 7 or total == 11:
		
		print("Congrats! Keep it up.\n")
		plBalance = 2 * betAmount + plBalance
		print("Hit enter to continue")
		input()
		return plBalance
		
	elif total == 2 or total == 3 or total == 12:
	
		print("Too bad. Better luck next round.\n")
		print("Hit enter to continue")
		input()
		return plBalance
		
	else:
		
		the_point = total
		print("Interesting. Let's see where this goes. Your point is", the_point)
		print("Hit enter to continue")
		input()
		
		while True:
			(roll1, roll2) = (genRandom(), genRandom())
			total = roll1 + roll2
			showDice(roll1, roll2)
			print("Dice total this roll:", total)
			
			if total == the_point:
			
				print("Amazing luck! Keep going.")
				#print(plBalance, betAmount, 2 * betAmount)
				plBalance = 2 * betAmount + plBalance
				print("Hit enter to continue")
				input()
				return plBalance
				
			elif total == 7:
			
				print("Rotten luck. Try again.\n")
				print("Hit enter to continue") 
				input()
				return plBalance
			
			print("Hit enter to continue")
			input()
			
	return plBalance
	
playerBalance = 500

print("Welcome to the game of Craps!\n")
gameOver = False

while not gameOver:
	if playerBalance <= 0:
		print("You have no more money! The casino has kicked you out.")
		gameOver = True;
		break
		
	dispMainMenu(playerBalance)
	userInput = int(input())
	if userInput == 1:
		playerBalance = theBet(playerBalance)
	elif userInput == 2:
		print("Exiting game. Have a nice day")
		gameOver = True
	else:
		print("Invalid input")
		continue