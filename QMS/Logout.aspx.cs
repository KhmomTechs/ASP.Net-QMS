using System;
using System.Web.UI;

public partial class Logout : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
}