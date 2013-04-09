using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;

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
                var bitmap = new Bitmap(170, 40);
                
                Graphics graphics = Graphics.FromImage(bitmap);
                graphics.Clear(Color.White);

                for (int j = 0; j < charsAmount; j++)
                {
                    captchaPattern += CHARSET[rand.Next(0, CHARSET.Length)] + " ";
                }

                var fontFamily = new FontFamily("Arial");
                var brush = new SolidBrush(Color.FromArgb(0xFF, rand.Next(0, 200), rand.Next(0, 200), rand.Next(0, 200)));

                for (int j = 0; j < 10; j++)
                {
                    var color = Color.FromArgb(0xFF, rand.Next(0, 255), rand.Next(0, 255), rand.Next(0, 255));
                    graphics.DrawLine(new Pen(color), new Point(rand.Next(0, bitmap.Width), rand.Next(0, bitmap.Height)), new Point(rand.Next(0, bitmap.Width), rand.Next(0, bitmap.Height)));
                }

                graphics.DrawString(captchaPattern, new Font(fontFamily, 20, FontStyle.Italic), brush, new PointF(0, 0));

                Image image = bitmap;

                string fileName = captchaPattern.Replace(" ", "");
                image.Save(targetPath + "\\" + fileName + ".png");
            }

            MessageBox.Show("Captcha creation is finished.", "Finished", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
    }
}
