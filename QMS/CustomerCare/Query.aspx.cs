using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CustomerCare
{
    public partial class CustomerCare_Query : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            QueueView();
        }

        private void QueueView()
        {
            try
            {
                var order = Convert.ToInt32(Request.QueryString["ORDER"]);
                var show = Request.QueryString["VIEW"];

                if (show == "")
                {
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
                else
                {
                    PanelLoc.Visible = false;
                    PanelExp.Visible = false;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("List.aspx");
            }
            finally
            {
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
                Response.Redirect("List.aspx?view=local");
                PanelExp.Visible = false;
                PanelLoc.Visible = true;

                //show = "local";
            }
        }

        protected void ExpSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Response.Redirect("List.aspx?view=export");
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
            }
        }

        protected void GridLocal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
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

        protected void btnGo_Click(object sender, EventArgs e)
        {
            var show = Request.QueryString["VIEW"];
            Response.Redirect("List.aspx?view=" + show);
        }
    }
}