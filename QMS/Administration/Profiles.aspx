<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true" CodeFile="Profiles.aspx.cs" Inherits="Administration.Administration_Profiles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("profile").className = "active";
    </script>
    <h3>Manage User Roles</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Timer ID="AutoRefreshTimer" runat="server" Interval="10000" ontick="AutoRefreshTimer_Tick"/>
            <div class="gridBorder" style="height: 335px; width: 1000px;">
                <asp:GridView ID="GridProfile" runat="server" AutoGenerateColumns="False"
                              DataSourceID="SqlProfiles" Width="1000px" BackColor="#CCCCCC" EnableViewState="false" AllowPaging="true" PageSize="10"
                              BorderColor="#000" BorderStyle="Solid" GridLines="Both" BorderWidth="1px" CellPadding="4"
                              CellSpacing="2" ForeColor="Black">
                    <Columns>
                        <asp:BoundField DataField="UserName" HeaderText="COMPANY NUMBER" ControlStyle-Width="200px" ItemStyle-Width="200px"
                                        SortExpression="UserName"/>
                        <asp:BoundField DataField="First_Name" HeaderText="FIRST NAME" ControlStyle-Width="200px" ItemStyle-Width="200px"
                                        SortExpression="First_Name"/>
                        <asp:BoundField DataField="Last_Name" HeaderText="LAST NAME" ControlStyle-Width="200px" ItemStyle-Width="200px"
                                        SortExpression="Last_Name"/>
                        <asp:BoundField DataField="Position" HeaderText="POSITION" ControlStyle-Width="200px" ItemStyle-Width="200px"
                                        SortExpression="Position"/>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "UsersAndRoles.aspx?name=" + Eval("UserName") + "&id=" + Eval("UserId") %>' Text="Edit" ForeColor="Blue" runat="server"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC"/>
                    <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                    <RowStyle Font-Size="16px" BackColor="White" Width="200px" Height="18px"/>
                    <AlternatingRowStyle Font-Size="16px" Width="200px" Height="18px"/>
                    <SelectedRowStyle BackColor="#000099" ForeColor="White"/>
                    <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
                    <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
                    <EmptyDataTemplate>
                        <div style="width: 100%;">No members created.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
            <asp:SqlDataSource ID="SqlProfiles" runat="server"
                               ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                               SelectCommand="SELECT UserProfiles.First_Name, UserProfiles.Last_Name, UserProfiles.Position, aspnet_Users.UserName, aspnet_Users.UserId FROM aspnet_Users INNER JOIN UserProfiles ON aspnet_Users.UserId = UserProfiles.UserId">
            </asp:SqlDataSource>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>