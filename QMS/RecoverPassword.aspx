<%@ Page Language="C#" MasterPageFile="~/Master/Login.master" AutoEventWireup="true" CodeFile="RecoverPassword.aspx.cs" Inherits="RecoverPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("").className = "active";
    </script>
    <h2>Password recovery</h2>
    <p>
        <asp:PasswordRecovery ID="RecoverPwd" runat="server" SuccessText="Password reset Successfully."
                              Width="500px">
            <MailDefinition BodyFileName="~/EmailTemplates/PasswordRecovery.txt"
                            Subject="KPC password has been reset...">
            </MailDefinition>
            <UserNameTemplate>
                <table cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
                    <tr>
                        <td>
                            <table cellpadding="0">
                                <tr>
                                    <td align="center" colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Company number:</asp:Label>
                                    </td>
                                    <td style="width: 261px">
                                        <asp:TextBox ID="UserName" CssClass="Enter" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server"
                                                                    ControlToValidate="UserName" ErrorMessage="User Name is required."
                                                                    ToolTip="User Name is required." ValidationGroup="RecoverPwd">
                                            *
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color: Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td align="left">
                                        <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Submit" CssClass="btn"
                                                    ValidationGroup="RecoverPwd"/>&nbsp;&nbsp;<u>
                                            <a style="color: Blue;" href="Default.aspx">Cancel</a>
                                        </u>
                                    </td>

                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </UserNameTemplate>
        </asp:PasswordRecovery>
    </p>
</asp:Content>