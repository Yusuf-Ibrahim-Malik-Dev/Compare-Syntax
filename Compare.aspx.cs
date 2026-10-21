using System;

namespace CompareSyntax
{
    /// <summary>
    /// ASP.NET Web Forms entry point for the Compare Syntax developer tool.
    /// The comparison/editor features run in the browser using the bundled local JavaScript assets.
    /// </summary>
    public partial class Compare : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No postback is required for the client-side editor.
            // Keep this method for future ASP.NET 4.8 server-side features.
        }
    }
}
