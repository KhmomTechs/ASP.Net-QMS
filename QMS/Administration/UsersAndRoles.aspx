<%@ Page Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true" CodeFile="UsersAndRoles.aspx.cs" Inherits="Administration.Administration_UsersAndRoles" Title="Edit Account" %>

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

        document.getElementById("").className = "active";

        window.onerror = function(e) { return true; };
    </script>
    <asp:ScriptManager ID="asm" runat="server"/>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <p align="center">
                <asp:Label ID="ActionStatus" runat="server" CssClass="Visibility"></asp:Label>
            </p>
            <h4>Company number: <asp:Label ID="lblUserName" runat="server"></asp:Label> Profile</h4>
            <asp:FormView ID="FormProfile" runat="server" DefaultMode="Edit" DataKeyNames="UserId"
                          DataSourceID="SqlEditProfile" onitemupdated="FormProfile_ItemUpdated">
                <EditItemTemplate>
                    <table style="width: 500px;">
                        <tr>
                            <td style="width: 50%">First name:</td>
                            <td style="text-align: left; width: 50%;">
                                <asp:TextBox ID="First_NameTextBox" CssClass="Enter" runat="server"
                                             Text='<%# Bind("First_Name") %>'/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>Last name:</td>
                            <td style="text-align: left;">
                                <asp:TextBox ID="Last_NameTextBox" runat="server" CssClass="Enter"
                                             Text='<%# Bind("Last_Name") %>'/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>Position:</td>
                            <td style="text-align: left;">
                                <asp:TextBox ID="PositionTextBox" runat="server" CssClass="Enter"
                                             Text='<%# Bind("Position") %>'/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <h4>Roles</h4>
                                <asp:Repeater ID="UsersRoleList" runat="server">
                                    <ItemTemplate>
                                        <br/>
                                        <asp:CheckBox runat="server" ID="RoleCheckBox" AutoPostBack="true" Text="<%# Container.DataItem %>" OnCheckedChanged="RoleCheckBox_CheckChanged"/>
                                        <br/>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </td>
                        </tr>
                    </table>
                    <p>
                        <asp:Button ID="btnDone" CssClass="btn" runat="server" Text="SAVE" CommandName="Update"/>
                    </p>
                </EditItemTemplate>
            </asp:FormView>

        </ContentTemplate>
    </asp:UpdatePanel>


    <asp:SqlDataSource ID="SqlEditProfile" runat="server"
                       ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                       SelectCommand="SELECT * FROM [UserProfiles] WHERE [UserId] = @UserId"
                       UpdateCommand="UPDATE [UserProfiles] SET [First_Name] = @First_Name, [Last_Name] = @Last_Name, [Position] = @Position WHERE [UserId] = @UserId">
        <SelectParameters>
            <asp:QueryStringParameter Name="UserId" QueryStringField="id"/>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="First_Name" Type="String"/>
            <asp:Parameter Name="Last_Name" Type="String"/>
            <asp:Parameter Name="Position" Type="String"/>
            <asp:Parameter Name="UserId" Type="Object"/>
        </UpdateParameters>
    </asp:SqlDataSource>

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
                        <asp:Label ID="lblPopUp" Text="User profile updated successfully." runat="server"></asp:Label>
                    </p>
                    <!-- <input id="Button1" class="butt1" type="button" onclick="CloseLoginUserDialog();" value="Ok"/> -->
                    <asp:Button ID="btnBack" runat="server" CssClass="btn" onclick="btnBack_Click" Text="Ok"/>
                </td>
            </tr>
        </table>
    </div>

</asp:Content>