using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Security
{
    public partial class Security_List : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlExp.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
            SqlLoc.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();

            checkExp();
            checkLoc();
            QueueView();
        }

        private void QueueView()
        {
            if (Request.QueryString["VIEW"] != null || Request.QueryString["VIEW"] != "")
            {
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
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            GridExp.DataBind();
            GridLoc.DataBind();

            if (IsPostBack)
            {
                checkExp();
                checkLoc();
            }

            QueueView();
        }

        private void checkExp()
        {
            foreach (GridViewRow row in GridExp.Rows)
            {
                var RadioButtonList1 = (RadioButtonList) row.FindControl("RadioButtonList1");
                var HyperLink1 = (HyperLink) row.FindControl("HyperLink1");
                var CheckExpApp = (Button) row.FindControl("CheckExpApp");

                if (RadioButtonList1.SelectedValue == "True")
                {
                    HyperLink1.Enabled = true;
                    CheckExpApp.Enabled = true;
                }
                else
                {
                    HyperLink1.Enabled = false;
                    CheckExpApp.Enabled = false;
                }
            }
        }

        private void checkLoc()
        {
            foreach (GridViewRow row in GridLoc.Rows)
            {
                var RadioButtonList1 = (RadioButtonList) row.FindControl("RadioButtonList1");
                var HyperLink1 = (HyperLink) row.FindControl("HyperLink1");
                var CheckLocApp = (Button) row.FindControl("CheckLocApp");

                if (RadioButtonList1.SelectedValue == "True")
                {
                    HyperLink1.Enabled = true;
                    CheckLocApp.Enabled = true;
                }
                else
                {
                    HyperLink1.Enabled = false;
                    CheckLocApp.Enabled = false;
                }
            }
        }

        protected void RadioButtonExp_SelectedIndexChanged(object sender, EventArgs e)
        {
            RadioCheck(sender);
            checkExp();
        }

        protected void RadioButtonLoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            RadioCheck(sender);
            checkLoc();
        }

        private void RadioCheck(object sender)
        {
            var strSql = new StringBuilder(string.Empty);
            var con = new SqlConnection(strConnection);
            var conQueue = new SqlConnection(strConnection);
            var cmd = new SqlCommand();

            //CheckBox CheckNo = (CheckBox)sender;
            var rdbl = (RadioButtonList) sender;
            var grdRow = (GridViewRow) rdbl.NamingContainer;

            //CheckBox chkNo = (CheckBox)grdRow.FindControl("CheckNo");
            var chkRl = (RadioButtonList) grdRow.FindControl("RadioButtonList1");

            var lblID = (Label) grdRow.FindControl("LabelID");
            var cusTime = DateTime.Now;
            var named = User.Identity.Name;


            if (chkRl.SelectedValue == "False")
            {
                try
                {
                    const string strQueueUpdate =
                        "Update NewQueue set Status = @Status, StatusTime = @StatusTime WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQueueUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Status", "SECTNA");
                    cmd.Parameters.AddWithValue("@StatusTime", cusTime);
                    cmd.Parameters.AddWithValue("@QueueID", lblID.Text);
                    cmd.Connection = conQueue;
                    conQueue.Open();
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
                    conQueue.Close();

                    GridLoc.DataBind();
                    GridExp.DataBind();
                }
            }
            else if (chkRl.SelectedValue == "True")
            {
                try
                {
                    const string strQueueUpdate = "Update NewQueue set Status = @Status WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQueueUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Status", "SECTA");
                    cmd.Parameters.AddWithValue("@QueueID", lblID.Text);
                    cmd.Connection = conQueue;
                    conQueue.Open();
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
                    conQueue.Close();

                    //GridLoc.DataBind();
                    //GridExp.DataBind();
                }
            }
        }

        protected void GridLoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            checkLoc();
        }

        protected void GridExp_SelectedIndexChanged(object sender, EventArgs e)
        {
            checkExp();
        }

        protected void GridLoc_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            RowData(e);
        }

        protected void GridExp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            RowData(e);
        }

        private static void RowData(GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[13].Text.Trim().Equals("SECTA"))
                {
                    //e.Row.Cells[2].BackColor = System.Drawing.Color.CadetBlue;
                }
                else if (e.Row.Cells[13].Text.Trim().Equals("SECTNA"))
                {
                    e.Row.Cells[1].BackColor = Color.LightSlateGray;
                    //e.Row.Cells[8].Enabled = false;
                    e.Row.Cells[15].Enabled = false;
                }
                else
                {
                    e.Row.BackColor = Color.Gray;
                    e.Row.Cells[1].Enabled = false;
                    //e.Row.Cells[8].Enabled = false;
                }

                //check suspension
                if (e.Row.Cells[14].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[1].Enabled = false;
                    //e.Row.Cells[7].Text = "SUSPENDED";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }
                //show code
                var shipper = e.Row.Cells[3].Text;
                e.Row.Cells[3].Text = Helper.getShipper(shipper);

                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
            }
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

        protected void CheckExpApp_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var CheckExpApp = (Button) sender;
                var grdRow = (GridViewRow) CheckExpApp.NamingContainer;
                var lblID = (Label) grdRow.FindControl("LabelID");

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;

                try
                {
                    ApproveSecurity(con, conQueue, cmd, lblID, cusTime, named);
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
                    conQueue.Close();

                    GridExp.DataBind();
                }
            }
        }

        protected void CheckLocApp_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();

                var ChecklocApp = (Button) sender;
                var grdRow1 = (GridViewRow) ChecklocApp.NamingContainer;
                var lblID = (Label) grdRow1.FindControl("LabelID");

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;


                try
                {
                    ApproveSecurity(con, conQueue, cmd, lblID, cusTime, named);
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
                    conQueue.Close();

                    GridLoc.DataBind();
                }
            }
        }

        private static void ApproveSecurity(SqlConnection con, SqlConnection conQueue, SqlCommand cmd, Label lblID,
            DateTime cusTime, string named)
        {
            const string strUpdate =
                "UPDATE SafetySecurity_B SET EntryStatus = @EntryStatus, EntryStatusTime = @EntryStatusTime, GateHseInspOfficial = @GateHseInspOfficial, TruckAvailability = @TruckAvailability WHERE QueueID = @QueueID";
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strUpdate;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@EntryStatus", true);
            cmd.Parameters.AddWithValue("@EntryStatusTime", cusTime);
            cmd.Parameters.AddWithValue("@GateHseInspOfficial", named);
            cmd.Parameters.AddWithValue("@TruckAvailability", true);
            cmd.Parameters.AddWithValue("@QueueID", lblID.Text);
            cmd.Connection = con;
            con.Open();
            cmd.ExecuteNonQuery();

            const string strQueueUpdate =
                "Update NewQueue set StatusTime = @StatusTime, Status = @Status , SecurityInspection = @SecurityInspection WHERE QueueID = @QueueID";
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strQueueUpdate;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@StatusTime", cusTime);
            cmd.Parameters.AddWithValue("@Status", "SAFTY");
            cmd.Parameters.AddWithValue("@SecurityInspection", false);
            cmd.Parameters.AddWithValue("@QueueID", lblID.Text);
            cmd.Connection = conQueue;
            conQueue.Open();
            cmd.ExecuteNonQuery();
        }
    }
}