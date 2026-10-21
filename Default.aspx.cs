using System;
using System.Text;
using System.Web.UI;

namespace CompareSyntax
{
    /// <summary>
    /// Halaman utama Compare Syntax. Mesin editor dan diff tetap dijalankan di browser.
    /// </summary>
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kirim HTML menggunakan UTF-8 agar simbol dan karakter internasional terbaca.
            Response.ContentEncoding = Encoding.UTF8;
            Response.Charset = "utf-8";
        }
    }
}
