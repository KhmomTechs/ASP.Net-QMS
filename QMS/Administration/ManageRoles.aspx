<%@ Page Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true" CodeFile="ManageRoles.aspx.cs" Inherits="Administration.Administration_ManageRoles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("").className = "active";
    </script>
    <h2>Manage Roles</h2>
    <p>
        <b>Create a New Role: </b>
        <asp:TextBox ID="RoleName" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RoleNameReqField" runat="server"
                                    ControlToValidate="RoleName" Display="Dynamic"
                                    ErrorMessage="You must enter a role name.">
        </asp:RequiredFieldValidator>

        <br/>
        <br/>
        <asp:Button ID="CreateRoleButton" runat="server" CssClass="btn" Text="Create Role"
                    onclick="CreateRoleButton_Click"/>
    </p>
    <br/>
    <p>
        <asp:GridView ID="RoleList" runat="server" AutoGenerateColumns="False" CellPadding="4"
                      onrowdeleting="RoleList_RowDeleting">
            <Columns>
                <asp:CommandField DeleteText="Delete Role" ShowDeleteButton="True"/>
                <asp:TemplateField HeaderText="ROLES">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="RoleNameLabel" Text="<%# Container.DataItem %>"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCC99" ForeColor="Black"/>
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White"/>
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right"/>
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White"/>
        </asp:GridView>
    </p>
</asp:Content>