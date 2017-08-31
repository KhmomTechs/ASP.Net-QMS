<%@ Page Language="C#" MasterPageFile="~/Master/Security.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Security.Security_Default" %>
<%@ Register Src="~/Internal.ascx" TagName="Menu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("security").className = "active";
    </script>
    <div style="margin: 0px; width: 1200px;">
        <h3>Security - Internal Queue</h3>
    </div>
    <My:Menu ID="Menu" runat="server"/>
</asp:Content>