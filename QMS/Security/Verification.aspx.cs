using System;
using System.Configuration;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Security
{
    public partial class Security_Verification : Page
    {
        private string strConnection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            QueueView();
            SqlExportSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
            SqlLocalSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
        }

        private void QueueView()
        {
            var order = Request.QueryString["ORDER"];
            var show = Request.QueryString["VIEW"];


            if (show == "local" || show == "Local")
            {
                PanelLoc.Visible = true;
                PanelExp.Visible = false;
            }
            else if (show == "export" || show == "Export")
            {
                PanelLoc.Visible = false;
                PanelExp.Visible = true;
            }
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            QueueView();

            GridLocal.DataBind();
            GridExp.DataBind();
        }

        protected void LocSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Response.Redirect("Verification.aspx?view=local");
                PanelExp.Visible = false;
                PanelLoc.Visible = true;

                //show = "local";
            }
        }

        protected void ExpSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Response.Redirect("Verification.aspx?view=export");
                PanelExp.Visible = true;
                PanelLoc.Visible = false;

                //show = "export";
            }
        }

        protected void GridExp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;

                if (e.Row.Cells[9].Text.Trim().Equals("CUST"))
                {
                    e.Row.Cells[8].Enabled = true;
                }
                //show code
                var shipper = e.Row.Cells[1].Text;
                e.Row.Cells[1].Text = Helper.getShipper(shipper);
                //check suspension
                if (e.Row.Cells[10].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[8].Enabled = false;
                    //e.Row.Cells[7].Text = "SUSPENDED";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }
            }
        }

        protected void GridLocal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;

                if (e.Row.Cells[9].Text.Trim().Equals("CUST"))
                {
                    e.Row.Cells[8].Enabled = true;
                }
                //show code
                var shipper = e.Row.Cells[1].Text;
                e.Row.Cells[1].Text = Helper.getShipper(shipper);
                //check suspension
                if (e.Row.Cells[10].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[8].Enabled = false;
                    //e.Row.Cells[7].Text = "SUSPENDED";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }
            }
        }

        protected void GridResult_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
            }
        }

        protected void GridExp_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridExp.PageIndex = e.NewPageIndex;
        }

        protected void GridLocal_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridLocal.PageIndex = e.NewPageIndex;
        }
    }
}