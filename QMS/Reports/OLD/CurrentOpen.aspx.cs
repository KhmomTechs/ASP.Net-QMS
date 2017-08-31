using System;
using System.Globalization;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

namespace Reports.OLD
{
    public partial class Reports_CurrentOpen : Page
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

                    var selectCurrent =
                        "{CustomerCare.CustCareApproval} = True AND IsNull({NewQueue.Archived}) AND IsNull({NewQueue.Finished}) AND {NewQueue.EnterTime} = '" +
                        day + "'";

                    var reportdocument = new ReportDocument();
                    reportdocument.Load(Server.MapPath("../Rpts-Crystal/CurrentOpen.rpt"));
                    reportdocument.SetDatabaseLogon("", "", "", "Secure");
                    CrystalReportViewer1.ReportSource = reportdocument;
                    CrystalReportViewer1.SelectionFormula = selectCurrent;
                }
                else
                {
                    GetReport();
                }
            }
            catch
            {
                Helper.iisRestart();

                Response.Redirect("CurrentOpen.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //DateTime dt = Convert.ToDateTime(datepicker.Text.ToString());
            //String.Format("{0:yyyy/MM/dd}", dt);


            var datestring = datepicker.Text;
            var dt = DateTime.ParseExact(datestring, @"MM/dd/yyyy", CultureInfo.InvariantCulture);
            Response.Redirect("CurrentOpen.aspx?date=" + dt);
        }

        private void GetReport()
        {
            var date = DateTime.Today;
            var day = date.ToString("yyyy-MM-dd");

            //string selectRejected = "{CustomerCare.CustCareApproval} = True AND {NewQueue.EnterTime} = '" + day + "'";

            var selectCurrent =
                "{CustomerCare.CustCareApproval} = True AND IsNull({NewQueue.Archived}) AND IsNull({NewQueue.Finished}) AND {NewQueue.EnterTime} = '" +
                day + "'";

            var reportdocument = new ReportDocument();
            reportdocument.Load(Server.MapPath("../Rpts-Crystal/CurrentOpen.rpt"));
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