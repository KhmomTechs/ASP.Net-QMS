<%@ Page Language="C#" MasterPageFile="~/Master/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("home").className = "active";
    </script>
    <asp:Panel runat="server" ID="AuthenticatedMessagePanel">
    </asp:Panel>

    <asp:Panel runat="Server" ID="AnonymousMessagePanel">
        <asp:HyperLink runat="server" ID="lnkLogin" Text="Log In" NavigateUrl="~/Login.aspx"></asp:HyperLink>
    </asp:Panel>

</asp:Content>