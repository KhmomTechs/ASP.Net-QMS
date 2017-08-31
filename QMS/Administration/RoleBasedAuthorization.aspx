<%@ Page Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true" CodeFile="RoleBasedAuthorization.aspx.cs" Inherits="Administration.Administration_RoleBasedAuthorization" Title="POP QMS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("user").className = "active";
    </script>
    <h3>User account details</h3>
    <p>
        <asp:LoginView ID="LoginView1" runat="server">
            <RoleGroups>
                <asp:RoleGroup Roles="Administrators">
                    <ContentTemplate>
                        As an Administrator, you may edit and delete user accounts.
                    </ContentTemplate>
                </asp:RoleGroup>
                <asp:RoleGroup Roles="Supervisors">
                    <ContentTemplate>
                        As a Supervisor, you may edit users&#39; Email and Comment information. Simply click
                        the Edit button, make your changes, and then click Update.
                    </ContentTemplate>
                </asp:RoleGroup>
            </RoleGroups>
            <LoggedInTemplate>
                You are not a member of the Administrators roles. Therefore you
                cannot edit or delete any user information.
            </LoggedInTemplate>
            <AnonymousTemplate>
                You are not logged into the system. Therefore you cannot edit or delete any user
                information.
            </AnonymousTemplate>
        </asp:LoginView>
    </p>


    <asp:GridView ID="UserGrid" runat="server" AutoGenerateColumns="False"
                  DataKeyNames="UserName" AllowPaging="true" PageSize="10"
                  onrowcancelingedit="UserGrid_RowCancelingEdit"
                  onrowediting="UserGrid_RowEditing" Width="1200px"
                  onrowupdating="UserGrid_RowUpdating" onrowdeleting="UserGrid_RowDeleting" CellPadding="4"
                  onrowcreated="UserGrid_RowCreated"
                  onpageindexchanging="UserGrid_PageIndexChanging">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True"
                                    CommandName="Update" Text="Update">
                    </asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False"
                                          CommandName="Cancel" Text="Cancel">
                    </asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False"
                                    CommandName="Edit" Text="Edit">
                    </asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False"
                                          CommandName="Delete" Text="Delete">
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="UserName" HeaderText="COMPANY NUMBER" ReadOnly="True"/>
            <asp:TemplateField HeaderText="Email">
                <ItemTemplate>
                    <asp:Label runat="server" ID="Label1" Text='<%# Eval("Email") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="LastLoginDate" DataFormatString="{0:d}"
                            HeaderText="LAST LOGIN" HtmlEncode="False" ReadOnly="True"/>

            <asp:TemplateField HeaderText="LOCKED?" SortExpression="IsLockedOut">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckLock" runat="server" Checked='<%# Bind("IsLockedOut") %>'
                                  Enabled="false"/>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckLock" runat="server"
                                  Checked='<%# Bind("IsLockedOut") %>'/>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="ONLINE?" SortExpression="IsOnline">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckOnline" runat="server" Checked='<%# Bind("IsOnline") %>'
                                  Enabled="false"/>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckOnline" runat="server" Enabled="false"
                                  Checked='<%# Bind("IsOnline") %>'/>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="COMMENT">
                <ItemTemplate>
                    <asp:Label runat="server" ID="Label2" Text='<%# Eval("Comment") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="Comment" TextMode="MultiLine" Columns="40" Rows="1" Text='<%# Bind("Comment") %>'></asp:TextBox>
                </EditItemTemplate>
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
    </asp:GridView>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                           ShowMessageBox="True" ShowSummary="False"/>

</asp:Content>