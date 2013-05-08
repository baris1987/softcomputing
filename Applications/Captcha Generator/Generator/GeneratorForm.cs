using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Drawing.Drawing2D;

namespace GenCapture
{
    public partial class GeneratorForm : Form
    {
        private String targetPath;
        private static char[] CHARSET = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray();

        public GeneratorForm()
        {
            InitializeComponent();
            targetPath = Directory.GetCurrentDirectory();
            TargetTextbox.Text = targetPath;
        }

        private void BrowseButton_Click(object sender, EventArgs e)
        {
            var browseFolderDialog = new FolderBrowserDialog();

            browseFolderDialog.Description = "Please select a target folder for the generated captchas.";
            browseFolderDialog.SelectedPath = targetPath;

            var browseForderDialogResult = browseFolderDialog.ShowDialog(this);

            if (browseForderDialogResult == DialogResult.OK)
            {
                TargetTextbox.Text = browseFolderDialog.SelectedPath;
            }
        }

        private void StartButton_Click(object sender, EventArgs e)
        {
            uint filesAmount = 1, charsAmount = 6;

            uint.TryParse(CharsTextbox.Text, out charsAmount);
            uint.TryParse(FilesTextbox.Text, out filesAmount);

            if (!Directory.Exists(TargetTextbox.Text))
            {
                FilesTextbox.Focus();
                MessageBox.Show("Please verify that your entered directory exists.", "Invalid target folder", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (filesAmount < 1)
            {
                FilesTextbox.Focus();
                MessageBox.Show("Please create one captcha file at least.", "Invalid files input", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (charsAmount < 1)
            {
                CharsTextbox.Focus();
                MessageBox.Show("Please use one char in the captcha at least.", "Invalid chars input", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            targetPath = TargetTextbox.Text;
            var rand = new Random();

            for (int i = 0; i < filesAmount; i++)
            {
                string captchaPattern = "";
                var bitmap = new Bitmap(190, 35);
                
                Graphics graphics = Graphics.FromImage(bitmap);
                graphics.Clear(Color.White);

                for (int j = 0; j < charsAmount; j++)
                {
                    captchaPattern += CHARSET[rand.Next(0, CHARSET.Length)];
                }

                int colorChange = 64;
                var fontFamily = new FontFamily("Arial");
                var brush = new SolidBrush(Color.FromArgb(0xFF, rand.Next(0, colorChange), rand.Next(0, colorChange), rand.Next(0, colorChange)));

                colorChange++;
                for (int j = 0; j < bitmap.Width; j +=8)
                {
                    var color = Color.FromArgb(0xFF, rand.Next(colorChange, 255), rand.Next(colorChange, 255), rand.Next(colorChange, 255));
                    graphics.DrawLine(new Pen(color), new Point(j, 0), new Point(j, bitmap.Height));
                }

                for (int j = 0; j < bitmap.Height; j += 8)
                {
                    var color = Color.FromArgb(0xFF, rand.Next(colorChange, 255), rand.Next(colorChange, 255), rand.Next(colorChange, 255));
                    graphics.DrawLine(new Pen(color), new Point(0, j), new Point(bitmap.Width, j));
                }

                for (int j = 0; j <10; j ++)
                {
                    var color = Color.FromArgb(0xFF, rand.Next(colorChange, 255), rand.Next(colorChange, 255), rand.Next(colorChange, 255));
                    graphics.DrawEllipse(new Pen(new SolidBrush(color) , 3), rand.Next(20, bitmap.Width), rand.Next(0, bitmap.Height / 2), rand.Next(20, 70), rand.Next(20, 70));
                }

                int char_width = (int)(bitmap.Width / 6);
                for (int j = 0; j < captchaPattern.Length; j++)
                {
                    int angle = rand.Next(-30, 30);

                    float dx = (float)(j * char_width + char_width / 2);
                    float dy = (float)(bitmap.Height / 2);
                    graphics.TranslateTransform(-dx, -dy, MatrixOrder.Append);

                    graphics.RotateTransform(angle, MatrixOrder.Append);
                    graphics.TranslateTransform(dx, dy, MatrixOrder.Append);
                    graphics.DrawString(captchaPattern[j].ToString(), new Font(fontFamily, 19, FontStyle.Italic), brush, new PointF(j * char_width, rand.Next(4,8)));
                    graphics.ResetTransform();
                }
                
                Image image = bitmap;

                string fileName = captchaPattern.Replace(" ", "");
                image.Save(targetPath + "\\" + fileName + ".png");
            }

            MessageBox.Show("Captcha creation is finished.", "Finished", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

     
        
    }
}
