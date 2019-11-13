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
        private float angle = 0;
        private Rectangle WinBorder = new Rectangle(1, 1, 1261, 678);
        private Rectangle InfoPanel = new Rectangle(680, 0, 680, 678);
        private SolidBrush brush = new SolidBrush(Color.FromArgb(0, 0, 100));
        private Pen penThick = new Pen(Color.FromArgb(0, 150, 0), 3);
        private Pen penThin = new Pen(Color.FromArgb(0, 150, 0));

        public ATCDisp()
        {
            InitializeComponent();
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
            
            // Some of the important numbers we're using:
            //  amp    -> diameter of the airspace circle
            //  alpha  -> a small change in the angle for create a dashed circle
            //  radius -> half of the amplitude i.e. the radius of the outer circle
            
            int amp = this.Width / 2 - 50;
            double alpha = degToRad(5);
            double radius = amp / 2;

            // Now, to make drawing the concentric circles where we want a bit easier, translate
            // the origin to a point roughly to the first quarter of the window from the left.
            e.Graphics.TranslateTransform(50 + amp / 2, 50 + amp / 2);
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
        }

        private double degToRad(double angle)
        {
            return Math.PI * angle / 180.0;
        }
    }
}
