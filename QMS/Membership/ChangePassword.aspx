<%@ Page Language="C#" MasterPageFile="~/Master/Users.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Membership.ChangePassword" Title="My Account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("").className = "active";
    </script>
    <h2>Your department roles</h2>

    <asp:bulletedlist runat="server" ID="myRoles" BulletStyle="Square" CssClass="LiLink" DisplayMode="HyperLink" target="_blank">
    </asp:bulletedlist>

    <h2>Change Your Password</h2>
    <p>Enter the current password then set your new password.</p>
    <p>
        <asp:ChangePassword ID="ChangePwd" runat="server" ContinueDestinationPageUrl="~/Default.aspx" ContinueButtonStyle-CssClass="btn"
                            onchangedpassword="ChangePwd_ChangedPassword">
            <ChangePasswordTemplate>
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
                                        <asp:Label ID="CurrentPasswordLabel" runat="server"
                                                   AssociatedControlID="CurrentPassword">
                                            Current Password:
                                        </asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server"
                                                                    ControlToValidate="CurrentPassword" ErrorMessage="Password is required."
                                                                    ToolTip="Password is required." ValidationGroup="ChangePwd">
                                            *
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="NewPasswordLabel" runat="server"
                                                   AssociatedControlID="NewPassword">
                                            New Password:
                                        </asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server"
                                                                    ControlToValidate="NewPassword" ErrorMessage="New Password is required."
                                                                    ToolTip="New Password is required." ValidationGroup="ChangePwd">
                                            *
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server"
                                                   AssociatedControlID="ConfirmNewPassword">
                                            Confirm New Password:
                                        </asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server"
                                                                    ControlToValidate="ConfirmNewPassword"
                                                                    ErrorMessage="Confirm New Password is required."
                                                                    ToolTip="Confirm New Password is required." ValidationGroup="ChangePwd">
                                            *
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:CompareValidator ID="NewPasswordCompare" runat="server"
                                                              ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                                              Display="Dynamic"
                                                              ErrorMessage="The Confirm New Password must match the New Password entry."
                                                              ValidationGroup="ChangePwd">
                                        </asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color: Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Button ID="ChangePasswordPushButton" runat="server"
                                                    CommandName="ChangePassword" Text="Change Password" CssClass="btn"
                                                    ValidationGroup="ChangePwd"/>
                                    </td>
                                    <td>
                                        <asp:Button ID="GoBack" CssClass="btn" runat="server" Text="BACK"
                                                    onclick="GoBack_Click"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ChangePasswordTemplate>
        </asp:ChangePassword>
    </p>
</asp:Content>