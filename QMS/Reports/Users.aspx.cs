using System;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

namespace Reports
{
    public partial class Reports_Users : Page
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

                Response.Redirect("Users.aspx");
            }
        }

        private void GetReport()
        {
            var reportdocument = new ReportDocument();
            reportdocument.Load(Server.MapPath("../Rpts-Crystal/UsersReport.rpt"));
            reportdocument.SetDatabaseLogon("", "", "", "Secure");
            CrystalReportViewer1.ReportSource = reportdocument;
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