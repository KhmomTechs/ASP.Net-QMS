<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Internal.ascx.cs" Inherits="Internal" %>

<link href="Styles.css" rel="stylesheet" type="text/css"/>
<link href="prompts/default.css" rel="stylesheet" type="text/css"/>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Timer ID="AutoRefreshTimer" runat="server" Interval="900" ontick="AutoRefreshTimer_Tick"/>
        <table style="margin-top: 0px; width: 1250px;">
            <tr>
                <td style="text-align: left; vertical-align: top;">
                    <asp:Panel ID="PanelExp" Height="420px" Visible="false" runat="server">
                        <h4>EXPORT QUEUE</h4>
                        <div class="gridBorder" style="min-height: 335px">

                            <asp:GridView ID="GridExp" runat="server" Width="1250px" AutoGenerateColumns="False"
                                          DataKeyNames="QueueID" BackColor="#CCCCCC" EnableViewState="false" DataSourceID="SqlExportSource"
                                          AllowPaging="true" PageSize="10" EnableSortingAndPagingCallbacks="true"
                                          BorderColor="#000" BorderStyle="Solid" GridLines="Both" BorderWidth="1px" CellPadding="4"
                                          CellSpacing="2" ForeColor="Black" onrowdatabound="GridLocal_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Queue_No" HeaderText="No." SortExpression="Queue_No"/>
                                    <asp:BoundField DataField="Shipper" ItemStyle-Width="120px" HeaderText="SHIPPER"
                                                    SortExpression="Shipper"/>

                                    <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="200px">
                                        <ItemTemplate>
                                            <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>/<asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO"
                                                    SortExpression="LO_NO"/>
                                    <asp:BoundField DataField="MSP" HeaderText="MSP"
                                                    SortExpression="MSP"/>
                                    <asp:BoundField DataField="AGO" HeaderText="AGO"
                                                    SortExpression="AGO"/>
                                    <asp:BoundField DataField="KERO" HeaderText="KERO"
                                                    SortExpression="KERO"/>
                                    <asp:BoundField DataField="JET" HeaderText="JET"
                                                    SortExpression="JET"/>
                                    <asp:BoundField DataField="Status" ItemStyle-Width="300px" HeaderText="STATUS"
                                                    SortExpression="Status"/>
                                    <asp:BoundField DataField="StatusTime" HeaderText="TIME IN" ItemStyle-Width="250px" DataFormatString="{0:MMM-dd-yyyy hh:mmtt}"
                                                    SortExpression="StatusTime"/>
                                    <asp:BoundField DataField="Entitlement" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                                    SortExpression="Entitlement"/>
                                    <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="Suspended"/>
                                    <asp:BoundField DataField="Type" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="Type"/>
                                    <asp:BoundField DataField="QueueID" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="QueueID"/>
                                    <asp:BoundField DataField="Withdrawal" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="Withdrawal"/>
                                </Columns>
                                <FooterStyle BackColor="#CCCCCC"/>
                                <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                                <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                                <AlternatingRowStyle Font-Size="16px" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                                <EmptyDataTemplate>
                                    <div style="width: 100%;">No trucks in the system</div>
                                </EmptyDataTemplate>
                                <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
                                <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
                            </asp:GridView>
                        </div>
                        <p style="vertical-align: bottom;">
                            <asp:Button ID="LocSwitchBtn" runat="server" CssClass="btn" Text="Switch to Local Queue"
                                        onclick="LocSwitchBtn_Click"/>
                        </p>
                    </asp:Panel>

                    <asp:Panel ID="PanelLoc" Height="420px" runat="server">
                        <h4>LOCAL QUEUE</h4>
                        <div class="gridBorder" style="min-height: 335px;">
                            <asp:GridView ID="GridLocal" runat="server" Width="1250px" AutoGenerateColumns="False"
                                          DataKeyNames="QueueID" BackColor="#CCCCCC" EnableViewState="false" DataSourceID="SqlLocalSource"
                                          AllowPaging="true" PageSize="10" EnableSortingAndPagingCallbacks="true"
                                          BorderColor="#000" BorderStyle="Solid" GridLines="Both" BorderWidth="1px" CellPadding="4"
                                          CellSpacing="2" ForeColor="Black" onrowdatabound="GridLocal_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Queue_No" HeaderText="No." SortExpression="Queue_No"/>
                                    <asp:BoundField DataField="Shipper" ItemStyle-Width="120px" HeaderText="SHIPPER"
                                                    SortExpression="Shipper"/>
                                    <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="200px">
                                        <ItemTemplate>
                                            <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label> <asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO"
                                                    SortExpression="LO_NO"/>
                                    <asp:BoundField DataField="MSP" HeaderText="MSP"
                                                    SortExpression="MSP"/>
                                    <asp:BoundField DataField="AGO" HeaderText="AGO"
                                                    SortExpression="AGO"/>
                                    <asp:BoundField DataField="KERO" HeaderText="KERO"
                                                    SortExpression="KERO"/>
                                    <asp:BoundField DataField="JET" HeaderText="JET"
                                                    SortExpression="JET"/>
                                    <asp:BoundField DataField="Status" ItemStyle-Width="300px" HeaderText="STATUS"
                                                    SortExpression="Status"/>
                                    <asp:BoundField DataField="StatusTime" HeaderText="TIME IN" ItemStyle-Width="250px" DataFormatString="{0:MMM-dd-yyyy hh:mmtt}"
                                                    SortExpression="StatusTime"/>
                                    <asp:BoundField DataField="Entitlement" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                                    SortExpression="Entitlement"/>
                                    <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="Suspended"/>
                                    <asp:BoundField DataField="Type" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="Type"/>
                                    <asp:BoundField DataField="QueueID" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="QueueID"/>
                                    <asp:BoundField DataField="Withdrawal" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                    SortExpression="Withdrawal"/>
                                </Columns>
                                <FooterStyle BackColor="#CCCCCC"/>
                                <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                                <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                                <AlternatingRowStyle Font-Size="16px" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                                <EmptyDataTemplate>
                                    <div style="width: 100%;">No trucks in the system</div>
                                </EmptyDataTemplate>
                                <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
                                <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
                            </asp:GridView>

                        </div>
                        <p style="vertical-align: bottom;">
                            <asp:Button ID="ExpSwitchBtn" runat="server" CssClass="btn" Text="Switch to Export Queue"
                                        onclick="ExpSwitchBtn_Click"/>
                        </p>
                    </asp:Panel>

                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlLocalSource" runat="server"
                           ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                           SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Local' AND Status != 'Finished' AND Finished IS NULL AND SetDate = @TheDate Order by NewQueue.Queue_No, NewQueue.StatusTime">
            <SelectParameters>
                <asp:Parameter Name="TheDate" Type="DateTime"/>
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlExportSource" runat="server"
                           ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                           SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Export' AND Status != 'Finished' AND Finished IS NULL AND SetDate = @TheDate Order by NewQueue.Queue_No, NewQueue.StatusTime">
            <SelectParameters>
                <asp:Parameter Name="TheDate" Type="DateTime"/>
            </SelectParameters>
        </asp:SqlDataSource>
    </ContentTemplate>
</asp:UpdatePanel>