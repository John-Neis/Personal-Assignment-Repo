import javax.swing.*;

class Window {
    public static void main(String[] args) {
        JFrame win = new JFrame("RL");
        win.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        JLabel lab = new JLabel("Endless Shrimp is dead and gone");

        win.setSize(300, 400);
        win.add(lab);
        win.setVisible(true);
    }
}