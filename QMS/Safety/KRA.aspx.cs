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
    public partial class Safety_KRA : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            checkAll();
            EntrySource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            GridEntries.DataBind();
            if (IsPostBack)
            {
                checkAll();
            }
        }

        protected void GridEntries_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            e.NewValues["FinishTime"] = DateTime.Now;

            e.NewValues["StatusTime"] = DateTime.Now;

            e.NewValues["Status"] = "FIN";
        }

        protected void GridEntries_SelectedIndexChanged(object sender, EventArgs e)
        {
            checkAll();
        }

        private void checkAll()
        {
            foreach (GridViewRow row in GridEntries.Rows)
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

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
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
                    cmd.Parameters.AddWithValue("@Status", "UNCLR");
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

                    GridEntries.DataBind();
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
                    cmd.Parameters.AddWithValue("@Status", "LODCLE");
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
                }
            }
            checkAll();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
        }

        protected void rptUnavaile_Click(object sender, EventArgs e)
        {
            var strSql = new StringBuilder(string.Empty);
            var con = new SqlConnection(strConnection);
            var conQueue = new SqlConnection(strConnection);
            var cmd = new SqlCommand();

            foreach (GridViewRow row in GridEntries.Rows)
            {
                for (var i = 0; i < GridEntries.Rows.Count; i++)
                {
                    var strID = GridEntries.Rows[i].Cells[12].Text;
                    //string Appr = GridEntries.Rows[i].Cells[1].Text;
                    var ChkApp =
                        (GridEntries.Rows[i].Cells[0].FindControl("RadioButtonList1") as RadioButtonList).SelectedValue;
                    var cusTime = DateTime.Now;
                    //string named = this.User.Identity.Name;


                    if (
                        (GridEntries.Rows[i].Cells[0].FindControl("RadioButtonList1") as RadioButtonList).SelectedValue ==
                        "False")
                    {
                        //string strUpdate = "Update Details set Name = '" + strName + "', Location = '" + strLocation + "' WHERE ID ='" + strID +"'" +";" ;
                        //strSql.Append(strUpdate);
                        try
                        {
                            const string strQueueUpdate =
                                "Update NewQueue set Status = @Status, StatusTime = @StatusTime WHERE ID = @ID";
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = strQueueUpdate;
                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@Status", "UNCLR");
                            cmd.Parameters.AddWithValue("@StatusTime", cusTime);
                            cmd.Parameters.AddWithValue("@ID", strID);
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
                        }
                    }
                    else
                    {
                        try
                        {
                            const string strQueueUpdate =
                                "Update NewQueue set Status = @Status, StatusTime = @StatusTime WHERE ID = @ID";
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = strQueueUpdate;
                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("@Status", "LODCLE");
                            cmd.Parameters.AddWithValue("@StatusTime", cusTime);
                            cmd.Parameters.AddWithValue("@ID", strID);
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
                        }
                    }
                }
            }
        }

        protected void GridEntries_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[10].Text.Trim().Equals("LODCLE"))
                {
                }
                else if (e.Row.Cells[10].Text.Trim().Equals("OMCCLE"))
                {
                }
                else if (e.Row.Cells[11].Text.Trim().Equals("True"))
                {
                    e.Row.BackColor = Color.Gray;
                    e.Row.Cells[1].Enabled = false;
                    e.Row.Cells[7].Enabled = false;
                }
                else if (e.Row.Cells[10].Text.Trim().Equals("UNCLR"))
                {
                    e.Row.Cells[1].BackColor = Color.LightSlateGray;
                    e.Row.Cells[7].Enabled = false;
                }
                else
                {
                    e.Row.BackColor = Color.Gray;
                    e.Row.Cells[1].Enabled = false;
                    e.Row.Cells[7].Enabled = false;
                }

                //check suspension
                if (e.Row.Cells[12].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[1].Enabled = false;
                    //e.Row.Cells[7].Text = "SUSPENDED";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }

                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Center;

                //show code
                var shipper = e.Row.Cells[5].Text;
                e.Row.Cells[5].Text = Helper.getShipper(shipper);
            }
        }
    }
}