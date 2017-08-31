<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Display.master" AutoEventWireup="true" CodeFile="GeneralLocal.aspx.cs" Inherits="Screens_Changed.GeneralLocal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="5000">
    </asp:Timer>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <asp:Timer ID="AutoRefreshTimer" runat="server" Interval="5000" ontick="AutoRefreshTimer_Tick"/>
            <center style="font-size: 25px;">
                <h2>LOCAL QUEUE</h2>
            </center>
            <center>
                <table style="width: 1300px;">
                    <tr>
                        <td colspan="2" style="text-align: left; vertical-align: top;">
                            <asp:GridView ID="GridLocal" runat="server" AutoGenerateColumns="False" AllowPaging="true"
                                          DataKeyNames="QueueID" DataSourceID="SqlDataSource1" BackColor="#CCCCCC" Width="1300px"
                                          BorderColor="#999999" BorderStyle="Solid" GridLines="Both" BorderWidth="3px" CellPadding="4"
                                          CellSpacing="2" ForeColor="Black" onrowdatabound="GridLocal_RowDataBound" PageSize="13"
                                          onsorted="GridLocal_Sorted">
                                <Columns>
                                    <asp:BoundField DataField="Queue_No" HeaderText="No." ItemStyle-Width="50px"
                                                    SortExpression="Queue_No"/>
                                    <asp:BoundField DataField="Shipper" ItemStyle-Width="180px" HeaderText="SHIPPER"
                                                    SortExpression="Shipper"/>
                                    <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="300px">
                                        <ItemTemplate>
                                            <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label> <asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Status" HeaderText="STATUS" ReadOnly="true"
                                                    SortExpression="Status"/>
                                    <asp:BoundField DataField="StatusTime" ItemStyle-Width="250px" DataFormatString="{0:dd/MM/yy HH:mm}" HeaderText="TIME IN" ReadOnly="true"
                                                    SortExpression="StatusTime"/>
                                    <asp:BoundField DataField="Entitlement" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                                    SortExpression="Entitlement"/>
                                    <asp:BoundField DataField="LO_NO" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                                    SortExpression="LO_NO"/>
                                    <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="Suspended"/>
                                    <asp:BoundField DataField="QueueID" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="QueueID"/>
                                    <asp:BoundField DataField="Withdrawal" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="Withdrawal"/>
                                    <asp:BoundField DataField="Type" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="Type"/>
                                </Columns>
                                <FooterStyle BackColor="#CCCCCC"/>
                                <HeaderStyle BackColor="Black" Font-Size="30px" Font-Bold="True" ForeColor="White"/>
                                <PagerStyle BackColor="#CCCCCC" CssClass="Visibility" ForeColor="Black" HorizontalAlign="Left"/>
                                <RowStyle BackColor="White" Font-Size="25px" Font-Bold="true" HorizontalAlign="Right"/>
                                <AlternatingRowStyle BackColor="White" Font-Size="25px" Font-Bold="true" HorizontalAlign="Right"/>
                                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                                <EmptyDataTemplate>
                                    <div style="font-size: 30px; width: 100%;">No trucks in the system at this moment</div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                                               ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                                               SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Local' AND Status != 'Finished' AND Finished IS NULL AND SetDate = @TheDate Order by NewQueue.Queue_No, NewQueue.StatusTime, NewQueue.LO_NO">
                                <SelectParameters>
                                    <asp:Parameter Name="TheDate" Type="DateTime"/>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </center>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:FormView ID="View" DefaultMode="ReadOnly" CssClass="Visibility" EnableViewState="False" runat="server"
                  DataSourceID="ViewDataSource">
        <ItemTemplate>
            <asp:Label ID="lblTimer" runat="server" Text='<%# Eval("ScreenTime") %>'></asp:Label>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="ViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                       SelectCommand="SELECT * FROM [Settings]">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>