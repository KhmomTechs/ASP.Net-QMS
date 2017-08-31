using System;
using System.Web.UI;

namespace Master
{
    public partial class Display : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToLongDateString();
        }
    }
}