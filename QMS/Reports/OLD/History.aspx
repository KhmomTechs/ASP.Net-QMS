<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Reports.master" AutoEventWireup="true" CodeFile="History.aspx.cs" Inherits="Reports.OLD.Reports_History" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script src="../Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.core.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.widget.js" type="text/javascript"></script>
    <link href="../Styles/jquery.ui.all.css" rel="stylesheet" type="text/css"/>
    <link href="../Scripts/jquery.ui.datepicker.css" rel="stylesheet" type="text/css"/>
    <script src="../Scripts/jquery.ui.datepicker.js" type="text/javascript"></script>

    <script language="javascript">
        document.getElementById("history").className = "active";


        $(function() {
            $("#datepicker").datepicker();

        });
    </script>
    <h3>Specific Truck History</h3>
    <table style="width: 1120px;">
        <tr>
            <td style="text-align: left; vertical-align: text-top; width: 920px;">
                <asp:Label ID="lblReportResult" Font-Bold="true" runat="server"></asp:Label>
                <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server"
                                        AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="50px"
                                        ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl=""
                                        ToolPanelWidth="100px" Width="350px" ToolPanelView="None"/>
                <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
                    <Report FileName="History.rpt">
                    </Report>
                </CR:CrystalReportSource>
            </td>
            <td style="text-align: left; vertical-align: text-top; width: 200px;">
                <p>
                    Date:<br/>
                    <asp:TextBox ID="datepicker" runat="server" ClientIDMode="Static" Width="60px">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="ReqDate" runat="server" ValidationGroup="theDate" ControlToValidate="datepicker" ErrorMessage="*"></asp:RequiredFieldValidator>
                </p>
                <p>
                    Type:<br/>
                    <asp:DropDownList ID="DropType" runat="server" Width="60px">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                        <asp:ListItem Text="Local" Value="Local"></asp:ListItem>
                        <asp:ListItem Text="Export" Value="Export"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="ReqType" runat="server" ValidationGroup="theDate" ControlToValidate="DropType" InitialValue="" ErrorMessage="*"></asp:RequiredFieldValidator>
                </p>
                <p>
                    No:<br/>
                    <asp:TextBox ID="txtNo" runat="server" ClientIDMode="Static" MaxLength="3" Width="60px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="ReqNo" runat="server" ValidationGroup="theDate" ControlToValidate="txtNo" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                    <asp:CompareValidator ID="CompareTextTrail" ValidationGroup="theDate" runat="server" ControlToValidate="txtNo" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number,"></asp:CompareValidator>
                    <asp:RangeValidator ID="RangeTextTrail" ValidationGroup="theDate" ControlToValidate="txtNo" Type="Integer" MinimumValue="0" MaximumValue="999" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                </p>
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click" ValidationGroup="theDate" CssClass="btn" Text="Go"/>
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>