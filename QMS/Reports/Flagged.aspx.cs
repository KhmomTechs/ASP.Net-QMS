using System;
using System.Globalization;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

namespace Reports
{
    public partial class Reports_Flagged : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var theDate = Request.QueryString["DATE"];

            try
            {
                if (Request.QueryString.Count > 0)
                {
                    //DateTime Mydate = Convert.ToDateTime(datepicker.Text.ToString());
                    //String.Format("{0:yyyy-MM-dd}", Mydate);

                    DateTime _date;
                    var day = "";

                    _date = DateTime.Parse(theDate);
                    day = _date.ToString("yyyy-MM-dd");

                    var selectCleared = "{Flagged.StatusTime} = '" + day + "'";
                    //string selectFormula = "{Customer.Last Year's Sales} > " + lastYearsSales.Text + " AND Mid({CusNewQueuetomer.Customer Name}, 1) > \"" + customerName.Text + "\"";

                    var reportdocument = new ReportDocument();
                    reportdocument.Load(Server.MapPath("../Rpts-Crystal/Flagged.rpt"));
                    reportdocument.SetDatabaseLogon("", "", "", "Secure");
                    CrystalReportViewer1.ReportSource = reportdocument;
                    CrystalReportViewer1.SelectionFormula = selectCleared;
                }
                else
                {
                    GetReport();
                }
            }

            catch
            {
                Helper.iisRestart();

                Response.Redirect("Flagged.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //DateTime dt = Convert.ToDateTime(datepicker.Text.ToString());
            //String.Format("{0:yyyy/MM/dd}", dt);


            var datestring = datepicker.Text;
            var dt = DateTime.ParseExact(datestring, @"MM/dd/yyyy", CultureInfo.InvariantCulture);
            Response.Redirect("Flagged.aspx?date=" + dt);
        }

        private void GetReport()
        {
            //(NewQueue.Archived IS NULL) AND (Operations.Cleared = 'True')
            //string selectCleared = "{NewQueue.Finished} = True";
            //string selectFormula = "{Customer.Last Year's Sales} > " + lastYearsSales.Text + " AND Mid({CusNewQueuetomer.Customer Name}, 1) > \"" + customerName.Text + "\"";

            var reportdocument = new ReportDocument();
            reportdocument.Load(Server.MapPath("../Rpts-Crystal/Flagged.rpt"));
            reportdocument.SetDatabaseLogon("", "", "", "Secure");
            CrystalReportViewer1.ReportSource = reportdocument;
            //CrystalReportViewer1.SelectionFormula = selectCleared;
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            var reportdocument = new ReportDocument();
            CrystalReportViewer1.Dispose();
            reportdocument.Close();
            reportdocument.Dispose();
        }
    }
}