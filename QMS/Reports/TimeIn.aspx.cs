using System;
using System.Globalization;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

namespace Reports
{
    public partial class Reports_TimeIn : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var theDate = Request.QueryString["DATE"];

            if (Request.QueryString.Count > 0)
            {
                ////DateTime Mydate = Convert.ToDateTime(datepicker.Text.ToString());
                ////String.Format("{0:yyyy-MM-dd}", Mydate);

                //DateTime _date;
                //string day = "";

                //_date = DateTime.Parse(theDate);
                //day = _date.ToString("yyyy-MM-dd");

                //string selectFinished = "{NewQueue.Finished} = True AND {NewQueue.EnterTime} = '" + day + "'";

                //DateTime Mydate = Convert.ToDateTime(theDate);
                //string day = Mydate.ToString("yyyy-MM-dd HH:mm:ss");
                //DateTime _date = DateTime.Parse(day);

                //day = _date.Year + "," + _date.Month + "," + _date.Day + "," + _date.Hour + "," + _date.Minute + "," + _date.Second;


                //string selectFinished = " {NewQueue.SetDate} =  [CDATETIME(" + day + ")]";
                //ReportDocument reportdocument = new ReportDocument();
                //reportdocument.Load(Server.MapPath("../Rpts-Crystal/TimeIn.rpt"));
                //reportdocument.SetDatabaseLogon("", "", "", "Secure");
                //CrystalReportViewer1.ReportSource = reportdocument;
                //CrystalReportViewer1.SelectionFormula = selectFinished;
                GetReport();
            }
            else
            {
                GetReport();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //DateTime dt = Convert.ToDateTime(datepicker.Text.ToString());
            //String.Format("{0:yyyy/MM/dd}", dt);


            var datestring = datepicker.Text;
            var dt = DateTime.ParseExact(datestring, @"MM/dd/yyyy", CultureInfo.InvariantCulture);
            Response.Redirect("TimeIn.aspx?date=" + dt);
        }

        private void GetReport()
        {
            var theDate = DateTime.Today.ToString("yyyy-MM-dd");


            var Mydate = Convert.ToDateTime(theDate);
            var day = Mydate.ToString("yyyy-MM-dd HH:mm:ss");
            var _date = DateTime.Parse(day);

            day = _date.Year + "," + _date.Month + "," + _date.Day + "," + _date.Hour + "," + _date.Minute + "," +
                  _date.Second;
            var selectFinished = "{NewQueue.SetDate} =  [CDATETIME(" + day + ")]";


            var reportdocument = new ReportDocument();
            reportdocument.Load(Server.MapPath("../Rpts-Crystal/TimeIn.rpt"));
            reportdocument.SetDatabaseLogon("", "", "", "Secure");
            CrystalReportViewer1.ReportSource = reportdocument;
            CrystalReportViewer1.SelectionFormula = selectFinished;
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