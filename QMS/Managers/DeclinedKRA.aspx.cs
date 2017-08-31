using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Managers
{
    public partial class Managers_DeclinedKRA : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            EntrySource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            GridEntries.DataBind();
        }

        protected void GridEntries_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
        }

        protected void GridEntries_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            var currentUser = Membership.GetUser();
            var currentUserId = (Guid) currentUser.ProviderUserKey;
            e.NewValues["CustCareApprover"] = currentUserId.ToString();

            e.NewValues["CustCareApprovalTime"] = DateTime.Now;

            e.NewValues["StatusTime"] = DateTime.Now;
        }

        protected void GridEntries_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //show code
                var shipper = e.Row.Cells[4].Text;
                e.Row.Cells[4].Text = Helper.getShipper(shipper);
            }
        }
    }
}