<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Pipecor.master" AutoEventWireup="true" CodeFile="Add.aspx.cs" Inherits="Pipecor.Pipecor_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("add").className = "active";
    </script>
    <h3>PipeCore-Aggregate Queue upload</h3>

    <table style="width: 800px">
        <tr>
            <td style="width: 400px;">
                <h3>Export Upload</h3>
            </td>
            <td style="width: 400px;">
                <h3>Local Upload</h3>
            </td>
        </tr>
        <tr>
            <td>
                <asp:FileUpload ID="FileUploadExp" runat="server"/>
            </td>
            <td>
                <asp:FileUpload ID="FileUploadLoc" runat="server"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp</td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="ButtonExp" runat="server" OnClick="ButtonExp_Click" CssClass="btn" Text="Upload"
                            Width="182px"/>
            </td>
            <td>
                <asp:Button ID="ButtonLoc" runat="server" OnClick="ButtonLoc_Click" CssClass="btn" Text="Upload"
                            Width="182px"/>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblmessageExp" runat="server"
                           style="color: Red; font-weight: 700;"
                           Text="">
                </asp:Label>
            </td>
            <td>
                <asp:Label ID="lblmessageLoc" runat="server"
                           style="color: Red; font-weight: 700;"
                           Text="">
                </asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridExp" runat="server" AutoGenerateColumns="False" CssClass="Visibility" AllowPaging="false"
                              DataSourceID="SqlExpSource" BackColor="#ffffff" Width="200px"
                              BorderColor="#ffffff" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                              CellSpacing="2">
                    <Columns>
                        <asp:BoundField DataField="LO_NO" ItemStyle-Width="200px" HeaderText="LO_NO"
                                        SortExpression="LO_NO"/>
                        <asp:BoundField DataField="Shipper" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Left" HeaderText="SHIPPER"
                                        SortExpression="Shipper"/>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC"/>
                    <HeaderStyle BackColor="Black" Font-Size="20px" Font-Bold="True" ForeColor="White"/>
                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left"/>
                    <RowStyle BackColor="White" Font-Size="18px" Font-Bold="true" HorizontalAlign="Right"/>
                    <AlternatingRowStyle BackColor="White" Font-Size="18px" Font-Bold="true" HorizontalAlign="Right"/>
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                    <EmptyDataTemplate>

                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlExpSource" runat="server"
                                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                                   SelectCommand="SELECT ExportQueue.LO_NO, ExportQueue.Shipper FROM ExportQueue INNER JOIN NewQueue ON ExportQueue.LO_NO = NewQueue.LO_NO WHERE (NewQueue.Archived IS NULL) AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL OR NewQueue.Rejected = 'False')">
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:GridView ID="GridLocal" runat="server" AutoGenerateColumns="False" CssClass="Visibility" AllowPaging="false"
                              DataSourceID="SqlLocSource" BackColor="#ffffff" Width="200px"
                              BorderColor="#ffffff" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                              CellSpacing="2">
                    <Columns>
                        <asp:BoundField DataField="LO_NO" ItemStyle-Width="200px" HeaderText="LO_NO"
                                        SortExpression="LO_NO"/>
                        <asp:BoundField DataField="Shipper" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Left" HeaderText="SHIPPER"
                                        SortExpression="Shipper"/>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC"/>
                    <HeaderStyle BackColor="Black" Font-Size="20px" Font-Bold="True" ForeColor="White"/>
                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left"/>
                    <RowStyle BackColor="White" Font-Size="18px" Font-Bold="true" HorizontalAlign="Right"/>
                    <AlternatingRowStyle BackColor="White" Font-Size="18px" Font-Bold="true" HorizontalAlign="Right"/>
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                    <EmptyDataTemplate>

                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlLocSource" runat="server"
                                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                                   SelectCommand="SELECT LocalQueue.LO_NO, LocalQueue.Shipper FROM LocalQueue INNER JOIN NewQueue ON LocalQueue.LO_NO = NewQueue.LO_NO WHERE (NewQueue.Archived IS NULL) AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL OR NewQueue.Rejected = 'False')">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>