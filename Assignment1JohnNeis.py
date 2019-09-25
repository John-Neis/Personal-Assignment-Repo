# The purpose of this exercise is to teach myself Python alongside
# Perl. I have done the least with Python up to this point, so I
# believe it has some merit towards my education

if __name__ == '__main__':
	print("Part 1 (Python style):")

	full_name = input("Please enter a full name (first last): ")

	first_name = full_name[0: full_name.index(' ')]
	last_name = full_name[full_name.index(' ') + 1: ]

	print("First:         " + first_name)
	print("Last:          " + last_name)
	print("Last, First:   " + last_name + ", " + first_name)
	print("FIRST LAST:    " + first_name.upper() + " " + last_name.upper())
	print("First \\n Last: " + first_name + "\n" + "               " + last_name)
	print()

	print("Part 2 (Python style):")
	the_number = int( input("Please input a 3 digit number (###): ") )

	print("Hundreds: " + str(int(the_number / 100 % 10)))
	print("Tens:     " + str(int(the_number / 10 % 10)))
	print("Ones:     " + str(the_number % 10))
	print("Original: " + str(the_number))