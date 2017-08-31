using System;
using System.Web.Security;
using System.Web.UI;

public partial class Login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                // This is an unauthorized, authenticated request...
                Response.Redirect("~/SystemPages/UnauthorizedAccess.aspx");
        }
    }

    protected void LoginButton_Click(object sender, EventArgs e)
    {
        // Validate the user against the Membership framework user store
        if (Membership.ValidateUser(UserName.Text, Password.Text))
        {
            // Log the user into the site
            FormsAuthentication.RedirectFromLoginPage(UserName.Text, RememberMe.Checked);
        }

        //Does there exist a User account for this user?
        var usrInfo = Membership.GetUser(UserName.Text);
        if (usrInfo != null)
        {
            // Is this user locked out?
            if (usrInfo.IsLockedOut)
            {
                InvalidCredentialsMessage.Visible = true;
                InvalidCredentialsMessage.Text =
                    "<center>Your account has been locked<br />Contact service desk to unlock your account</center>";
            }
            else
            {
                InvalidCredentialsMessage.Visible = true;
                InvalidCredentialsMessage.Text =
                    "<center>Invalid Company number or password<br />Please try again</center>";
            }
        }
    }
}