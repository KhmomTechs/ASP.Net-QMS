using System;
using System.Configuration;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Security
{
    public partial class Security_Clear : Page
    {
        private string strConnection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void GridEntries_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
        }

        protected void GridEntries_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            e.Cancel = false;

            e.NewValues["Checker"] = User.Identity.Name;

            e.NewValues["Status"] = "FIN";

            e.NewValues["StatusTime"] = DateTime.Now;

            e.NewValues["Finished"] = true;

            e.NewValues["FinishTime"] = DateTime.Now;


            var row = GridEntries.Rows[e.RowIndex];

            var DropOMCTimeHr = (DropDownList) row.FindControl("DropOMCTimeHr");
            var DropOMCTimeMin = (DropDownList) row.FindControl("DropOMCTimeMin");

            var DropKRATimeHr = (DropDownList) row.FindControl("DropKRATimeHr");
            var DropKRATimeMin = (DropDownList) row.FindControl("DropKRATimeMin");

            e.NewValues["OMCTIME"] = DropOMCTimeHr.SelectedValue + ":" + DropKRATimeMin.SelectedValue;

            e.NewValues["KRATIME"] = DropKRATimeHr.SelectedValue + ":" + DropKRATimeMin.SelectedValue;
        }

        protected void GridEntries_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[7].Text.Trim().Equals("True"))
                {
                    //e.Row.Cells[1].Width = 1;
                    //e.Row.Cells[2].BackColor = System.Drawing.Color.CadetBlue;
                    e.Row.BackColor = Color.Gray;
                    e.Row.Cells[1].Enabled = false;
                    //e.Row.BackColor = System.Drawing.Color.Red;
                }

                //show code
                var shipper = e.Row.Cells[4].Text;
                e.Row.Cells[4].Text = Helper.getShipper(shipper);

                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Center;


                //check suspension
                if (e.Row.Cells[13].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[0].Enabled = false;
                    //e.Row.Cells[7].Text = "SUSPENDED";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }
            }

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[7].ColumnSpan = 2;
                e.Row.Cells[7].Text = "OMC TIME";
                e.Row.Cells.RemoveAt(8);
                //e.Row.Cells.RemoveAt(2);

                e.Row.Cells[8].ColumnSpan = 2;
                e.Row.Cells[8].Text = "KRA TIME";
                e.Row.Cells.RemoveAt(9);
            }
        }
    }
}