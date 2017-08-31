using System;
using System.Configuration;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pipecor
{
    public partial class Pipecor_HiddenEdit : Page
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
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //if (e.Row.Cells[8].Text.Trim().Equals("CALLED TO LOADING BAY"))
                //{
                //    try
                //    {
                //        e.Row.ForeColor = System.Drawing.Color.Green;
                //        using (SqlConnection conn = new SqlConnection(strConnection))
                //        {

                //            string result = "SELECT STATUS FROM [dbo].[PS28orders] WHERE ORDER_NO = @id";
                //            string compareId = e.Row.Cells[4].Text.Trim();
                //            SqlCommand showresult = new SqlCommand(result, conn);
                //            showresult.Parameters.AddWithValue("id", compareId);

                //            conn.Open();
                //            string showing = showresult.ExecuteScalar().ToString();
                //            int status = Convert.ToInt32(showing);

                //            if (status == 1)
                //            {
                //                e.Row.Cells[8].Text = "ENTERING";
                //            }
                //            else if (status == 2)
                //            {
                //                e.Row.Cells[8].Text = "DISPATCHED";
                //            }
                //            else if (status == 3)
                //            {
                //                e.Row.Cells[8].Text = "VALIDATING";
                //            }
                //            else if (status == 4)
                //            {
                //                e.Row.Cells[8].Text = "WAITING TO LOAD";
                //            }
                //            else if (status == 5)
                //            {
                //                e.Row.Cells[8].Text = "LOADED";
                //            }
                //            else if (status == 6)
                //            {
                //                e.Row.Cells[8].Text = "CANCELLED";
                //            }
                //            else if (status == 7)
                //            {
                //                e.Row.Cells[8].Text = "LOADING AT BAY";
                //            }
                //            else if (status == 8)
                //            {
                //                e.Row.Cells[8].Text = "AUTHORIZED";
                //            }
                //            else if (status == null)
                //            {
                //                e.Row.Cells[8].Text = "";
                //            }
                //            else
                //            {
                //                e.Row.Cells[8].Text = showing;
                //            }
                //            conn.Close();
                //        }
                //    }
                //    catch
                //    {
                //        e.Row.ForeColor = System.Drawing.Color.Red;
                //        e.Row.Cells[8].Text = "ENTER TO LOAD";
                //    }
                //}

                //else if (e.Row.Cells[8].Text.Trim().Equals("CUSTOMER CARE"))
                //{
                //    try
                //    {
                //        using (SqlConnection conn = new SqlConnection(strConnection))
                //        {

                //            string result = "SELECT STATUS FROM [dbo].[PS28orders] WHERE ORDER_NO = @id";
                //            string compareId = e.Row.Cells[4].Text.Trim();
                //            SqlCommand showresult = new SqlCommand(result, conn);
                //            showresult.Parameters.AddWithValue("id", compareId);

                //            conn.Open();
                //            string showing = showresult.ExecuteScalar().ToString();
                //            int status = Convert.ToInt32(showing);

                //            if (status == 0 || status == 1 || status == 2 || status == 3 || status == 4 || status == 5 || status == 6 || status == 7 || status == 8)
                //            {
                //                e.Row.BackColor = System.Drawing.Color.Red;
                //                e.Row.ForeColor = System.Drawing.Color.White;
                //                e.Row.Cells[8].Text = "UNAUTHORIZED";
                //            }
                //            conn.Close();
                //        }
                //    }
                //    catch
                //    {
                //        e.Row.Cells[8].Text = "CUSTOMER CARE";
                //    }
                //}
                //else if (e.Row.Cells[8].Text.Trim().Equals("SAFETY CONCERNS"))
                //{
                //    e.Row.ForeColor = System.Drawing.Color.Blue;
                //}
                //else if (e.Row.Cells[8].Text.Trim().Equals("SECURITY CONCERNS"))
                //{
                //    e.Row.ForeColor = System.Drawing.Color.Blue;
                //}
                //else if (e.Row.Cells[8].Text.Trim().Equals("STOCK CONTROL"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.Orange;
                //}
                //else if (e.Row.Cells[8].Text.Trim().Equals("DISPATCH"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.LightSeaGreen;
                //}
                //else if (e.Row.Cells[8].Text.Trim().Equals("SAFETY"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.LightSalmon;
                //}
                //else if (e.Row.Cells[8].Text.Trim().Equals("SECURITY"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.LightSkyBlue;
                //}
                //else if (e.Row.Cells[8].Text.Trim().Equals("OMC CLEARANCE"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.Yellow;
                //}
                ////check if entitled
                //if (e.Row.Cells[10].Text.Trim().Equals("False"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.Wheat;
                //    e.Row.Cells[8].Text = "NO ENTITLEMENT";
                //}
                //else if (e.Row.Cells[10].Text.Trim().Equals("Clear"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.Wheat;
                //    e.Row.Cells[8].Text = "ENTITLEMENT CLEARANCE";
                //}

                ////check suspension
                //if (e.Row.Cells[11].Text.Trim().Equals("True"))
                //{
                //    e.Row.Cells[8].Text = "SUSPENDED";
                //    e.Row.ForeColor = System.Drawing.Color.White;
                //    e.Row.BackColor = System.Drawing.Color.DimGray;
                //}

                //check rejected
                if (e.Row.Cells[8].Text.Trim().Equals("REJECTED-C CARE"))
                {
                    e.Row.BackColor = Color.Yellow;
                }
                else if (e.Row.Cells[8].Text.Trim().Equals("REJECTED BY D.MANAGER"))
                {
                    e.Row.BackColor = Color.Yellow;
                }

                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Left;
            }
        }

        protected void GridExp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //if (e.Row.Cells[7].Text.Trim().Equals("CALLED TO LOADING BAY"))
                //{
                //    try
                //    {
                //        e.Row.ForeColor = System.Drawing.Color.Green;
                //        using (SqlConnection conn = new SqlConnection(strConnection))
                //        {

                //            string result = "SELECT STATUS FROM [dbo].[PS28orders] WHERE ORDER_NO = @id";
                //            string compareId = e.Row.Cells[4].Text.Trim();
                //            SqlCommand showresult = new SqlCommand(result, conn);
                //            showresult.Parameters.AddWithValue("id", compareId);

                //            conn.Open();
                //            string showing = showresult.ExecuteScalar().ToString();
                //            int status = Convert.ToInt32(showing);

                //            if (status == 1)
                //            {
                //                e.Row.Cells[7].Text = "ENTERING";
                //            }
                //            else if (status == 2)
                //            {
                //                e.Row.Cells[7].Text = "DISPATCHED";
                //            }
                //            else if (status == 3)
                //            {
                //                e.Row.Cells[7].Text = "VALIDATING";
                //            }
                //            else if (status == 4)
                //            {
                //                e.Row.Cells[7].Text = "WAITING TO LOAD";
                //            }
                //            else if (status == 5)
                //            {
                //                e.Row.Cells[7].Text = "LOADED";
                //            }
                //            else if (status == 6)
                //            {
                //                e.Row.Cells[7].Text = "CANCELLED";
                //            }
                //            else if (status == 7)
                //            {
                //                e.Row.Cells[7].Text = "LOADING AT BAY";
                //            }
                //            else if (status == 8)
                //            {
                //                e.Row.Cells[7].Text = "AUTHORIZED";
                //            }
                //            else if (status == 0)
                //            {
                //                e.Row.Cells[7].Text = "";
                //            }
                //            else
                //            {
                //                e.Row.Cells[7].Text = showing;
                //            }
                //            conn.Close();
                //        }
                //    }
                //    catch
                //    {
                //        e.Row.ForeColor = System.Drawing.Color.Red;
                //        e.Row.Cells[7].Text = "ENTER TO LOAD";
                //    }
                //}

                //else if (e.Row.Cells[7].Text.Trim().Equals("CUSTOMER CARE"))
                //{
                //    try
                //    {
                //        using (SqlConnection conn = new SqlConnection(strConnection))
                //        {

                //            string result = "SELECT STATUS FROM [dbo].[PS28orders] WHERE ORDER_NO = @id";
                //            string compareId = e.Row.Cells[4].Text.Trim();
                //            SqlCommand showresult = new SqlCommand(result, conn);
                //            showresult.Parameters.AddWithValue("id", compareId);

                //            conn.Open();
                //            string showing = showresult.ExecuteScalar().ToString();
                //            int status = Convert.ToInt32(showing);

                //            if (status == 0 || status == 1 || status == 2 || status == 3 || status == 4 || status == 5 || status == 6 || status == 7 || status == 8)
                //            {
                //                e.Row.BackColor = System.Drawing.Color.Red;
                //                e.Row.ForeColor = System.Drawing.Color.White;
                //                e.Row.Cells[7].Text = "UNAUTHORIZED";
                //            }
                //            conn.Close();
                //        }
                //    }
                //    catch
                //    {
                //        e.Row.Cells[7].Text = "CUSTOMER CARE";
                //    }
                //}
                //else if (e.Row.Cells[7].Text.Trim().Equals("SAFETY CONCERNS"))
                //{
                //    e.Row.ForeColor = System.Drawing.Color.Blue;
                //}
                //else if (e.Row.Cells[7].Text.Trim().Equals("SECURITY CONCERNS"))
                //{
                //    e.Row.ForeColor = System.Drawing.Color.Blue;
                //}
                //else if (e.Row.Cells[7].Text.Trim().Equals("STOCK CONTROL"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.Orange;
                //}
                //else if (e.Row.Cells[7].Text.Trim().Equals("DISPATCH"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.LightSeaGreen;
                //}
                //else if (e.Row.Cells[7].Text.Trim().Equals("SAFETY"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.LightSalmon;
                //}
                //else if (e.Row.Cells[7].Text.Trim().Equals("SECURITY"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.LightSkyBlue;
                //}
                //else if (e.Row.Cells[7].Text.Trim().Equals("OMC CLEARANCE"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.Yellow;
                //}
                ////check if entitled
                //if (e.Row.Cells[9].Text.Trim().Equals("False"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.Wheat;
                //    e.Row.Cells[7].Text = "NO ENTITLEMENT";
                //}
                //else if (e.Row.Cells[9].Text.Trim().Equals("Clear"))
                //{
                //    e.Row.BackColor = System.Drawing.Color.Wheat;
                //    e.Row.Cells[7].Text = "ENTITLEMENT CLEARANCE";
                //}

                ////check suspension
                //if (e.Row.Cells[10].Text.Trim().Equals("True"))
                //{
                //    e.Row.Cells[7].Text = "SUSPENDED";
                //    e.Row.ForeColor = System.Drawing.Color.White;
                //    e.Row.BackColor = System.Drawing.Color.DimGray;
                //}

                //check rejected
                if (e.Row.Cells[7].Text.Trim().Equals("REJECTED-C CARE"))
                {
                    e.Row.BackColor = Color.Yellow;
                }
                else if (e.Row.Cells[7].Text.Trim().Equals("REJECTED BY D.MANAGER"))
                {
                    e.Row.BackColor = Color.Yellow;
                }

                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
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
    }
}