using System;
using System.Web.UI;

public partial class RecoverPassword : Page
{
    //protected void RecoverPwd_SendingMail(object sender, MailMessageEventArgs e)
    //{
    //    e.Message.CC.Add("webmaster@example.com");
    //}
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.IsAuthenticated)
        {
            Response.Redirect("Default.aspx");
        }
    }
}