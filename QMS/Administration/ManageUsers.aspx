<%@ Page Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="Administration.Administration_ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("").className = "active";
    </script>
    <h2>
        Manage Accounts
    </h2>
    <p>
        <asp:Repeater ID="FilteringUI" runat="server"
                      onitemcommand="FilteringUI_ItemCommand">
            <ItemTemplate>
                <asp:LinkButton runat="server" ID="lnkFilter"
                                Text="<%# Container.DataItem %>"
                                CommandName="<%# Container.DataItem %>">
                </asp:LinkButton>
            </ItemTemplate>

            <SeparatorTemplate>|</SeparatorTemplate>
        </asp:Repeater>
    </p>
    <p>
        <asp:GridView ID="UserAccounts" runat="server"
                      AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC"
                      BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black"
                      GridLines="Both">
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="UserName"
                                    DataNavigateUrlFormatString="UserInformation.aspx?user={0}" ControlStyle-ForeColor="Blue" Text="Approve user"/>
                <asp:BoundField DataField="UserName" HeaderText="UserName"/>
                <asp:BoundField DataField="Email" HeaderText="Email"/>
                <asp:CheckBoxField DataField="IsApproved" HeaderText="Approved?"/>
                <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Locked Out?"/>
                <asp:CheckBoxField DataField="IsOnline" HeaderText="Online?"/>
            </Columns>
            <FooterStyle BackColor="#CCCC99" ForeColor="Black"/>
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White"/>
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right"/>
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White"/>
        </asp:GridView>
    </p>
    <p>
        <asp:LinkButton ID="lnkFirst" runat="server" onclick="lnkFirst_Click">&lt;&lt; First</asp:LinkButton> |
        <asp:LinkButton ID="lnkPrev" runat="server" onclick="lnkPrev_Click">&lt; Prev</asp:LinkButton> |
        <asp:LinkButton ID="lnkNext" runat="server" onclick="lnkNext_Click">Next &gt;</asp:LinkButton> |
        <asp:LinkButton ID="lnkLast" runat="server" onclick="lnkLast_Click">Last &gt;&gt;</asp:LinkButton>
    </p>
</asp:Content>