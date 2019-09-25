@array = (1, 2, 3, 4);

$hashRef = {a => 1, b => 2, c => 3}; 

$arrRef = [5, 6, 7, 8];

%hash = ('d', 4, 'e', 5, f, 6, 'g g' => 7);

# => digraph operator: essentially a comma; treats identifier in front of it as a string
# {} creates a reference to a hash, [] creates a reference to an array
# Going "back and forth" between references and data structures
# To get a reference of a data structure:
# 	$hashRef = \%hash;
#	$arrayRef = \@array;

# To get a data structure from a reference:
#	@array2 = @$arrayRef;  copies the data referred to by $arrayRef into @array2
#	%hash2 = %$hashRef;	   copies the data referred to by $hashRef  into %hash2
#	foreach $key (sort keys %$hashRef)

# What does the reference refer to?
# ref ($reference) returns:
#	HASH, ARRAY, SCALAR, CODE, REF, GLOB
# if (ref($someRef) eq 'HASH') { do something will ya }
