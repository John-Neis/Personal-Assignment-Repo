using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing;

namespace ATCDisplay
{
    class Airplane
    {
        private int posX;
        private int posY;
        private int orgX;
        private int orgY;
        private int posAlt;
        private int vectX;
        private int vectY;
        private int speed;
        private string dest;
        private string callSign;
        private Random rand;

        public Airplane(int posX, int posY, int posAlt, int vectX, int vectY, int speed, string dest, string callSign)
        {
            rand = new Random();
            this.posX     = posX;
            orgX = posX;
            this.posY     = posY;
            orgY = posY;
            this.posAlt   = posAlt;
            this.vectX    = vectX;
            this.vectY    = vectY;
            this.speed    = speed;
            this.dest     = dest;
            this.callSign = callSign;
        }

        public Airplane() // This constructor needs reworking. Do not use.
        {
            string[] randDest = { "KGFK", "KMSP", "CYWG", "KDEN"};
            rand = new Random();
            
            this.posX     = (int)(295 * Math.Cos(rand.Next(0, (int)Math.PI * 2)));
            orgX = posX;
            this.posY     = (int)(295 * Math.Sin(rand.Next(0, (int)Math.PI * 2)));
            orgY = posY;
            this.posAlt   = rand.Next(1600, 35000);
            this.vectX    = rand.Next(-20, 20);
            this.vectY    = rand.Next(-20, 20);
            this.speed    = (int)Math.Sqrt(Math.Pow(this.vectX, 2) + Math.Pow(this.vectY, 2));
            this.dest     = randDest[rand.Next(0, 3)];
            this.callSign = "" + (char)rand.Next(65, 90) + (char)rand.Next(65, 90) + rand.Next(100, 999);
        }

        public void show(PaintEventArgs e, Pen p)
        {
            bool showCondition = Math.Sqrt(Math.Pow(posX, 2) + Math.Pow(posY, 2)) <= 300;
            if(showCondition)
            {
                e.Graphics.DrawLine(p, posX - 5, posY - 5, posX + 5, posY + 5);
                e.Graphics.DrawLine(p, posX - 5, posY + 5, posX + 5, posY - 5);
                e.Graphics.DrawString(callSign, new Font("Courier New", 5), new SolidBrush(Color.White), posX - 5, posY + 7);
            } else
            {
                posX = orgX;
                posY = orgY;
                double rad = Math.PI * rand.Next(0, 359) / 180.0;
                vectX = (int)(0.01 * speed * Math.Cos(rad));
                vectY = (int)(0.01 * speed * Math.Sin(rad));
            }
        }

        public void update()
        {
            posX += vectX;
            posY += vectY;
        }

        public void PrintStats(PaintEventArgs e, int x, int y) 
        {
            e.Graphics.DrawString(getInfo(), new Font("Courier New", 8), new SolidBrush(Color.FromArgb(0, 150, 0)), x, y);
        }

        public string getInfo()
        {
            if(posAlt >= 18000)
            {
                return callSign + "\n" +
                   "(x, y, alt): (" + posX + ", " + posY + ", FL" + posAlt / 100 + ")\n" +
                   "<x, y>, speed: <" + vectX + ", " + vectY + ">, " + speed + "kts\n" +
                   "Destination: " + dest + "\n";
            }
            else
            {
                return callSign + "\n" +
                   "(x, y, alt): (" + posX + ", " + posY + ", " + posAlt + ")\n" +
                   "<x, y>, speed: <" + vectX + ", " + vectY + ">, " + speed + "kts\n" +
                   "Destination: " + dest + "\n";
            }
            
        }
    }
}
