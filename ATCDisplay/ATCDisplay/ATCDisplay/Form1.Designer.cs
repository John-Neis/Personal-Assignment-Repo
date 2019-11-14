namespace ATCDisplay
{
    partial class ATCDisp
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ATCDisp));
            this.AnimTicker = new System.Windows.Forms.Timer(this.components);
            this.SuspendLayout();
            // 
            // AnimTicker
            // 
            this.AnimTicker.Enabled = true;
            this.AnimTicker.Interval = 32;
            this.AnimTicker.Tick += new System.EventHandler(this.AnimTicker_Tick);
            // 
            // ATCDisp
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.ClientSize = new System.Drawing.Size(1600, 900);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "ATCDisp";
            this.Text = "ATC Display NEXTGEN";
            this.Load += new System.EventHandler(this.ATCDisp_Load);
            this.Paint += new System.Windows.Forms.PaintEventHandler(this.ATCDisp_Paint);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Timer AnimTicker;
    }
}

