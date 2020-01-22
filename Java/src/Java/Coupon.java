public class Coupon implements Comparable<Coupon>
{
    public int score;
    public double price;
    public String[] items;

    public Coupon(int score, double price, String[] items)
    {
        this.items = items;
        this.price = price;
        this.score = this.items.length;
    }

    @Override
    public int compareTo(Coupon c) {
        return (int)(this.price - c.price);
    }
}