using System;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

namespace Reports
{
    public partial class Reports_QueueReport : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                GetReport();
            }
            catch
            {
                Helper.iisRestart();

                Response.Redirect("QueueReport.aspx");
            }
        }

        private void GetReport()
        {
            var selectCurrent =
                "{CustomerCare.CustCareApproval} = True AND IsNull({NewQueue.Archived}) AND IsNull({NewQueue.Finished})";

            var reportdocument = new ReportDocument();
            reportdocument.Load(Server.MapPath("../Rpts-Crystal/QueueReport.rpt"));
            reportdocument.SetDatabaseLogon("", "", "", "Secure");
            CrystalReportViewer1.ReportSource = reportdocument;
            CrystalReportViewer1.SelectionFormula = selectCurrent;
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