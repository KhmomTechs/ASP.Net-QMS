<%@ Page Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true" CodeFile="EnhancedCreateUserWizard.aspx.cs" Inherits="Administration.Administration_EnhancedCreateUserWizard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<link href="../Scripts/default.css" rel="stylesheet" type="text/css"/>
<script src="../prompts/jquery.js" type="text/javascript"></script>
<script src="../prompts/jquery-impromptu.2.6.min.js" type="text/javascript"></script>

<script type="text/javascript">
    function CheckTruck() {
        DisplayCheckTruckDialog();
        return false;
    }

    function DisplayCheckTruckDialog() {
        $("#CheckTruck").show();
    }

    function CloseCheckTruckDialog() {
        $("#CheckTruck").hide();
    }

    document.getElementById("members").className = "active";

    window.onerror = function(e) { return true; };
</script>
<h3>Create New User Account</h3>
<asp:ScriptManager ID="asm" runat="server"/>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>

        <asp:CreateUserWizard ID="NewUserWizard" runat="server" CancelButtonType="Button" DisplayCancelButton="true"
                              ContinueDestinationPageUrl="~/Membership/AdditionalUserInfo.aspx" CancelButtonText="Back" CancelDestinationPageUrl="~/Default.aspx" CancelButtonStyle-CssClass="btn"
                              oncreateduser="NewUserWizard_CreatedUser" CreateUserButtonStyle-CssClass="btn"
                              LoginCreatedUser="false" DuplicateEmailErrorMessage="Email already in use." DuplicateUserNameErrorMessage="Company number already registered"
                              UnknownErrorMessage="An error occured.Please try again"
                              oncreatinguser="NewUserWizard_CreatingUser">

            <CreateUserButtonStyle CssClass="btn"></CreateUserButtonStyle>

            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server"
                                          Title="Create User Acoount">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td align="center" colspan="2" style="color: Red;">
                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Company Number:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="UserName" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server"
                                                                ControlToValidate="UserName" ErrorMessage="User Name is required."
                                                                ToolTip="User Name is required." ValidationGroup="NewUserWizard">
                                        *
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Password" CssClass="Enter" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server"
                                                                ControlToValidate="Password" ErrorMessage="Password is required."
                                                                ToolTip="Password is required." ValidationGroup="NewUserWizard">
                                        *
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="ConfirmPasswordLabel" runat="server"
                                               AssociatedControlID="ConfirmPassword">
                                        Confirm Password:
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="ConfirmPassword" CssClass="Enter" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server"
                                                                ControlToValidate="ConfirmPassword"
                                                                ErrorMessage="Confirm Password is required."
                                                                ToolTip="Confirm Password is required." ValidationGroup="NewUserWizard">
                                        *
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="color: Red;">
                                    <asp:Label ID="LabelDetails" runat="server"></asp:Label>
                                    <asp:CompareValidator ID="PasswordCompare" runat="server"
                                                          ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                                          Display="Dynamic"
                                                          ErrorMessage="The Passwords must match."
                                                          ValidationGroup="NewUserWizard">
                                    </asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Email" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server"
                                                                ControlToValidate="Email" ErrorMessage="E-mail is required."
                                                                ToolTip="E-mail is required." ValidationGroup="NewUserWizard">
                                        *
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:RegularExpressionValidator ID="EmailValidator" runat="server"
                                                                    ErrorMessage="Wrong email format" ControlToValidate="Email" Display="Dynamic"
                                                                    ValidationGroup="NewUserWizard"
                                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                    </asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right">First Name:</td>
                                <td>
                                    <asp:TextBox ID="First_Name" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredName" runat="server"
                                                                ControlToValidate="First_Name" ErrorMessage="First name is required."
                                                                ToolTip="First name is required." ValidationGroup="NewUserWizard">
                                        *
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right">Last Name:</td>
                                <td>
                                    <asp:TextBox ID="Last_Name" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredLast" runat="server"
                                                                ControlToValidate="Last_Name" ErrorMessage="Last name is required."
                                                                ToolTip="Last name is required." ValidationGroup="NewUserWizard">
                                        *
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right">Job Position:</td>
                                <td>
                                    <asp:TextBox ID="Position" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredPosition" runat="server"
                                                                ControlToValidate="Position" ErrorMessage="Position is required."
                                                                ToolTip="Position is required." ValidationGroup="NewUserWizard">
                                        *
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Select Roles:</td>
                                <td>
                                    <asp:ListBox id="RolesListBox" runat="server" CssClass="EnterDrop" SelectionMode="Multiple"/>
                                    <asp:RequiredFieldValidator ID="RequiredRole" runat="server" InitialValue=""
                                                                ControlToValidate="RolesListBox" ErrorMessage="Role required."
                                                                ToolTip="Role required." ValidationGroup="NewUserWizard">
                                        *
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:CreateUserWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>

        <div id="CheckTruck" class="JqueryForm">
            <table style="width: 100%;" cellpadding="5" cellspacing="0">
                <tr class="headerRow">
                    <td>
                        Message:
                    </td>
                    <td style="text-align: right;">
                        <a onclick="CloseCheckTruckDialog();" style="color: #ffffff; cursor: pointer; text-decoration: none;"></a>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p>
                            <asp:Label ID="lblPopUp" runat="server"></asp:Label>
                        </p>
                        <!-- <input id="Button1" class="butt1" type="button" onclick="CloseLoginUserDialog();" value="Ok"/> -->
                        <asp:Button ID="btnBack" runat="server" CssClass="btn" onclick="btnBack_Click" Text="Ok"/>
                    </td>
                </tr>
            </table>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>