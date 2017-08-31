<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Pipecor.master" AutoEventWireup="true" CodeFile="Upload.aspx.cs" Inherits="Pipecor.Pipecor_Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script src="../Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.core.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.widget.js" type="text/javascript"></script>
    <link href="../Styles/jquery.ui.all.css" rel="stylesheet" type="text/css"/>
    <link href="../Scripts/jquery.ui.datepicker.css" rel="stylesheet" type="text/css"/>
    <script src="../Scripts/jquery.ui.datepicker.js" type="text/javascript"></script>

    <script language="javascript">
        document.getElementById("upload").className = "active";

        $(function() {
            $("#datepickerExport").datepicker();

        });

        $(function() {
            $("#datepickerLocal").datepicker();

        });
    </script>
    <h3>Pipecor-Queue upload</h3>

    <table style="width: 800px">
        <tr>
            <td style="width: 400px;">
                <h3>Export Upload-Main</h3>
            </td>
            <td style="width: 400px;">
                <h3>Local Upload-Main</h3>
            </td>
        </tr>
        <tr>
            <td>
                <asp:FileUpload ID="FileUploadExp" runat="server"/>
            </td>
            <td>
                <asp:FileUpload ID="FileUploadLoc" runat="server"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp</td>
        </tr>
        <tr>
            <td>
                Date: <asp:TextBox ID="datepickerExport" runat="server" ClientIDMode="Static">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqExpDate" runat="server" ValidationGroup="ExportDate" ControlToValidate="datepickerExport" ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
            <td>
                Date: <asp:TextBox ID="datepickerLocal" runat="server" ClientIDMode="Static">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqLocDate" runat="server" ValidationGroup="LocalDate" ControlToValidate="datepickerLocal" ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp</td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="ButtonExp" runat="server" OnClick="ButtonExp_Click" ValidationGroup="ExportDate" CssClass="btn" Text="Upload Main"
                            Width="182px"/>
            </td>
            <td>
                <asp:Button ID="ButtonLoc" runat="server" OnClick="ButtonLoc_Click" ValidationGroup="LocalDate" CssClass="btn" Text="Upload Main"
                            Width="182px"/>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblmessageExp" runat="server"
                           style="color: Red; font-weight: 700;"
                           Text="">
                </asp:Label>
            </td>
            <td>
                <asp:Label ID="lblmessageLoc" runat="server"
                           style="color: Red; font-weight: 700;"
                           Text="">
                </asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
    </table>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>