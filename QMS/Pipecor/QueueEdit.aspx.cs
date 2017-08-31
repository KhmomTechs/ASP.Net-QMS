using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pipecor
{
    public partial class Pipecor_QueueEdit : Page
    {
        private string strConnection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlExportSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
            SqlLocalSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            GridLocal.DataBind();
            GridExp.DataBind();
        }

        protected void GridLocal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            RowBound(e);
        }

        protected void GridExp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            RowBound(e);
        }

        private void RowBound(GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var No = (Label) View.FindControl("lblEditable_No");

                //Label Registration = (Label)View.FindControl("lblEditable_Reg");
                var LONO = (Label) View.FindControl("Editable_LONO");
                var Quantity = (Label) View.FindControl("lblEditable_Quantity");
                var Product = (Label) View.FindControl("lblEditable_Product");
                var Status = (Label) View.FindControl("lblEditable_Status");

                //check rejected
                if (e.Row.Cells[9].Text.Trim().Equals("CUSTR"))
                {
                    e.Row.BackColor = Color.Yellow;
                }
                if (e.Row.Cells[9].Text.Trim().Equals("REJDM"))
                {
                    e.Row.BackColor = Color.Yellow;
                }

                ////check editable
                //if (No.Text == "True")
                //{
                //    ((BoundField)GridLocal.Columns[1]).ReadOnly = false;
                //}

                ////if (Registration.Text == "True")
                //{
                //    ((BoundField)GridLocal.Columns[2]).ReadOnly = false;
                //}

                ////if (Quantity.Text == "True")
                //{
                //    ((BoundField)GridLocal.Columns[4]).ReadOnly = false;
                //    ((BoundField)GridLocal.Columns[5]).ReadOnly = false;
                //    ((BoundField)GridLocal.Columns[6]).ReadOnly = false;
                //}
                ////if (LONO.Text == "True")
                //{
                //    ((BoundField)GridLocal.Columns[3]).ReadOnly = false;
                //}
                ////if (Status.Text == "True")
                //{
                //    ((BoundField)GridLocal.Columns[7]).ReadOnly = false;
                //}

                var theShipper = e.Row.Cells[2].Text;
                e.Row.Cells[2].Text = Helper.getShipper(theShipper);

                var theStatus = e.Row.Cells[9].Text;
                e.Row.Cells[9].Text = Helper.getStatus(theStatus);

                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Left;
            }
        }


        protected void LocSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                PanelExp.Visible = false;
                PanelLoc.Visible = true;
            }
        }

        protected void ExpSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                PanelExp.Visible = true;
                PanelLoc.Visible = false;
            }
        }

        protected void GridExp_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            var changeTime = DateTime.Now;
            var companyNo = User.Identity.Name;


            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

            var updateRecord = "INSERT INTO Pipecor_Edit(CompNumber, TimeOfEdit) VALUES (@CompNumber, @TimeOfEdit)";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateRecord, myConnection);
                myCommand.Parameters.AddWithValue("@CompNumber", companyNo);
                myCommand.Parameters.AddWithValue("@TimeOfEdit", changeTime);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }

        protected void GridLocal_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            var changeTime = DateTime.Now;
            var companyNo = User.Identity.Name;

            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

            var updateRecord = "INSERT INTO Pipecor_Edit(CompNumber, TimeOfEdit) VALUES (@CompNumber, @TimeOfEdit)";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateRecord, myConnection);
                myCommand.Parameters.AddWithValue("@CompNumber", companyNo);
                myCommand.Parameters.AddWithValue("@TimeOfEdit", changeTime);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }

        protected void GridExp_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            e.Cancel = false;
        }

        protected void GridLocal_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            e.Cancel = false;
        }
    }
}