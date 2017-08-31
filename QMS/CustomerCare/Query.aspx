<%@ Page Title="" Language="C#" MasterPageFile="~/Master/CustomerCare.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="CustomerCare.CustomerCare_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Timer ID="AutoRefreshTimer" runat="server" Interval="5000" ontick="AutoRefreshTimer_Tick"/>
            <div style="margin: 0px; width: 1200px;">
                <p>
                    <center>
                        <strong>Order ID Truck filter.</strong>
                    </center>
                </p>
            </div>
            <table style="margin-top: 0px; width: 1200px;">
                <tr>
                    <td style="text-align: left; vertical-align: top;">
                        <asp:Panel ID="PanelExp" Height="400px" Visible="false" runat="server">
                            <h4>EXPORT QUEUE</h4>
                            <div class="gridBorder" style="height: 335px;">
                                <asp:GridView ID="GridExp" runat="server" Width="1000px" AutoGenerateColumns="False"
                                              DataKeyNames="QueueID" DataSourceID="SqlDataSource2" BackColor="#CCCCCC" AllowPaging="true" PageSize="10"
                                              BorderColor="#000" BorderStyle="Solid" GridLines="Both" BorderWidth="1px" CellPadding="4"
                                              CellSpacing="2" ForeColor="Black" onrowdatabound="GridExp_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Shipper" ItemStyle-Width="120px" HeaderText="SHIPPER"
                                                        SortExpression="Shipper"/>
                                        <asp:BoundField DataField="Registration" ItemStyle-Width="200px" HeaderText="REGISTRATION"
                                                        SortExpression="Registration"/>
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
                                        <asp:BoundField DataField="Type" HeaderText="TYPE"
                                                        SortExpression="Type"/>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "Check.aspx?ID=" + Eval("ID") + "&order=" + Eval("LO_NO") %>' Text="Approve" ForeColor="Blue" runat="server"></asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCCCC"/>
                                    <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                                    <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                                    <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                                    <EmptyDataTemplate>
                                        <div style="width: 100%;">No trucks in the system</div>
                                    </EmptyDataTemplate>
                                    <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
                                    <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                                                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                                                   SelectCommand="SELECT NewQueue.*, CustomerCare.* FROM NewQueue INNER JOIN CustomerCare ON NewQueue.QueueID = CustomerCare.QueueID WHERE (NewQueue.Type = 'Export') AND (NewQueue.Archived IS NULL) AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL) AND (CustomerCare.CustCareApproval IS NULL) AND (NewQueue.Status = 'CUSTOMER CARE') ORDER BY NewQueue.Queue_No">
                                </asp:SqlDataSource>
                            </div>
                            <p style="vertical-align: bottom;">
                                <asp:Button ID="LocSwitchBtn" runat="server" CssClass="btn" Text="Switch to Local Queue"
                                            onclick="LocSwitchBtn_Click"/>
                            </p>
                        </asp:Panel>

                        <asp:Panel ID="PanelLoc" Height="400px" runat="server">
                            <h4>LOCAL QUEUE</h4>
                            <div class="gridBorder" style="height: 335px;">
                                <asp:GridView ID="GridLocal" runat="server" Width="1000px" AutoGenerateColumns="False"
                                              DataKeyNames="QueueID" DataSourceID="SqlDataSource1" BackColor="#CCCCCC" AllowPaging="True"
                                              BorderColor="#000" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                                              CellSpacing="2" ForeColor="Black" onrowdatabound="GridLocal_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Shipper" ItemStyle-Width="120px" HeaderText="SHIPPER"
                                                        SortExpression="Shipper"/>
                                        <asp:BoundField DataField="Registration" ItemStyle-Width="200px" HeaderText="REGISTRATION"
                                                        SortExpression="Registration"/>
                                        <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO"
                                                        SortExpression="LO_NO"/>
                                        <asp:BoundField DataField="MSP" HeaderText="MSP"
                                                        SortExpression="MSP"/>
                                        <asp:BoundField DataField="AGO" HeaderText="AGO"
                                                        SortExpression="AGO"/>
                                        <asp:BoundField DataField="KERO" HeaderText="KERO"
                                                        SortExpression="KERO"/>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "Check.aspx?ID=" + Eval("ID") %>' Text="Approve" ForeColor="Blue" runat="server"></asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCCCC"/>
                                    <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                                    <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                                    <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                                    <EmptyDataTemplate>
                                        <div style="width: 100%;">No trucks in the system</div>
                                    </EmptyDataTemplate>
                                    <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
                                    <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                                                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                                                   SelectCommand="SELECT NewQueue.*, CustomerCare.* FROM NewQueue INNER JOIN CustomerCare ON NewQueue.QueueID = CustomerCare.QueueID WHERE (NewQueue.Type = 'Local') AND (NewQueue.Archived IS NULL) AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL) AND (CustomerCare.CustCareApproval IS NULL) AND (NewQueue.Status = 'CUSTOMER CARE') ORDER BY NewQueue.Queue_No">
                                </asp:SqlDataSource>
                            </div>
                            <p style="vertical-align: bottom;">
                                <asp:Button ID="ExpSwitchBtn" runat="server" CssClass="btn" Text="Switch to Export Queue"
                                            onclick="ExpSwitchBtn_Click"/>
                            </p>
                        </asp:Panel>


                        <asp:GridView ID="GridResult" runat="server" Width="1000px" AutoGenerateColumns="False"
                                      DataKeyNames="QueueID" BackColor="#CCCCCC" AllowPaging="True"
                                      BorderColor="#000" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                                      CellSpacing="2" ForeColor="Black" onrowdatabound="GridResult_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="No.">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Shipper" ItemStyle-Width="120px" HeaderText="SHIPPER"
                                                SortExpression="Shipper"/>
                                <asp:BoundField DataField="Registration" ItemStyle-Width="200px" HeaderText="REGISTRATION"
                                                SortExpression="Registration"/>
                                <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO"
                                                SortExpression="LO_NO"/>
                                <asp:BoundField DataField="MSP" HeaderText="MSP"
                                                SortExpression="MSP"/>
                                <asp:BoundField DataField="AGO" HeaderText="AGO"
                                                SortExpression="AGO"/>
                                <asp:BoundField DataField="KERO" HeaderText="KERO"
                                                SortExpression="KERO"/>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "Check.aspx?ID=" + Eval("ID") %>' Text="Approve" ForeColor="Blue" runat="server"></asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC"/>
                            <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                            <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                            <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                            <EmptyDataTemplate>
                                <div style="width: 100%;">No truck found matching that order number</div>
                            </EmptyDataTemplate>
                            <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
                            <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
                        </asp:GridView>
                    </td>
                    <td style="text-align: right; vertical-align: top; width: 200px;">
                        <asp:Button ID="btnGo" CssClass="btn" runat="server" Text="Back to main"
                                    ValidationGroup="Go" onclick="btnGo_Click"/>
                        </p>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>