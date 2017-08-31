using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Safety
{
    public partial class Safety_List : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            checkExp();
            checkLoc();
            QueueView();
            SqlDataExp.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
            SqlDataLoc.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
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

                if (RadioButtonList1.SelectedValue == "True")
                {
                    HyperLink1.Enabled = true;
                }
                else
                {
                    HyperLink1.Enabled = false;

                    //HyperLink1.ForeColor = System.Drawing.Color.Gray;
                }
            }
        }

        private void checkLoc()
        {
            foreach (GridViewRow row in GridLoc.Rows)
            {
                var RadioButtonList1 = (RadioButtonList) row.FindControl("RadioButtonList1");
                var HyperLink1 = (HyperLink) row.FindControl("HyperLink1");

                if (RadioButtonList1.SelectedValue == "True")
                {
                    HyperLink1.Enabled = true;
                }
                else
                {
                    HyperLink1.Enabled = false;

                    //HyperLink1.ForeColor = System.Drawing.Color.Gray;
                }
            }
        }

        protected void RadioButtonExp_SelectedIndexChanged(object sender, EventArgs e)
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
                    //cmd.Parameters.AddWithValue("@CustCareApproval", ChkApp);
                    cmd.Parameters.AddWithValue("@Status", "SAFNT ");
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
                    //cmd.Parameters.AddWithValue("@CustCareApproval", ChkApp);
                    cmd.Parameters.AddWithValue("@Status", "SAFTY");
                    //cmd.Parameters.AddWithValue("@StatusTime", cusTime);
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

                    checkExp();
                }
            }
            checkExp();
        }

        protected void RadioButtonLoc_SelectedIndexChanged(object sender, EventArgs e)
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
                    //cmd.Parameters.AddWithValue("@CustCareApproval", ChkApp);
                    cmd.Parameters.AddWithValue("@Status", "SAFNT");
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
                    //cmd.Parameters.AddWithValue("@CustCareApproval", ChkApp);
                    cmd.Parameters.AddWithValue("@Status", "SAFTY");
                    //cmd.Parameters.AddWithValue("@StatusTime", cusTime);
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

                    checkLoc();
                }
            }
            checkLoc();
        }

        protected void GridExp_SelectedIndexChanged(object sender, EventArgs e)
        {
            checkExp();
        }

        protected void GridLoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            checkLoc();
        }

        protected void GridLoc_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[13].Text.Trim().Equals("SAFTY"))
                {
                    e.Row.Cells[10].Enabled = true;
                }
                else if (e.Row.Cells[13].Text.Trim().Equals("SAFNT"))
                {
                    e.Row.Cells[1].BackColor = Color.LightSlateGray;
                    e.Row.Cells[10].Enabled = false;
                }
                else
                {
                    e.Row.BackColor = Color.Gray;
                    e.Row.Cells[1].Enabled = false;
                    e.Row.Cells[10].Enabled = false;
                }

                //show code
                var shipper = e.Row.Cells[3].Text;
                e.Row.Cells[3].Text = Helper.getShipper(shipper);

                //check suspension
                if (e.Row.Cells[14].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[1].Enabled = false;
                    //e.Row.Cells[7].Text = "SUSPENDED";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }

                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
            }
        }

        protected void GridExp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[13].Text.Trim().Equals("SAFTY"))
                {
                    e.Row.Cells[10].Enabled = true;
                }
                else if (e.Row.Cells[13].Text.Trim().Equals("SAFNT"))
                {
                    e.Row.Cells[1].BackColor = Color.LightSlateGray;
                    e.Row.Cells[10].Enabled = false;
                }
                else
                {
                    e.Row.BackColor = Color.Gray;
                    e.Row.Cells[1].Enabled = false;
                    e.Row.Cells[10].Enabled = false;
                }

                //show code
                var shipper = e.Row.Cells[3].Text;
                e.Row.Cells[3].Text = Helper.getShipper(shipper);

                //check suspension
                if (e.Row.Cells[14].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[1].Enabled = false;
                    //e.Row.Cells[7].Text = "SUSPENDED";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }

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
    }
}