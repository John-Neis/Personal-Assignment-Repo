import java.util.*;

public class CouponPlayTime
{
    public static void main(String args[])
    {
        ArrayList<Coupon> couponArray = new ArrayList<Coupon>();
        ArrayList<Coupon> useList = new ArrayList<Coupon>();
        HashMap<String, Boolean> dictionary = new HashMap<String, Boolean>();
        Scanner keyboard = new Scanner(System.in);
        Object[] item = new Object[2];

        System.out.print("Enter an item to purchase: ");
        item[0] = keyboard.nextLine();
        System.out.print("Enter the item's price:    ");
        item[1] = Double.valueOf(keyboard.nextDouble());
        keyboard.nextLine();

        System.out.println("\nItem entered:");
        System.out.println(item[0] + "\t" + item[1] + "\n");

        System.out.print("Enter the number of coupons to check: ");
        int couponNum = keyboard.nextInt();
        keyboard.nextLine();

        for(int i = 0; i < couponNum; i++)
        {
            System.out.print("Enter coupon " + (i + 1) + " items: ");
            String itemsList = keyboard.nextLine();
            System.out.print("Enter coupon price: ");
            double price = keyboard.nextDouble();
            keyboard.nextLine();

            couponArray.add(new Coupon(itemsList.split("\\s*,\\s*").length, 
                                       price, 
                                       itemsList.split("\\s*,\\s*")
                                      )
                            );
            System.out.println();
        }

        Collections.sort(couponArray);
        Collections.reverse(couponArray);

        for(int i = 0; i < couponArray.size(); i++)
        {
            for(int j = 0; j < couponArray.get(i).items.length; j++)
            {
                if(dictionary.containsKey(couponArray.get(i).items[j]))
                {
                    couponArray.get(i).score = 0;
                }
            }

            for(int j = 0; j < couponArray.get(i).items.length; j++)
            {
                dictionary.put(couponArray.get(i).items[j], true);
            }

            if(couponArray.get(i).score == couponArray.get(i).items.length)
            {
                useList.add(couponArray.get(i));
            }
        }

        for(int i = 0; i < useList.size(); i++)
        {
            System.out.println("Use Coupon " + (i + 1) + ":");
            for(int j = 0; j < useList.get(i).items.length; j++)
            {
                System.out.print(useList.get(i).items[j] + " ");
            }
        }

        keyboard.close();
    }
}