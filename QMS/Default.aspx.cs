using System;
using System.Web.UI;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.IsAuthenticated)
        {
            if (User.IsInRole("Administrators"))
            {
                Response.Redirect("Administration/Default.aspx");
            }
            else if (User.IsInRole("Operations"))
            {
                Response.Redirect("Operations/Default.aspx");
            }
            else if (User.IsInRole("Pipecor"))
            {
                Response.Redirect("Pipecor/Default.aspx");
            }
            else if (User.IsInRole("Security"))
            {
                Response.Redirect("Security/Default.aspx");
            }
            else if (User.IsInRole("Safety"))
            {
                Response.Redirect("Safety/Default.aspx");
            }
            else if (User.IsInRole("CustomerCare"))
            {
                Response.Redirect("CustomerCare/Default.aspx");
            }
            else if (User.IsInRole("Stock Control"))
            {
                Response.Redirect("StockControl/Default.aspx");
            }
            else if (User.IsInRole("Users"))
            {
                Response.Redirect("Users/Default.aspx");
            }
            else if (User.IsInRole("Depot manager"))
            {
                Response.Redirect("Managers/Default.aspx");
            }
            else if (User.IsInRole("Supervisor"))
            {
                Response.Redirect("Supervisor/Default.aspx");
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }
}