<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Safety.master" AutoEventWireup="true" CodeFile="KRA.aspx.cs" Inherits="Safety.Safety_KRA" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("load").className = "active";
    </script>
    <h3>Inspect orders that have been loaded</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" runat="server">
        <ContentTemplate>
            <asp:Timer ID="AutoRefreshTimer" runat="server" Interval="3000" ontick="AutoRefreshTimer_Tick"/>
            <p>
                <asp:Label ID="lblMessage" ForeColor="Red" runat="server"></asp:Label>
            </p>
            <div class="gridBorder" style="height: 335px; width: 1000px;">
                <asp:GridView ID="GridEntries" runat="server" AutoGenerateColumns="False" AllowPaging="True"
                              CellPadding="4" ForeColor="Black" DataKeyNames="QueueID" Width="1000px"
                              BackColor="#CCCCCC" BorderColor="#000" BorderStyle="Solid" BorderWidth="1px"
                              DataSourceID="EntrySource"
                              onrowupdating="GridEntries_RowUpdating"
                              onselectedindexchanged="GridEntries_SelectedIndexChanged"
                              onrowdatabound="GridEntries_RowDataBound"
                              GridLines="Both" PageSize="10" CellSpacing="2" EnableViewState="false" RowStyle-VerticalAlign="Bottom">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False"
                                                CommandName="Edit" Text="Edit">
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>

                                <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="true" onclick="LinkButton3_Click">Update</asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False"
                                                      CommandName="Cancel" Text="Cancel">
                                </asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="AVAILABILITY">
                            <ItemTemplate>
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" Font-Size="14px"
                                                     onselectedindexchanged="RadioButtonList1_SelectedIndexChanged"
                                                     RepeatDirection="Horizontal">
                                    <asp:ListItem Value="True">Yes</asp:ListItem>
                                    <asp:ListItem Value="False">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True"
                                                     onselectedindexchanged="RadioButtonList1_SelectedIndexChanged"
                                                     RepeatDirection="Horizontal">
                                    <asp:ListItem Value="True">Yes</asp:ListItem>
                                    <asp:ListItem Value="False">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                                        SortExpression="Queue_No"/>
                        <asp:BoundField DataField="Type" HeaderText="TYPE" ReadOnly="true" SortExpression="Type"/>
                        <asp:BoundField DataField="LO_NO" HeaderText="L.O NO" ReadOnly="true" SortExpression="LO_NO"/>
                        <asp:BoundField DataField="Shipper" HeaderText="SHIPPER" ReadOnly="true"
                                        SortExpression="Shipper"/>
                        <asp:TemplateField HeaderText="REGISTRATION">
                            <ItemTemplate>
                                <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>/<asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" Font-Bold="true" NavigateUrl='<%# "KRACheck.aspx?ID=" + Eval("ID") + "&order=" + Eval("LO_NO") %>' Text="CHECK ORDER" ForeColor="Blue" Enabled="false" runat="server"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false" ControlStyle-CssClass="Visibility">
                            <ItemTemplate>
                                <asp:Label ID="LabelID" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ID" HeaderText="" ReadOnly="true" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility"
                                        SortExpression="ID"/>
                        <asp:BoundField DataField="Status" HeaderText="" ReadOnly="true" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility"
                                        SortExpression="Status"/>
                        <asp:BoundField DataField="Passed" HeaderText="" ReadOnly="true" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility"
                                        SortExpression="Passed"/>
                        <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                        SortExpression="Suspended"/>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="width: 100%;">No orders in the system to clear</div>
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#CCCCCC"/>
                    <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" Height="25px"/>
                    <RowStyle Font-Size="16px" BackColor="White" Height="18px" HorizontalAlign="Right"/>
                    <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                </asp:GridView>
            </div>
            <p>
                <asp:Button ID="rptUnavaile" runat="server" CssClass="Visibility"
                            Text="Report Truck Availability status" onclick="rptUnavaile_Click"/>
            </p>
            <asp:SqlDataSource ID="EntrySource" runat="server"
                               ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                               SelectCommand="SELECT Operations.*, SafetySecurity_C.*, NewQueue.* FROM NewQueue INNER JOIN SafetySecurity_C ON NewQueue.QueueID = SafetySecurity_C.QueueID INNER JOIN Operations ON NewQueue.QueueID = Operations.QueueID WHERE (NewQueue.Finished IS NULL) AND (Operations.Cleared = 'True') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False')  AND (NewQueue.Status = 'LODCLE') AND SetDate = @TheDate ORDER BY Operations.ClearTime"
                               UpdateCommand="UPDATE SafetySecurity_C SET TruckAvailability = @TruckAvailability FROM SafetySecurity_C INNER JOIN NewQueue ON SafetySecurity_C.QueueID = NewQueue.QueueID WHERE (SafetySecurity_C.QueueID = @QueueID)">
                <UpdateParameters>
                    <asp:Parameter Name="TruckAvailability" Type="Boolean"/>
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