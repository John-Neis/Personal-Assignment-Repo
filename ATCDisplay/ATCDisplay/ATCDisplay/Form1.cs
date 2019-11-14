using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ATCDisplay
{
    public partial class ATCDisp : Form
    {
        private double angle;
        private Rectangle WinBorder;
        private Rectangle InfoPanel;
        private SolidBrush brush;
        private Pen penThick;
        private Pen penThickPink;
        private Pen penThinPink;
        private Pen penThinWhite;
        private Pen penThin;
        Airplane[] planes;

        public ATCDisp()
        {
            InitializeComponent();
            Random rand = new Random();
            string[] randDest = {"KDLH", "KMSO", "KMSP", "CYWG", "KDEN" };

            angle = 0;
            WinBorder = new Rectangle(1, 1, 1261, 678);
            InfoPanel = new Rectangle(680, 0, 680, 678);
            brush = new SolidBrush(Color.FromArgb(0, 0, 100));
            penThick = new Pen(Color.FromArgb(0, 150, 0), 3);
            penThickPink = new Pen(Color.FromArgb(255, 50, 100), 3);
            penThinPink = new Pen(Color.FromArgb(255, 50, 100));
            penThinWhite = new Pen(Color.White);
            penThin = new Pen(Color.FromArgb(0, 150, 0));
            planes = new Airplane[5];

            // int posX, int posY, int posAlt, int vectX, int vectY, int speed, string dest, string callSign
            

            for(int i = 0; i < 5; i++)
            {
                double rad = degToRad(rand.Next(0, 359));
                int posX = (int)(295 * Math.Cos(rad));
                int posY = (int)(295 * Math.Sin(rad));
                int posAlt = rand.Next(1, 20) * 1500;

                int vectX;
                int vectY;
                int speed;
                if (posAlt < 10000)
                {
                    speed = 200;
                } else if(posAlt < 20000)
                {
                    speed = 250;
                } else
                {
                    speed = 300;
                }

                rad = degToRad(rand.Next(0, 359));
                vectX = (int)(0.02 * speed * Math.Cos(rad));
                vectY = (int)(0.02 * speed * Math.Sin(rad));
                
                string dest = randDest[rand.Next(0, randDest.Length - 1)];
                string callSign = "" + (char)rand.Next(65, 90) + (char)rand.Next(65, 90) + rand.Next(100, 999);
                
                planes[i] = new Airplane(posX, posY, posAlt, vectX, vectY, speed, dest, callSign);
            }
            
        }

        private void AnimTicker_Tick(object sender, EventArgs e)
        {
            Invalidate();
        }

        private void ATCDisp_Load(object sender, EventArgs e)
        {
            this.Width = 1280;
            this.Height = 720;
        }

        private void ATCDisp_Paint(object sender, PaintEventArgs e)
        {
            // Clear the screen, then draw the information panel rectangle. 
            // Once these rectangles are in place, draw the border.
            e.Graphics.Clear(Color.FromArgb(0, 0, 80));
            e.Graphics.FillRectangle(brush, InfoPanel);
            
            e.Graphics.DrawRectangle(penThick, WinBorder);
            e.Graphics.DrawLine(penThick, 680, 0, 680, 678);
            for(int i = 0; i < planes.Length; i++)
            {
                planes[i].PrintStats(e, 700, 20 + i * 70);
            }

            // Some of the important numbers we're using:
            //  amp    -> diameter of the airspace circle
            //  alpha  -> a small change in the angle for create a dashed circle
            //  radius -> half of the amplitude i.e. the radius of the outer circle

            int amp = this.Width / 2 - 50;
            double alpha = degToRad(5);
            double radius = amp / 2;
            Console.WriteLine(radius);

            // Now, to make drawing the concentric circles where we want a bit easier, translate
            // the origin to a point roughly to the first quarter of the window from the left.
            e.Graphics.TranslateTransform(50 + (int)radius, 50 + (int)radius);
            e.Graphics.DrawEllipse(penThin, new Rectangle(-amp / 2, -amp / 2, amp, amp));
            
            // Draws dashed concentric circles. Much easier to count to 360 Degrees than to 2*pi,
            // so we can just convert our angle to radians after getting the angle. There will be
            // 36 dashes per concentric circles => 360 / 10 = 36
            for (int i = 0; i < 360; i += 10)
            {
                double theta = degToRad(i);

                // It's much easier to draw each level of concentricity per dash
                for (int j = 1; j < 5; j++)
                {
                    float x = (float)(radius * (j / 5.0) * Math.Cos(theta));
                    float y = (float)(radius * (j / 5.0) * Math.Sin(theta));
                    float deltX = (float)(radius * (j / 5.0) * Math.Cos(theta + alpha));
                    float deltY = (float)(radius * (j / 5.0) * Math.Sin(theta + alpha));
                    e.Graphics.DrawLine(penThin, x, y, deltX, deltY);
                }
            }

            e.Graphics.FillEllipse(new SolidBrush(Color.FromArgb(0, 150, 0)), -5, -5, 10, 10);
            e.Graphics.DrawLine(penThickPink, -10, 10, -10, -10);
            e.Graphics.DrawLine(penThinPink, -10, -Height / 2 + 18, -10, Height / 2 - 28);
            //e.Graphics.DrawLine(penThin, 0, 0, (int)(radius * Math.Cos(angle)), (int)(radius * Math.Sin(angle)));


            for (int i = 0; i < planes.Length; i++)
            {
                planes[i].show(e, penThinWhite);
                planes[i].update();
            }
            //angle += 0.01;
        }

        private double degToRad(double angle)
        {
            return Math.PI * angle / 180.0;
        }
    }
}
