<%@ Page Language="C#" MasterPageFile="~/Master/Managers.master" AutoEventWireup="true" CodeFile="DeclinedSafety.aspx.cs" Inherits="Managers.Managers_DeclinedSafety" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("managers").className = "active";
    </script>
    <h3>Orders sent back from Safety</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Timer ID="AutoRefreshTimer" runat="server" Interval="5000" ontick="AutoRefreshTimer_Tick"/>
            <p>
                <asp:Label ID="lblMessage" ForeColor="Red" runat="server"></asp:Label>
            </p>
            <div class="gridBorder" style="height: 335px; width: 1000px;">
                <asp:GridView ID="GridEntries" runat="server" AutoGenerateColumns="False"
                              CellPadding="4" ForeColor="Black" Width="1000px"
                              BackColor="#CCCCCC" BorderColor="#000" BorderStyle="Solid" BorderWidth="1px"
                              DataKeyNames="QueueID" DataSourceID="EntrySource" AllowPaging="True" PageSize="10"
                              onrowupdated="GridEntries_RowUpdated" onrowupdating="GridEntries_RowUpdating"
                              RowStyle-VerticalAlign="Bottom" HeaderStyle-Height="20px"
                              CellSpacing="2" GridLines="Both"
                              EnableViewState="false" onrowdatabound="GridEntries_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "WaiveSafety.aspx?ID=" + Eval("ID") %>' Text="ACTION" ForeColor="Blue" runat="server"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Type" HeaderText="TYPE" ReadOnly="true" SortExpression="Type"/>
                        <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                                        SortExpression="Queue_No"/>
                        <asp:BoundField DataField="Shipper" HeaderText="SHIPPER" ReadOnly="true"
                                        SortExpression="Shipper"/>
                        <asp:BoundField DataField="Registration" HeaderText="REGISTRATION" ReadOnly="true"
                                        SortExpression="Registration"/>
                        <asp:BoundField DataField="LO_NO" HeaderText="L.O NO" ReadOnly="true" SortExpression="LO_NO"/>
                        <asp:BoundField DataField="ImmCorrAction" HeaderText="REASON" ControlStyle-Width="400px" ItemStyle-Width="400px" ReadOnly="true"
                                        SortExpression="ImmCorrAction"/>
                        <asp:TemplateField HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility">
                            <ItemTemplate>
                                <asp:Label ID="Label1" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="width: 100%;">No orders sent back.</div>
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#CCCCCC"/>
                    <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                    <RowStyle Font-Size="16px" BackColor="White" Height="18px" HorizontalAlign="Right"/>
                    <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                </asp:GridView>
            </div>
            <asp:SqlDataSource ID="EntrySource" runat="server"
                               ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                               SelectCommand="SELECT NewQueue.*, SafetySecurity_A.* FROM NewQueue INNER JOIN SafetySecurity_A ON NewQueue.QueueID = SafetySecurity_A.QueueID WHERE (SafetySecurity_A.Failed = 'True') AND (NewQueue.Archived IS NULL) AND (NewQueue.Finished IS NULL) AND (NewQueue.Status = 'SAFTY') OR (NewQueue.Status = 'SAFCON') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.EnterTime"
                               UpdateCommand="UPDATE [SafetySecurity_A] SET [SafetyWaived] = @SafetyWaived, [SafetyWaiver] = @SafetyWaiver, [SafetyWaiverTime] = @SafetyWaiverTime, [SafetyComment] = @SafetyComment
         WHERE [QueueID] = @QueueID">
                <UpdateParameters>
                    <asp:Parameter Name="SafetyWaived" Type="Boolean"/>
                    <asp:Parameter Name="SafetyWaiver"/>
                    <asp:Parameter Name="SafetyComment"/>
                    <asp:Parameter Name="SafetyWaiverTime" Type="DateTime"/>
                    <asp:Parameter Name="QueueID"/>
                </UpdateParameters>
                <SelectParameters>
                    <asp:Parameter Name="TheDate" Type="DateTime"/>
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>