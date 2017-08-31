using System;
using System.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Managers
{
    public partial class Managers_DeclinedSafety : Page
    {
        private string strConnection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

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
            e.NewValues["SafetyWaiver"] = currentUserId.ToString();

            e.NewValues["SafetyWaiverTime"] = DateTime.Now;

            e.NewValues["StatusTime"] = DateTime.Now;
        }

        protected void GridEntries_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
            }
        }
    }
}