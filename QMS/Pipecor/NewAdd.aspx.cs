using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pipecor
{
    public partial class Pipecor_NewAdd : Page
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
            GridLocal.DataBind();
            GridExp.DataBind();
        }

        protected void GridLocal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //check finished
                if (e.Row.Cells[7].Text.Trim().Equals("FIN"))
                {
                    e.Row.BackColor = Color.Black;
                    e.Row.ForeColor = Color.Red;
                }

                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Left;
            }
        }

        protected void GridExp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //check finished
                if (e.Row.Cells[6].Text.Trim().Equals("FIN"))
                {
                    e.Row.BackColor = Color.Black;
                    e.Row.ForeColor = Color.Red;
                }

                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Left;
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

        protected void BtnAddExport_Click(object sender, EventArgs e)
        {
            var currentUser = Membership.GetUser();
            var currentUserId = (Guid) currentUser.ProviderUserKey;
            var named = User.Identity.Name;

            var objcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

            var newQueueId = Guid.NewGuid().ToString();
            var statusTime = DateTime.Today;

            var No = (TextBox) GridExp.FooterRow.FindControl("No");
            var Shipper = (TextBox) GridExp.FooterRow.FindControl("Shipper");
            var Registration = (TextBox) GridExp.FooterRow.FindControl("Registration");
            var LO_NO = (TextBox) GridExp.FooterRow.FindControl("LO_NO");
            var Quantity = (TextBox) GridExp.FooterRow.FindControl("Quantity");
            var Product = (DropDownList) GridExp.FooterRow.FindControl("Product");


            //int Nom = GridExp.Rows.Count + 1;

            var query =
                "INSERT INTO NewQueue([Queue_No],[Shipper],[Registration],[Type],[LO_NO],[Product],[Quantity],[Status],[UserId],[QueueID],[EnterName],[SetDate],[StatusTime]) values ('" +
                No.Text + "','" + Shipper.Text + "','" + Registration.Text + "','Export','" + LO_NO.Text + "','" +
                Product.SelectedValue + "','" + Quantity.Text + "','SECTA','" + currentUserId + "','" + newQueueId +
                "','" + named + "','" + statusTime + "','" + statusTime + "');";
            var objda = new SqlDataAdapter(query, objcon);
            objcon.Open();
            objda.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query0 = "INSERT INTO CustomerCare([QueueID]) values('" + newQueueId + "');";
            var objda0 = new SqlDataAdapter(query0, objcon);
            objcon.Open();
            objda0.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query1 = "INSERT INTO SafetySecurity_A([QueueID]) values('" + newQueueId + "');";
            var objda1 = new SqlDataAdapter(query1, objcon);
            objcon.Open();
            objda1.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query2 = "INSERT INTO SafetySecurity_B([QueueID]) values('" + newQueueId + "');";
            var objda2 = new SqlDataAdapter(query2, objcon);
            objcon.Open();
            objda2.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query3 = "INSERT INTO SafetySecurity_C([QueueID]) values('" + newQueueId + "');";
            var objda3 = new SqlDataAdapter(query3, objcon);
            objcon.Open();
            objda3.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query4 = "INSERT INTO Operations([QueueID]) values('" + newQueueId + "');";
            var objda4 = new SqlDataAdapter(query4, objcon);
            objcon.Open();
            objda4.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query5 = "INSERT INTO KRA([QueueID]) values('" + newQueueId + "');";
            var objda5 = new SqlDataAdapter(query5, objcon);
            objcon.Open();
            objda5.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query6 = "INSERT INTO StockControl([QueueID]) values('" + newQueueId + "');";
            var objda6 = new SqlDataAdapter(query6, objcon);
            objcon.Open();
            objda6.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            Response.Redirect("NewAdd.aspx?view=Export");
        }

        protected void BtnAddLocal_Click(object sender, EventArgs e)
        {
            var currentUser = Membership.GetUser();
            var currentUserId = (Guid) currentUser.ProviderUserKey;
            var named = User.Identity.Name;

            var objcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

            var newQueueId = Guid.NewGuid().ToString();
            var statusTime = DateTime.Today;

            var No = (TextBox) GridLocal.FooterRow.FindControl("No");
            var Shipper = (TextBox) GridLocal.FooterRow.FindControl("Shipper");
            var Registration = (TextBox) GridLocal.FooterRow.FindControl("Registration");
            var LO_NO = (TextBox) GridLocal.FooterRow.FindControl("LO_NO");
            var Quantity = (TextBox) GridLocal.FooterRow.FindControl("Quantity");
            var Product = (TextBox) GridLocal.FooterRow.FindControl("Product");
            var MSP = (TextBox) GridLocal.FooterRow.FindControl("MSP");
            var AGO = (TextBox) GridLocal.FooterRow.FindControl("AGO");
            var KERO = (TextBox) GridLocal.FooterRow.FindControl("KERO");

            //int Nom = GridLocal.Rows.Count + 1;

            var query =
                "INSERT INTO NewQueue([Queue_No],[Shipper],[Registration],[Type],[LO_NO],[MSP],[AGO],[KERO],[Status],[UserId],[QueueID],[EnterName],[SetDate],[StatusTime]) values('" +
                No.Text + "','" + Shipper.Text + "','" + Registration.Text + "','Local','" + LO_NO.Text + "','" +
                MSP.Text + "','" + AGO.Text + "','" + KERO.Text + "','SECTA','" + currentUserId + "','" + newQueueId +
                "','" + named + "','" + statusTime + "','" + statusTime + "');";
            var objda = new SqlDataAdapter(query, objcon);
            objcon.Open();
            objda.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query0 = "INSERT INTO CustomerCare([QueueID]) values('" + newQueueId + "');";
            var objda0 = new SqlDataAdapter(query0, objcon);
            objcon.Open();
            objda0.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query1 = "INSERT INTO SafetySecurity_A([QueueID]) values('" + newQueueId + "');";
            var objda1 = new SqlDataAdapter(query1, objcon);
            objcon.Open();
            objda1.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query2 = "INSERT INTO SafetySecurity_B([QueueID]) values('" + newQueueId + "');";
            var objda2 = new SqlDataAdapter(query2, objcon);
            objcon.Open();
            objda2.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query3 = "INSERT INTO SafetySecurity_C([QueueID]) values('" + newQueueId + "');";
            var objda3 = new SqlDataAdapter(query3, objcon);
            objcon.Open();
            objda3.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query4 = "INSERT INTO Operations([QueueID]) values('" + newQueueId + "');";
            var objda4 = new SqlDataAdapter(query4, objcon);
            objcon.Open();
            objda4.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query5 = "INSERT INTO KRA([QueueID]) values('" + newQueueId + "');";
            var objda5 = new SqlDataAdapter(query5, objcon);
            objcon.Open();
            objda5.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query6 = "INSERT INTO StockControl([QueueID]) values('" + newQueueId + "');";
            var objda6 = new SqlDataAdapter(query6, objcon);
            objcon.Open();
            objda6.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            Response.Redirect("NewAdd.aspx?view=Local");
        }
    }
}