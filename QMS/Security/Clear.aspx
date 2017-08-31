<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Security.master" AutoEventWireup="true" CodeFile="Clear.aspx.cs" Inherits="Security.Security_Clear" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script language="javascript">
    document.getElementById("clear").className = "active";
</script>
<h3>Clear trucks out of KPC</h3>
<p>
    <asp:Label ID="lblMessage" ForeColor="Red" runat="server"></asp:Label>
</p>
*Time must be saved in form of HH:MM eg 14:30
<div style="height: 395px; width: 1200px;">
<asp:GridView ID="GridEntries" runat="server" AutoGenerateColumns="False"
              CellPadding="4" ForeColor="Black" Width="1200px"
              BackColor="#CCCCCC" BorderColor="#000" BorderStyle="Solid" BorderWidth="1px"
              DataKeyNames="QueueID" DataSourceID="EntrySource" AllowPaging="True"
              onrowupdated="GridEntries_RowUpdated"
              onrowupdating="GridEntries_RowUpdating"
              onrowdatabound="GridEntries_RowDataBound"
              CellSpacing="2" GridLines="Both" PageSize="10"
              RowStyle-VerticalAlign="Bottom">
<Columns>
<asp:CommandField ShowEditButton="True" ButtonType="Button" ControlStyle-CssClass="butt1" CancelText="Cancel" EditText="Change" ShowCancelButton="true" UpdateText="Finish" ControlStyle-Font-Size="10px"
                  ValidationGroup="Finish"/>
<asp:TemplateField HeaderText="FINISH" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" SortExpression="Finished">
    <EditItemTemplate>
        <asp:CheckBox ID="CheckBox1" runat="server" Enabled="true" Checked='<%# Eval("Finished") == DBNull.Value ? false : Eval("Finished") %>'/>
    </EditItemTemplate>
    <ItemTemplate>
        <asp:CheckBox ID="CheckClear" runat="server" Enabled="false" Checked='<%# Eval("Finished") == DBNull.Value ? false : Eval("Finished") %>'
                      AutoPostBack="true"/>
    </ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="Type" HeaderText="TYPE" ReadOnly="true" SortExpression="Type"/>
<asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                SortExpression="Queue_No"/>
<asp:BoundField DataField="Shipper" HeaderText="SHIPPER" ReadOnly="true"
                SortExpression="Shipper"/>
<asp:TemplateField HeaderText="REGISTRATION">
    <ItemTemplate>
        <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>/<asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
    </ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="LO_NO" HeaderText="L.O NO" ReadOnly="true" SortExpression="LO_NO"/>

<asp:TemplateField HeaderText="" SortExpression="OMCTIME">
    <ItemTemplate>
        <asp:Label ID="OMCTimeHr" runat="server" Text='<%# Eval("OMCTIME") %>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="DropOMCTimeHr" runat="server">
            <asp:ListItem Text="" Value=""></asp:ListItem>
            <asp:ListItem Text="00" Value="00"></asp:ListItem>
            <asp:ListItem Text="01" Value="01"></asp:ListItem>
            <asp:ListItem Text="02" Value="02"></asp:ListItem>
            <asp:ListItem Text="03" Value="03"></asp:ListItem>
            <asp:ListItem Text="04" Value="04"></asp:ListItem>
            <asp:ListItem Text="05" Value="05"></asp:ListItem>
            <asp:ListItem Text="06" Value="06"></asp:ListItem>
            <asp:ListItem Text="07" Value="07"></asp:ListItem>
            <asp:ListItem Text="08" Value="08"></asp:ListItem>
            <asp:ListItem Text="09" Value="09"></asp:ListItem>
            <asp:ListItem Text="10" Value="10"></asp:ListItem>
            <asp:ListItem Text="11" Value="11"></asp:ListItem>
            <asp:ListItem Text="12" Value="12"></asp:ListItem>
            <asp:ListItem Text="13" Value="13"></asp:ListItem>
            <asp:ListItem Text="14" Value="14"></asp:ListItem>
            <asp:ListItem Text="15" Value="15"></asp:ListItem>
            <asp:ListItem Text="16" Value="16"></asp:ListItem>
            <asp:ListItem Text="17" Value="17"></asp:ListItem>
            <asp:ListItem Text="18" Value="18"></asp:ListItem>
            <asp:ListItem Text="19" Value="19"></asp:ListItem>
            <asp:ListItem Text="20" Value="20"></asp:ListItem>
            <asp:ListItem Text="21" Value="21"></asp:ListItem>
            <asp:ListItem Text="22" Value="22"></asp:ListItem>
            <asp:ListItem Text="23" Value="23"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="ReqOMCTimeHr" runat="server" ControlToValidate="DropOMCTimeHr" InitialValue="" ValidationGroup="Finish" ErrorMessage="*"></asp:RequiredFieldValidator>
    </EditItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="OMCTIME">
    <ItemTemplate>
        <asp:Label ID="OMCTimeMin" runat="server" Text='<%# Eval("OMCTIME") %>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="DropOMCTimeMin" runat="server">
            <asp:ListItem Text="" Value=""></asp:ListItem>
            <asp:ListItem Text="00" Value="00"></asp:ListItem>
            <asp:ListItem Text="01" Value="01"></asp:ListItem>
            <asp:ListItem Text="02" Value="02"></asp:ListItem>
            <asp:ListItem Text="03" Value="03"></asp:ListItem>
            <asp:ListItem Text="04" Value="04"></asp:ListItem>
            <asp:ListItem Text="05" Value="05"></asp:ListItem>
            <asp:ListItem Text="06" Value="06"></asp:ListItem>
            <asp:ListItem Text="07" Value="07"></asp:ListItem>
            <asp:ListItem Text="08" Value="08"></asp:ListItem>
            <asp:ListItem Text="09" Value="09"></asp:ListItem>
            <asp:ListItem Text="10" Value="10"></asp:ListItem>
            <asp:ListItem Text="11" Value="11"></asp:ListItem>
            <asp:ListItem Text="12" Value="12"></asp:ListItem>
            <asp:ListItem Text="13" Value="13"></asp:ListItem>
            <asp:ListItem Text="14" Value="14"></asp:ListItem>
            <asp:ListItem Text="15" Value="15"></asp:ListItem>
            <asp:ListItem Text="16" Value="16"></asp:ListItem>
            <asp:ListItem Text="17" Value="17"></asp:ListItem>
            <asp:ListItem Text="18" Value="18"></asp:ListItem>
            <asp:ListItem Text="19" Value="19"></asp:ListItem>
            <asp:ListItem Text="20" Value="20"></asp:ListItem>
            <asp:ListItem Text="21" Value="21"></asp:ListItem>
            <asp:ListItem Text="22" Value="22"></asp:ListItem>
            <asp:ListItem Text="23" Value="23"></asp:ListItem>
            <asp:ListItem Text="24" Value="24"></asp:ListItem>
            <asp:ListItem Text="25" Value="25"></asp:ListItem>
            <asp:ListItem Text="26" Value="26"></asp:ListItem>
            <asp:ListItem Text="27" Value="27"></asp:ListItem>
            <asp:ListItem Text="28" Value="28"></asp:ListItem>
            <asp:ListItem Text="29" Value="29"></asp:ListItem>
            <asp:ListItem Text="30" Value="30"></asp:ListItem>
            <asp:ListItem Text="31" Value="31"></asp:ListItem>
            <asp:ListItem Text="32" Value="32"></asp:ListItem>
            <asp:ListItem Text="33" Value="33"></asp:ListItem>
            <asp:ListItem Text="34" Value="34"></asp:ListItem>
            <asp:ListItem Text="35" Value="35"></asp:ListItem>
            <asp:ListItem Text="36" Value="36"></asp:ListItem>
            <asp:ListItem Text="37" Value="37"></asp:ListItem>
            <asp:ListItem Text="38" Value="38"></asp:ListItem>
            <asp:ListItem Text="39" Value="39"></asp:ListItem>
            <asp:ListItem Text="40" Value="40"></asp:ListItem>
            <asp:ListItem Text="41" Value="41"></asp:ListItem>
            <asp:ListItem Text="42" Value="42"></asp:ListItem>
            <asp:ListItem Text="43" Value="43"></asp:ListItem>
            <asp:ListItem Text="44" Value="44"></asp:ListItem>
            <asp:ListItem Text="45" Value="45"></asp:ListItem>
            <asp:ListItem Text="46" Value="46"></asp:ListItem>
            <asp:ListItem Text="47" Value="47"></asp:ListItem>
            <asp:ListItem Text="48" Value="48"></asp:ListItem>
            <asp:ListItem Text="49" Value="49"></asp:ListItem>
            <asp:ListItem Text="50" Value="50"></asp:ListItem>
            <asp:ListItem Text="51" Value="51"></asp:ListItem>
            <asp:ListItem Text="52" Value="52"></asp:ListItem>
            <asp:ListItem Text="53" Value="53"></asp:ListItem>
            <asp:ListItem Text="54" Value="54"></asp:ListItem>
            <asp:ListItem Text="55" Value="55"></asp:ListItem>
            <asp:ListItem Text="56" Value="56"></asp:ListItem>
            <asp:ListItem Text="57" Value="57"></asp:ListItem>
            <asp:ListItem Text="58" Value="58"></asp:ListItem>
            <asp:ListItem Text="59" Value="59"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="ReqOMCTimeMin" runat="server" ControlToValidate="DropOMCTimeMin" InitialValue="" ValidationGroup="Finish" ErrorMessage="*"></asp:RequiredFieldValidator>
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="" SortExpression="KRATIME">
    <ItemTemplate>
        <asp:Label ID="KRATimeHr" runat="server" Text='<%# Eval("KRATIME") %>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="DropKRATimeHr" runat="server">
            <asp:ListItem Text="" Value=""></asp:ListItem>
            <asp:ListItem Text="00" Value="00"></asp:ListItem>
            <asp:ListItem Text="01" Value="01"></asp:ListItem>
            <asp:ListItem Text="02" Value="02"></asp:ListItem>
            <asp:ListItem Text="03" Value="03"></asp:ListItem>
            <asp:ListItem Text="04" Value="04"></asp:ListItem>
            <asp:ListItem Text="05" Value="05"></asp:ListItem>
            <asp:ListItem Text="06" Value="06"></asp:ListItem>
            <asp:ListItem Text="07" Value="07"></asp:ListItem>
            <asp:ListItem Text="08" Value="08"></asp:ListItem>
            <asp:ListItem Text="09" Value="09"></asp:ListItem>
            <asp:ListItem Text="10" Value="10"></asp:ListItem>
            <asp:ListItem Text="11" Value="11"></asp:ListItem>
            <asp:ListItem Text="12" Value="12"></asp:ListItem>
            <asp:ListItem Text="13" Value="13"></asp:ListItem>
            <asp:ListItem Text="14" Value="14"></asp:ListItem>
            <asp:ListItem Text="15" Value="15"></asp:ListItem>
            <asp:ListItem Text="16" Value="16"></asp:ListItem>
            <asp:ListItem Text="17" Value="17"></asp:ListItem>
            <asp:ListItem Text="18" Value="18"></asp:ListItem>
            <asp:ListItem Text="19" Value="19"></asp:ListItem>
            <asp:ListItem Text="20" Value="20"></asp:ListItem>
            <asp:ListItem Text="21" Value="21"></asp:ListItem>
            <asp:ListItem Text="22" Value="22"></asp:ListItem>
            <asp:ListItem Text="23" Value="23"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="ReqKRATimeHr" runat="server" ControlToValidate="DropKRATimeHr" InitialValue="" ValidationGroup="Finish" ErrorMessage="*"></asp:RequiredFieldValidator>
    </EditItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KRATIME">
    <ItemTemplate>
        <asp:Label ID="KRATimeMin" runat="server" Text='<%# Eval("KRATIME") %>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="DropKRATimeMin" runat="server">
            <asp:ListItem Text="" Value=""></asp:ListItem>
            <asp:ListItem Text="00" Value="00"></asp:ListItem>
            <asp:ListItem Text="01" Value="01"></asp:ListItem>
            <asp:ListItem Text="02" Value="02"></asp:ListItem>
            <asp:ListItem Text="03" Value="03"></asp:ListItem>
            <asp:ListItem Text="04" Value="04"></asp:ListItem>
            <asp:ListItem Text="05" Value="05"></asp:ListItem>
            <asp:ListItem Text="06" Value="06"></asp:ListItem>
            <asp:ListItem Text="07" Value="07"></asp:ListItem>
            <asp:ListItem Text="08" Value="08"></asp:ListItem>
            <asp:ListItem Text="09" Value="09"></asp:ListItem>
            <asp:ListItem Text="10" Value="10"></asp:ListItem>
            <asp:ListItem Text="11" Value="11"></asp:ListItem>
            <asp:ListItem Text="12" Value="12"></asp:ListItem>
            <asp:ListItem Text="13" Value="13"></asp:ListItem>
            <asp:ListItem Text="14" Value="14"></asp:ListItem>
            <asp:ListItem Text="15" Value="15"></asp:ListItem>
            <asp:ListItem Text="16" Value="16"></asp:ListItem>
            <asp:ListItem Text="17" Value="17"></asp:ListItem>
            <asp:ListItem Text="18" Value="18"></asp:ListItem>
            <asp:ListItem Text="19" Value="19"></asp:ListItem>
            <asp:ListItem Text="20" Value="20"></asp:ListItem>
            <asp:ListItem Text="21" Value="21"></asp:ListItem>
            <asp:ListItem Text="22" Value="22"></asp:ListItem>
            <asp:ListItem Text="23" Value="23"></asp:ListItem>
            <asp:ListItem Text="24" Value="24"></asp:ListItem>
            <asp:ListItem Text="25" Value="25"></asp:ListItem>
            <asp:ListItem Text="26" Value="26"></asp:ListItem>
            <asp:ListItem Text="27" Value="27"></asp:ListItem>
            <asp:ListItem Text="28" Value="28"></asp:ListItem>
            <asp:ListItem Text="29" Value="29"></asp:ListItem>
            <asp:ListItem Text="30" Value="30"></asp:ListItem>
            <asp:ListItem Text="31" Value="31"></asp:ListItem>
            <asp:ListItem Text="32" Value="32"></asp:ListItem>
            <asp:ListItem Text="33" Value="33"></asp:ListItem>
            <asp:ListItem Text="34" Value="34"></asp:ListItem>
            <asp:ListItem Text="35" Value="35"></asp:ListItem>
            <asp:ListItem Text="36" Value="36"></asp:ListItem>
            <asp:ListItem Text="37" Value="37"></asp:ListItem>
            <asp:ListItem Text="38" Value="38"></asp:ListItem>
            <asp:ListItem Text="39" Value="39"></asp:ListItem>
            <asp:ListItem Text="40" Value="40"></asp:ListItem>
            <asp:ListItem Text="41" Value="41"></asp:ListItem>
            <asp:ListItem Text="42" Value="42"></asp:ListItem>
            <asp:ListItem Text="43" Value="43"></asp:ListItem>
            <asp:ListItem Text="44" Value="44"></asp:ListItem>
            <asp:ListItem Text="45" Value="45"></asp:ListItem>
            <asp:ListItem Text="46" Value="46"></asp:ListItem>
            <asp:ListItem Text="47" Value="47"></asp:ListItem>
            <asp:ListItem Text="48" Value="48"></asp:ListItem>
            <asp:ListItem Text="49" Value="49"></asp:ListItem>
            <asp:ListItem Text="50" Value="50"></asp:ListItem>
            <asp:ListItem Text="51" Value="51"></asp:ListItem>
            <asp:ListItem Text="52" Value="52"></asp:ListItem>
            <asp:ListItem Text="53" Value="53"></asp:ListItem>
            <asp:ListItem Text="54" Value="54"></asp:ListItem>
            <asp:ListItem Text="55" Value="55"></asp:ListItem>
            <asp:ListItem Text="56" Value="56"></asp:ListItem>
            <asp:ListItem Text="57" Value="57"></asp:ListItem>
            <asp:ListItem Text="58" Value="58"></asp:ListItem>
            <asp:ListItem Text="59" Value="59"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="ReqDropKRATimeMin" runat="server" ControlToValidate="DropKRATimeMin" InitialValue="" ValidationGroup="Finish" ErrorMessage="*"></asp:RequiredFieldValidator>
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="QueueID" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility">
    <EditItemTemplate>
        <asp:Label ID="Label1" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
    </EditItemTemplate>
    <ItemTemplate>
        <asp:Label ID="Label2" runat="server" CssClass="Visibility" Text='<%# Bind("QueueID") %>'></asp:Label>
    </ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="Finished" HeaderText="" ReadOnly="true" SortExpression="Finished" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility"/>
<asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                SortExpression="Suspended"/>
<asp:BoundField DataField="SetDate" HeaderText="DATE" ReadOnly="true" HtmlEncode="false" DataFormatString="{0:MMM-dd-yyyy}"
                SortExpression="SetDate"/>
</Columns>
<EmptyDataTemplate>
    <div style="width: 100%;">No orders in the system for OMC Clearance</div>
</EmptyDataTemplate>
<FooterStyle BackColor="#CCCCCC"/>
<HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
<PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" Height="25px"/>
<RowStyle Font-Size="16px" BackColor="White" Height="18px" HorizontalAlign="Right"/>
<AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
<SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
</asp:GridView>
</div>
<asp:SqlDataSource ID="EntrySource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT NewQueue.*, SafetySecurity_C.* FROM NewQueue INNER JOIN SafetySecurity_C ON NewQueue.QueueID = SafetySecurity_C.QueueID WHERE (NewQueue.Finished IS NULL) AND (SafetySecurity_C.Passed = 'True') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND (NewQueue.EnterTime >= '25-march-2015') ORDER BY NewQueue.StatusTime"
                   UpdateCommand="UPDATE [NewQueue] SET [Status] = @Status, [Finished] = @Finished, [StatusTime] = @StatusTime, [FinishTime] = @FinishTime, [Checker] = @Checker, [KRATIME] = @KRATIME, [OMCTIME] = @OMCTIME
         WHERE [QueueID] = @QueueID">
    <UpdateParameters>
        <asp:Parameter Name="Status" DefaultValue="Finished"/>
        <asp:Parameter Name="Finished" Type="Boolean"/>
        <asp:Parameter Name="StatusTime" Type="DateTime"/>
        <asp:Parameter Name="FinishTime" Type="DateTime"/>
        <asp:Parameter Name="Checker"/>
        <asp:Parameter Name="KRATIME"/>
        <asp:Parameter Name="OMCTIME"/>
        <asp:Parameter Name="QueueID"/>
    </UpdateParameters>
</asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>