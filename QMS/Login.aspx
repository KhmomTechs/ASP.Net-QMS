<%@ Page Language="C#" MasterPageFile="~/Master/Login.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <table style="width: 400px">
        <tr>
            <td style="width: 200px;"></td>
            <td style="width: 200px;"></td>
        </tr>
        <tr>
            <td>Company number:</td>
            <td>
                <asp:TextBox ID="UserName" CssClass="Enter" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqUserName" runat="server" ControlToValidate="UserName" ValidationGroup="Log" ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td>Password:</td>
            <td>
                <asp:TextBox ID="Password" CssClass="Enter" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqPassword" runat="server" ControlToValidate="Password" ValidationGroup="Log" ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2"><asp:CheckBox ID="RememberMe" runat="server" CssClass="Visibility" Text=""/>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <u>
                    <a style="color: Blue;" href="RecoverPassword.aspx">Forgot Password?</a>
                </u>
            </td>
            <td>
                <asp:Button ID="LoginButton" runat="server" CssClass="btn" Text="Login" ValidationGroup="Log" OnClick="LoginButton_Click"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="InvalidCredentialsMessage" runat="server" ForeColor="Red" Text="Invalid Company number or Password. Please try again."
                           Visible="False">
                </asp:Label>
            </td>
        </tr>
    </table>

</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="LoginContent">
</asp:Content>