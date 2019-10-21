public class FooBar {
	public static double getPi(double multiplier, int n, String msg) {
		System.out.println(multiplier + " " + n + " " + msg);
		return multiplier * Math.PI;
	}

	public static void main(String[] args) {
	    //FooBar myBar = new FooBar();
		int x, y, z;
		boolean t, f, idk;
		double pi, notpi, whereIsMyPie, e;
		String hello, daddy, myNameIs, Sexy;
		boolean yes;
		int twoPiApprox = (int)getPi(2);
		System.out.println(twoPiApprox);
		
		double piExact = getPi(1);
		System.out.println(piExact);
		
		double twoPiExact = getPi(2);
		System.out.println(twoPiExact);
	}
}