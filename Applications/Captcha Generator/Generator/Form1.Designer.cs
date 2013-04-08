namespace GenCapture
{
    partial class Form1
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.sf_folder = new System.Windows.Forms.Button();
            this.sf_start = new System.Windows.Forms.Button();
            this.tb_images_amount = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.tb_sign_amount = new System.Windows.Forms.TextBox();
            this.tb_selected_path = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // sf_folder
            // 
            this.sf_folder.Location = new System.Drawing.Point(197, 10);
            this.sf_folder.Name = "sf_folder";
            this.sf_folder.Size = new System.Drawing.Size(75, 23);
            this.sf_folder.TabIndex = 0;
            this.sf_folder.Text = "Browse";
            this.sf_folder.UseVisualStyleBackColor = true;
            this.sf_folder.Click += new System.EventHandler(this.sf_folder_Click);
            // 
            // sf_start
            // 
            this.sf_start.Location = new System.Drawing.Point(62, 99);
            this.sf_start.Name = "sf_start";
            this.sf_start.Size = new System.Drawing.Size(75, 23);
            this.sf_start.TabIndex = 1;
            this.sf_start.Text = "Start";
            this.sf_start.UseVisualStyleBackColor = true;
            this.sf_start.Click += new System.EventHandler(this.sf_start_Click);
            // 
            // tb_images_amount
            // 
            this.tb_images_amount.Location = new System.Drawing.Point(61, 37);
            this.tb_images_amount.Name = "tb_images_amount";
            this.tb_images_amount.Size = new System.Drawing.Size(44, 20);
            this.tb_images_amount.TabIndex = 2;
            this.tb_images_amount.Text = "1000";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 40);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(28, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Files";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 64);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(34, 13);
            this.label2.TabIndex = 5;
            this.label2.Text = "Chars";
            // 
            // tb_sign_amount
            // 
            this.tb_sign_amount.Location = new System.Drawing.Point(62, 63);
            this.tb_sign_amount.Name = "tb_sign_amount";
            this.tb_sign_amount.Size = new System.Drawing.Size(44, 20);
            this.tb_sign_amount.TabIndex = 4;
            this.tb_sign_amount.Text = "6";
            // 
            // tb_selected_path
            // 
            this.tb_selected_path.Location = new System.Drawing.Point(62, 12);
            this.tb_selected_path.Name = "tb_selected_path";
            this.tb_selected_path.Size = new System.Drawing.Size(129, 20);
            this.tb_selected_path.TabIndex = 6;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 15);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(38, 13);
            this.label3.TabIndex = 7;
            this.label3.Text = "Target";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 143);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.tb_selected_path);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.tb_sign_amount);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.tb_images_amount);
            this.Controls.Add(this.sf_start);
            this.Controls.Add(this.sf_folder);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Capture Generator";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button sf_folder;
        private System.Windows.Forms.Button sf_start;
        private System.Windows.Forms.TextBox tb_images_amount;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox tb_sign_amount;
        private System.Windows.Forms.TextBox tb_selected_path;
        private System.Windows.Forms.Label label3;
    }
}

