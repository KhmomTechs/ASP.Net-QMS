using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CustomerCare
{
    public partial class CustomerCare_List : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

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
                Response.Redirect("List.aspx?view=local");
                PanelExp.Visible = false;
                PanelLoc.Visible = true;
            }
        }

        protected void ExpSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Response.Redirect("List.aspx?view=export");
                PanelExp.Visible = true;
                PanelLoc.Visible = false;
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

        protected void btnGo_Click(object sender, EventArgs e)
        {
            var show = Request.QueryString["VIEW"];
            Response.Redirect("Query.aspx?order=" + TextSearch.Text + "&view=" + show);
        }

        protected void btnDisable_Click(object sender, EventArgs e)
        {
            var SetDate = DateTime.Today;
            //update NewQueue
            var updateSql = "UPDATE NewQueue SET Status = @Status, StatusTime = @StatusTime WHERE SetDate = '" + SetDate +
                            "' AND Loaded IS NULL AND Requeued = 'True'";
            using (var myConnection = new SqlConnection(strConnection))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@Status", "DISABLED");
                myCommand.Parameters.AddWithValue("@StatusTime", DateTime.Now);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }


            //update SAP
            var updateSap =
                "UPDATE SAP_Orders SET Status = @Status, Delivery_Date = @Delivery_Date, Last_Change_Date = @Last_Change_Date WHERE Delivery_Date = '" +
                SetDate + "' AND SAP_Request_No IN (SELECT SAP_Request_No FROM [dbo].[NewQueue] WHERE SetDate = '" +
                SetDate + "' AND Loaded IS NULL)";
            using (var myConnection = new SqlConnection(strConnection))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateSap, myConnection);
                myCommand.Parameters.AddWithValue("@Status", "PIPCOR");
                myCommand.Parameters.AddWithValue("@Delivery_Date", DateTime.Today);
                myCommand.Parameters.AddWithValue("@Last_Change_Date", DateTime.Now);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
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

        protected void ChkLocReq_CheckedChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var ChkRequeue = (CheckBox) sender;
                var grdRow = (GridViewRow) ChkRequeue.NamingContainer;

                var lblID = (Label) grdRow.FindControl("Que_ID");

                RequeueTruck(con, cmd, ChkRequeue, lblID);

                //update grid
                GridLocal.DataBind();
            }
        }

        protected void ChkExpReq_CheckedChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var ChkRequeue = (CheckBox) sender;
                var grdRow = (GridViewRow) ChkRequeue.NamingContainer;

                var lblID = (Label) grdRow.FindControl("Que_ID");

                RequeueTruck(con, cmd, ChkRequeue, lblID);

                //update grid
                GridExp.DataBind();
            }
        }

        private static void RequeueTruck(SqlConnection con, SqlCommand cmd, CheckBox ChkQueue, Label lblID)
        {
            //save
            try
            {
                const string strUpdate = "Update NewQueue set Requeued = @Requeued WHERE QueueID = @QueueID";
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = strUpdate;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@Requeued", ChkQueue.Checked);
                cmd.Parameters.AddWithValue("@QueueID", lblID.Text);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                var errorMsg = "Error in Updation";
                errorMsg += ex.Message;
                throw new Exception(errorMsg);
            }
            finally
            {
                con.Close();
            }
        }
    }
}