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
            this.btnApproach = new System.Windows.Forms.Button();
            this.btnDepart = new System.Windows.Forms.Button();
            this.btnColAvoid = new System.Windows.Forms.Button();
            this.btnCollide = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // AnimTicker
            // 
            this.AnimTicker.Enabled = true;
            this.AnimTicker.Tick += new System.EventHandler(this.AnimTicker_Tick);
            // 
            // btnApproach
            // 
            this.btnApproach.Location = new System.Drawing.Point(1432, 836);
            this.btnApproach.Name = "btnApproach";
            this.btnApproach.Size = new System.Drawing.Size(75, 23);
            this.btnApproach.TabIndex = 0;
            this.btnApproach.Text = "Approach";
            this.btnApproach.UseVisualStyleBackColor = true;
            this.btnApproach.Click += new System.EventHandler(this.BtnApproach_Click);
            // 
            // btnDepart
            // 
            this.btnDepart.Location = new System.Drawing.Point(1513, 836);
            this.btnDepart.Name = "btnDepart";
            this.btnDepart.Size = new System.Drawing.Size(75, 23);
            this.btnDepart.TabIndex = 1;
            this.btnDepart.Text = "Depart";
            this.btnDepart.UseVisualStyleBackColor = true;
            this.btnDepart.Click += new System.EventHandler(this.BtnDepart_Click);
            // 
            // btnColAvoid
            // 
            this.btnColAvoid.Location = new System.Drawing.Point(1432, 865);
            this.btnColAvoid.Name = "btnColAvoid";
            this.btnColAvoid.Size = new System.Drawing.Size(75, 23);
            this.btnColAvoid.TabIndex = 2;
            this.btnColAvoid.Text = "Col. Avoid";
            this.btnColAvoid.UseVisualStyleBackColor = true;
            this.btnColAvoid.Click += new System.EventHandler(this.BtnColAvoid_Click);
            // 
            // btnCollide
            // 
            this.btnCollide.Location = new System.Drawing.Point(1513, 865);
            this.btnCollide.Name = "btnCollide";
            this.btnCollide.Size = new System.Drawing.Size(75, 23);
            this.btnCollide.TabIndex = 3;
            this.btnCollide.Text = "Collision";
            this.btnCollide.UseVisualStyleBackColor = true;
            this.btnCollide.Click += new System.EventHandler(this.BtnCollide_Click);
            // 
            // ATCDisp
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.ClientSize = new System.Drawing.Size(1600, 900);
            this.Controls.Add(this.btnCollide);
            this.Controls.Add(this.btnColAvoid);
            this.Controls.Add(this.btnDepart);
            this.Controls.Add(this.btnApproach);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "ATCDisp";
            this.Text = "ATC Display NEXTGEN";
            this.Load += new System.EventHandler(this.ATCDisp_Load);
            this.Click += new System.EventHandler(this.ATCDisp_Click);
            this.Paint += new System.Windows.Forms.PaintEventHandler(this.ATCDisp_Paint);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Timer AnimTicker;
        private System.Windows.Forms.Button btnApproach;
        private System.Windows.Forms.Button btnDepart;
        private System.Windows.Forms.Button btnColAvoid;
        private System.Windows.Forms.Button btnCollide;
    }
}

