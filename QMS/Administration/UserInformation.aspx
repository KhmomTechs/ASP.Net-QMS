<%@ Page Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true" CodeFile="UserInformation.aspx.cs" Inherits="Administration.Administration_UserInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("").className = "active";
    </script>
    <h2>User Information</h2>
    <p>
        <asp:HyperLink ID="BackLink" runat="server"
                       NavigateUrl="~/Administration/ManageUsers.aspx">
            &lt;&lt; Back to User List
        </asp:HyperLink>
    </p>
    <table>
        <tr>
            <td class="tdLabel">Username:</td>
            <td>
                <asp:Label runat="server" ID="UserNameLabel"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdLabel">Approved:</td>
            <td>
                <asp:CheckBox ID="IsApproved" runat="server" AutoPostBack="true"
                              oncheckedchanged="IsApproved_CheckedChanged"/>
            </td>
        </tr>
        <tr>
            <td class="tdLabel">Locked Out:</td>
            <td>
                <asp:Label runat="server" ID="LastLockoutDateLabel"></asp:Label>
                <br/>
                <asp:Button runat="server" ID="UnlockUserButton" CssClass="btn" Text="Unlock User"
                            onclick="UnlockUserButton_Click"/>
            </td>
        </tr>
    </table>
    <p>
        <asp:Label ID="StatusMessage" CssClass="Important" runat="server"></asp:Label>
    </p>
</asp:Content>