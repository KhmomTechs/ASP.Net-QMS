using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Administration
{
    public partial class Administration_ManageUsers : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindUserAccounts();

                BindFilteringUI();
            }
        }

        private void BindFilteringUI()
        {
            string[] filterOptions =
            {
                "All", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
                "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
            };
            FilteringUI.DataSource = filterOptions;
            FilteringUI.DataBind();
        }

        private void BindUserAccounts()
        {
            int totalRecords;
            UserAccounts.DataSource = Membership.FindUsersByName(UsernameToMatch + "%", PageIndex, PageSize,
                out totalRecords);
            UserAccounts.DataBind();

            // Enable/disable the paging interface
            var visitingFirstPage = PageIndex == 0;
            lnkFirst.Enabled = !visitingFirstPage;
            lnkPrev.Enabled = !visitingFirstPage;

            var lastPageIndex = (totalRecords - 1)/PageSize;
            var visitingLastPage = PageIndex >= lastPageIndex;
            lnkNext.Enabled = !visitingLastPage;
            lnkLast.Enabled = !visitingLastPage;
        }

        protected void FilteringUI_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "All")
                UsernameToMatch = string.Empty;
            else
                UsernameToMatch = e.CommandName;

            BindUserAccounts();
        }

        #region Paging Interface Click Event Handlers

        protected void lnkFirst_Click(object sender, EventArgs e)
        {
            PageIndex = 0;
            BindUserAccounts();
        }

        protected void lnkPrev_Click(object sender, EventArgs e)
        {
            PageIndex -= 1;
            BindUserAccounts();
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            PageIndex += 1;
            BindUserAccounts();
        }

        protected void lnkLast_Click(object sender, EventArgs e)
        {
            // Determine the total number of records
            int totalRecords;
            Membership.FindUsersByName(UsernameToMatch + "%", PageIndex, PageSize, out totalRecords);

            // Navigate to the last page index
            PageIndex = (totalRecords - 1)/PageSize;
            BindUserAccounts();
        }

        #endregion

        #region Properties

        private string UsernameToMatch
        {
            get
            {
                var o = ViewState["UsernameToMatch"];
                if (o == null)
                    return string.Empty;
                return (string) o;
            }
            set { ViewState["UsernameToMatch"] = value; }
        }

        private int PageIndex
        {
            get
            {
                var o = ViewState["PageIndex"];
                if (o == null)
                    return 0;
                return (int) o;
            }
            set { ViewState["PageIndex"] = value; }
        }

        private int PageSize
        {
            get { return 10; }
        }

        #endregion
    }
}