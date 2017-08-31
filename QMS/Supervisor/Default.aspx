<%@ Page Language="C#" MasterPageFile="~/Master/Supervisor.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Supervisor.Supervisor_Default" %>
<%@ Register Src="~/Internal.ascx" TagName="Menu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("super").className = "active";
    </script>
    <div style="margin: 0px; width: 1200px;">
        <h3>Supervisors-Internal Queue</h3>
    </div>
    <My:Menu ID="Menu" runat="server"/>
</asp:Content>