$type   = "(int|double|boolean|String|void)";

@input = (
    "public static double getPi(double multiplier) {",
    "public static void main(String[] args) {",
    "System.out.println(twoPiApprox);",
    "int twoPiApprox = (int)getPi(2);",
    "double piExact = getPi(1);",
    "double twoPiExact = getPi(2);",
    "int arr(int x) {",
    "boolean isUp = false;",
    "String name = \"Judith\""
);

my %symbols;

print "Regex: \n";
foreach $string (@input) {
    if($string =~ /$type\s+(\w+)(\((($type)\s+(\w+))\))?/) {
        #print "$1, $2, $6, $7\n";
        if(!($6 eq "")) { $symbols{$2} = "Method"; $symbols{$7} = $6; }
        elsif($2 eq "main") { $symbols{$2} = "Method"; }
        else { $symbols{$2} = $1; }
    }
}

print "\n";
foreach $key (sort(keys(%symbols))) {
    print "$key -> $symbols{$key}\n";
}
