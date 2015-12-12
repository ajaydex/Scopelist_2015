<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_Default" %>

<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="headcontent">
	<%-- CONTENT IS INJECTED INTO THE <HEAD> --%>
</asp:Content>

<asp:Content ID="content2" runat="server" ContentPlaceHolderID="MainContentHolder">
    <uc:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="System Homepage 1" />
    <uc:ContentColumnControl ID="ContentColumnControl2" runat="server" ColumnName="System Homepage 2" />
    <uc:ContentColumnControl ID="ContentColumnControl3" runat="server" ColumnName="System Homepage 3" />

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
    </script>
</asp:Content>
