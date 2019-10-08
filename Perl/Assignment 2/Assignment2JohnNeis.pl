# John Neis, ID: 8003486
# Program 2
# Create a game of Craps. The player should be able to input a choice at each turn
# The program should also keep track of player balance, and generate random dice rolls
# This program is an exercise in using subroutines

use strict;

#$| = 1;
sub genRandom {
    my $randomInt = int(rand(6)) + 1;
}

sub dispMainMenu {
	
    printf "Player balance: \$%.2f\n", shift;
	print "What would you like to do? (Choose the number of your action)\n";
    print "\t1: Place a bet\n";
    print "\t2: Exit game\n";
}

sub showDice {
    my ($die1, $die2) = (shift, shift);
	my @dice = (
		 "# # # # #", 
		["#       #", "#   O   #", "#       #"], 
		["# O     #", "#       #", "#     O #"], 
		["# O     #", "#   O   #", "#     O #"], 
		["# O   O #", "#       #", "# O   O #"], 
		["# O   O #", "#   O   #", "# O   O #"], 
		["# O   O #", "# O   O #", "# O   O #"]
	);
	my $ref = $dice[$die1];
	
	print "\n$dice[0]  $dice[0]\n";
	for(my $i = 0; $i < scalar(@$ref); $i++) 
		{ print "$dice[$die1][$i]  $dice[$die2][$i]\n"; }
	print "$dice[0]  $dice[0]\n";
   
}

sub theBet { # Takes \$playerBalance
	my ($roll1, $roll2, $total, $balance, $betAmount, $the_point);
	
	print "Please enter your bet amount (\$): ";
	chomp($betAmount = <STDIN>);
	$balance = shift;
	
	while($betAmount > $$balance) {
		print "You can't bet more money than you have.\nEnter amount to bet: ";
		chomp($betAmount = <STDIN>);
	}
	
	
	$$balance -= $betAmount;
	
	($roll1, $roll2) = (genRandom, genRandom);
	$total = $roll1 + $roll2;
	showDice($roll1, $roll2);
	print "Dice total this roll: $total\n\n";
	
	if($total == 7 || $total == 11) {
		print "Congrats! Keep it up.\n\n";
		$$balance += 2 * $betAmount;
		print"Hit enter to continue"; <STDIN>;
		return;
	} elsif($total == 2 || $total == 3 || $total == 12) {
		print "Too bad. Better luck next round.\n\n";
		print"Hit enter to continue"; <STDIN>;
		return;
	} else {
		$the_point = $total;
		print "Interesting. Let's see where this goes. Your point is $the_point\n";
		print "Hit enter to continue"; <STDIN>;
		
		while(1) {
			($roll1, $roll2) = (genRandom, genRandom);
			$total = $roll1 + $roll2;
			showDice($roll1, $roll2);
			print "Dice total this roll: $total\n\n";
			
			if($total == $the_point) {
				print "Amazing luck! Keep going.\n\n";
				$$balance += 2 * $betAmount;
				print"Hit enter to continue"; <STDIN>;
				return;
			} elsif($total == 7) {
				print "Rotten luck. Try again.\n\n";
				print"Hit enter to continue"; <STDIN>;
				return;
			}
			print"Hit enter to continue"; <STDIN>;
		}
	}
	
}

my $playerBalance = 500.0;
my ($userInput, $gameOver);

print "Welcome to the game of Craps!\n\n";

while(!$gameOver) {
	if($playerBalance <= 0) {
		print "You have no more money! The casino has kicked you out.\n";
		$gameOver = 1;
		last;
	}
    dispMainMenu($playerBalance);
    $userInput = <STDIN>;
	
    if($userInput == 1) {
		theBet(\$playerBalance);
			
    } elsif($userInput == 2) {
        print "Exiting game. Have a nice day!";
        $gameOver = 1;
		
    } else {
        print "Invalid input\n";
        next;
    }
}