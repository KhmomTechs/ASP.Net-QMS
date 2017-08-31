<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Reports.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="Reports.OLD.Reports_Users" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("reports").className = "active";
    </script>
    <h3>Users report according to roles</h3>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server"
                            AutoDataBind="True" EnableDatabaseLogonPrompt="False"
                            GroupTreeImagesFolderUrl="" Height="50px" ReportSourceID="UsersReportSource"
                            ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="350px"/>
    <CR:CrystalReportSource ID="UsersReportSource" runat="server">
        <Report FileName="UsersReport.rpt">
        </Report>
    </CR:CrystalReportSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>