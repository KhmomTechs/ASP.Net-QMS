using System;
using System.Globalization;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

namespace Reports.OLD
{
    public partial class Reports_KRA : Page
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

                    var selectFormula =
                        "{SafetySecurity_C.Failed} = True AND {SafetySecurity_C.Passed} = True AND {NewQueue.EnterTime} = '" +
                        day + "'";

                    var reportdocument = new ReportDocument();
                    reportdocument.Load(Server.MapPath("../Rpts-Crystal/FailedKRAReport.rpt"));
                    reportdocument.SetDatabaseLogon("", "", "", "Secure");
                    CrystalReportViewer1.ReportSource = reportdocument;
                    CrystalReportViewer1.SelectionFormula = selectFormula;
                }
                else
                {
                    GetMethod();
                }
            }
            catch
            {
                Helper.iisRestart();

                Response.Redirect("KRA.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //DateTime dt = Convert.ToDateTime(datepicker.Text.ToString());
            //String.Format("{0:yyyy/MM/dd}", dt);


            var datestring = datepicker.Text;
            var dt = DateTime.ParseExact(datestring, @"MM/dd/yyyy", CultureInfo.InvariantCulture);
            Response.Redirect("KRA.aspx?date=" + dt);
        }

        private void GetMethod()
        {
            var selectFormula = "{SafetySecurity_C.Failed} = True AND {SafetySecurity_C.Passed} = True";

            var reportdocument = new ReportDocument();
            reportdocument.Load(Server.MapPath("../Rpts-Crystal/FailedKRAReport.rpt"));
            reportdocument.SetDatabaseLogon("", "", "", "Secure");
            CrystalReportViewer1.ReportSource = reportdocument;
            CrystalReportViewer1.SelectionFormula = selectFormula;
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