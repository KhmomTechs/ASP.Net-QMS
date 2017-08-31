using System;
using System.Web.Security;
using System.Web.UI;

namespace Membership
{
    public partial class ChangePassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var rolesByUser = Roles.GetRolesForUser(User.Identity.Name);

            myRoles.DataSource = rolesByUser;
            myRoles.DataBind();
        }

        protected void ChangePwd_ChangedPassword(object sender, EventArgs e)
        {
        }

        protected void GoBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Default.aspx");
        }
    }
}