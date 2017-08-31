using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Master
{
    public partial class KRA : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LoginDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            var currentUser = Membership.GetUser();
            var currentUserId = (Guid) currentUser.ProviderUserKey;
            e.Command.Parameters["@UserId"].Value = currentUserId;
        }
    }
}