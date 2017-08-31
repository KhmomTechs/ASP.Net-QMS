using System;
using System.Web.Security;
using System.Web.UI;

namespace Administration
{
    public partial class Administration_UserInformation : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // If querystring value is missing, send the user to ManageUsers.aspx
                var userName = Request.QueryString["user"];
                if (string.IsNullOrEmpty(userName))
                    Response.Redirect("ManageUsers.aspx");


                // Get information about this user
                var usr = Membership.GetUser(userName);
                if (usr == null)
                    Response.Redirect("ManageUsers.aspx");

                UserNameLabel.Text = usr.UserName;
                IsApproved.Checked = usr.IsApproved;

                if (usr.LastLockoutDate.Year < 2000)
                    LastLockoutDateLabel.Text = string.Empty;
                else
                    LastLockoutDateLabel.Text = usr.LastLockoutDate.ToShortDateString();

                UnlockUserButton.Enabled = usr.IsLockedOut;
            }
        }

        protected void IsApproved_CheckedChanged(object sender, EventArgs e)
        {
            // Toggle the user's approved status
            var userName = Request.QueryString["user"];
            var usr = Membership.GetUser(userName);
            usr.IsApproved = IsApproved.Checked;
            Membership.UpdateUser(usr);

            StatusMessage.Text = "The user's approved status has been updated.";
        }

        protected void UnlockUserButton_Click(object sender, EventArgs e)
        {
            // Unlock the user account
            var userName = Request.QueryString["user"];
            var usr = Membership.GetUser(userName);
            usr.UnlockUser();

            UnlockUserButton.Enabled = false;
            StatusMessage.Text = "The user account has been unlocked.";
        }
    }
}