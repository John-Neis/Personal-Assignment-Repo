public class FooBar {
	public static double getPi(double multiplier) {
		return multiplier * Math.PI;
	}

	public static void main(String[] args) {
	    //FooBar myBar = new FooBar();
		int twoPiApprox = (int)getPi(2);
		System.out.println(twoPiApprox);
		
		double piExact = getPi(1);
		System.out.println(piExact);
		
		double twoPiExact = getPi(2);
		System.out.println(twoPiExact);
	}
}