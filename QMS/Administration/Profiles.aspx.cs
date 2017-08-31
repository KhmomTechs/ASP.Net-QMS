using System;
using System.Web.UI;

namespace Administration
{
    public partial class Administration_Profiles : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            GridProfile.DataBind();
        }
    }
}