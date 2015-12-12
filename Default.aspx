<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="VB" AutoEventWireup="false"
    CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Src="BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="MainContentHolder">
    <%--<div id="homepagecolumn1">
        <uc1:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="System Homepage 1" />
    </div>
    <div id="homepagecolumn2">
        <uc1:ContentColumnControl ID="ContentColumnControl2" runat="server" ColumnName="System Homepage 2" />
    </div>
    <div id="homepagecolumn3">
        <uc1:ContentColumnControl ID="ContentColumnControl3" runat="server" ColumnName="System Homepage 3" />
    </div>
    <!-- Google Sitelinks Search Box JSON-LD schema -- https://developers.google.com/webmasters/richsnippets/sitelinkssearch -->
    <script type="application/ld+json">
    {
      "@context": "http://schema.org",
      "@type": "WebSite",
      "url": "<%= Me.CanonicalUrl%>",
      "potentialAction": {
        "@type": "SearchAction",
        "target": "<%= BVSoftware.BVC5.Core.WebAppSettings.SiteStandardRoot.TrimEnd("/"c)%>/search.aspx?q={search_term}",
        "query-input": "required name=search_term"
      }
    }
    </script>--%>
    <div>
        <uc1:ContentColumnControl ID="ContentColumnControl2" runat="server" ColumnName="System Homepage 5" />
    </div>
</asp:Content>
