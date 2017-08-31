using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Operations
{
    public partial class Operations_Suspend : Page
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
                Response.Redirect("Suspend.aspx?view=local");
                PanelExp.Visible = false;
                PanelLoc.Visible = true;

                //show = "local";
            }
        }

        protected void ExpSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Response.Redirect("Suspend.aspx?view=export");
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
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Center;
            }
        }

        protected void GridLocal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Center;
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

        protected void GridExp_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridExp.PageIndex = e.NewPageIndex;
        }

        protected void GridLocal_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridLocal.PageIndex = e.NewPageIndex;
        }

        protected void ExpSuspension_CheckedChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var ExpSuspension = (CheckBox) sender;

                var grdRow = (GridViewRow) ExpSuspension.NamingContainer;

                var lblID = (Label) grdRow.FindControl("Label1");

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;
                //string nothing = "";

                if (ExpSuspension.Checked)
                {
                    try
                    {
                        const string strUpdate =
                            "Update NewQueue set Suspended = @Suspended, SuspendedTime = @SuspendedTime, Suspender = @Suspender WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Suspended", true);
                        cmd.Parameters.AddWithValue("@SuspendedTime", cusTime);
                        cmd.Parameters.AddWithValue("@Suspender", named);
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
                        conQueue.Close();
                    }
                }
                else if (ExpSuspension.Checked == false)
                {
                    try
                    {
                        const string strUpdate =
                            "Update NewQueue set Suspended = @Suspended, UnSuspendedTime = @UnSuspendedTime, UnSuspender = @UnSuspender WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Suspended", false);
                        cmd.Parameters.AddWithValue("@UnSuspendedTime", cusTime);
                        cmd.Parameters.AddWithValue("@UnSuspender", named);
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
                        conQueue.Close();
                    }
                }
            }
        }

        protected void ExpWithdrawal_CheckedChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var ExpWithdrawal = (CheckBox) sender;

                var grdRow = (GridViewRow) ExpWithdrawal.NamingContainer;

                var lblID = (Label) grdRow.FindControl("Label1");

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;
                //string nothing = "";

                if (ExpWithdrawal.Checked)
                {
                    try
                    {
                        const string strUpdate =
                            "Update NewQueue set Withdrawal = @Withdrawal, WithdrawalTime = @WithdrawalTime, Withdrawer = @Withdrawer WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Withdrawal", true);
                        cmd.Parameters.AddWithValue("@WithdrawalTime", cusTime);
                        cmd.Parameters.AddWithValue("@Withdrawer", named);
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
                        conQueue.Close();
                    }
                }
                else if (ExpWithdrawal.Checked == false)
                {
                    try
                    {
                        const string strUpdate =
                            "Update NewQueue set Withdrawal = @Withdrawal, UnWithdrawalTime = @UnWithdrawalTime, UnWithdrawer = @UnWithdrawer WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Withdrawal", false);
                        cmd.Parameters.AddWithValue("@UnWithdrawalTime", cusTime);
                        cmd.Parameters.AddWithValue("@UnWithdrawer", named);
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
                        conQueue.Close();
                    }
                }
            }
        }

        protected void LocSuspension_CheckedChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var LocSuspension = (CheckBox) sender;

                var grdRow = (GridViewRow) LocSuspension.NamingContainer;

                var lblID = (Label) grdRow.FindControl("Label1");

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;
                //string nothing = "";

                if (LocSuspension.Checked)
                {
                    try
                    {
                        const string strUpdate =
                            "Update NewQueue set Suspended = @Suspended, SuspendedTime = @SuspendedTime, Suspender = @Suspender WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Suspended", true);
                        cmd.Parameters.AddWithValue("@SuspendedTime", cusTime);
                        cmd.Parameters.AddWithValue("@Suspender", named);
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
                        conQueue.Close();
                    }
                }
                else if (LocSuspension.Checked == false)
                {
                    try
                    {
                        const string strUpdate =
                            "Update NewQueue set Suspended = @Suspended, UnSuspendedTime = @UnSuspendedTime, UnSuspender = @UnSuspender WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Suspended", false);
                        cmd.Parameters.AddWithValue("@UnSuspendedTime", cusTime);
                        cmd.Parameters.AddWithValue("@UnSuspender", named);
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
                        conQueue.Close();
                    }
                }
            }
        }

        protected void LocWithdrawal_CheckedChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var LocWithdrawal = (CheckBox) sender;

                var grdRow = (GridViewRow) LocWithdrawal.NamingContainer;

                var lblID = (Label) grdRow.FindControl("Label1");

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;
                //string nothing = "";

                if (LocWithdrawal.Checked)
                {
                    try
                    {
                        const string strUpdate =
                            "Update NewQueue set Withdrawal = @Withdrawal, WithdrawalTime = @WithdrawalTime, Withdrawer = @Withdrawer WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Withdrawal", true);
                        cmd.Parameters.AddWithValue("@WithdrawalTime", cusTime);
                        cmd.Parameters.AddWithValue("@Withdrawer", named);
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
                        conQueue.Close();
                    }
                }
                else if (LocWithdrawal.Checked == false)
                {
                    try
                    {
                        const string strUpdate =
                            "Update NewQueue set Withdrawal = @Withdrawal, UnWithdrawalTime = @UnWithdrawalTime, UnWithdrawer = @UnWithdrawer WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Withdrawal", false);
                        cmd.Parameters.AddWithValue("@UnWithdrawalTime", cusTime);
                        cmd.Parameters.AddWithValue("@UnWithdrawer", named);
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
                        conQueue.Close();
                    }
                }
            }
        }

        protected void btnLocComment_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var btnLocComment = (Button) sender;
                var grdRow = (GridViewRow) btnLocComment.NamingContainer;
                var txtComment = (TextBox) grdRow.FindControl("txtLocComment");
                var lblID = (Label) grdRow.FindControl("Label1");

                if (txtComment.Text == "" || txtComment.Text == null || txtComment.Text == string.Empty)
                {
                    txtComment.BorderColor = Color.Red;
                }
                else
                {
                    var cusTime = DateTime.Now;
                    var named = User.Identity.Name;

                    try
                    {
                        const string strUpdate =
                            "Update NewQueue set Reason = @Reason, ReasonTime = @ReasonTime, Reasoner = @Reasoner WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Reason", txtComment.Text);
                        cmd.Parameters.AddWithValue("@ReasonTime", cusTime);
                        cmd.Parameters.AddWithValue("@Reasoner", named);
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

        protected void btnExpComment_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var btnExpComment = (Button) sender;
                var grdRow = (GridViewRow) btnExpComment.NamingContainer;
                var txtComment = (TextBox) grdRow.FindControl("txtExpComment");
                var lblID = (Label) grdRow.FindControl("Label1");

                if (txtComment.Text == "" || txtComment.Text == null || txtComment.Text == string.Empty)
                {
                    txtComment.BorderColor = Color.Red;
                }
                else
                {
                    var cusTime = DateTime.Now;
                    var named = User.Identity.Name;

                    try
                    {
                        const string strUpdate =
                            "Update NewQueue set Reason = @Reason, ReasonTime = @ReasonTime, Reasoner = @Reasoner WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Reason", txtComment.Text);
                        cmd.Parameters.AddWithValue("@ReasonTime", cusTime);
                        cmd.Parameters.AddWithValue("@Reasoner", named);
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
    }
}