using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace GenCapture
{
    public partial class Form1 : Form
    {
        private String folderPath = @"D:\";
        private static char[] VALUES = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray();

        public Form1()
        {
            InitializeComponent();
            tb_selected_path.Text = folderPath;

        }

        private void sf_folder_Click(object sender, EventArgs e)
        {
            System.Windows.Forms.FolderBrowserDialog objDialog = new FolderBrowserDialog();
            objDialog.Description = "Select Folder";
            objDialog.SelectedPath = folderPath;       // Vorgabe Pfad (und danach der gewählte Pfad)
            DialogResult objResult = objDialog.ShowDialog(this);
            if (objResult == DialogResult.OK)
            {
                tb_selected_path.Text = objDialog.SelectedPath;
            }
        }

        private void sf_start_Click(object sender, EventArgs e)
        {
            int images_amount = 1, sign_amout = 6;
            int.TryParse(tb_sign_amount.Text, out sign_amout);
            int.TryParse(tb_images_amount.Text, out images_amount);
            folderPath = tb_selected_path.Text;
            Random rand = new Random();

            for (int i = 0; i < images_amount; i++)
            {
                string randString = "";
                Bitmap b = new Bitmap(170, 40);
                
                Graphics g = Graphics.FromImage(b);
                g.Clear(Color.White);
                for (int j = 0; j < sign_amout; j++)
                {

                    randString += VALUES[rand.Next(0, VALUES.Length)] + " ";
                }
                FontFamily ff = new FontFamily("Arial");
                SolidBrush brush = new SolidBrush(Color.FromArgb(0xFF, rand.Next(0, 200), rand.Next(0, 200), rand.Next(0, 200)));
                for (int j = 0; j < 10; j++)
                {
                    Color c = Color.FromArgb(0xFF, rand.Next(0, 255), rand.Next(0, 255), rand.Next(0, 255));
                    g.DrawLine(new Pen(c), new Point(rand.Next(0, b.Width), rand.Next(0, b.Height)), new Point(rand.Next(0, b.Width), rand.Next(0, b.Height)));


                }
                g.DrawString(randString, new Font(ff, 20, FontStyle.Bold), brush, new PointF(0, 0));

                Image image = b;
                string fileName = randString.Replace(" ", "");
                image.Save(folderPath + "\\" + fileName + ".png");
            }
            MessageBox.Show("Complete");
        }

    }
}
