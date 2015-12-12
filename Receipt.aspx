<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="Receipt.aspx.vb" Inherits="Receipt" %>

<%@ Register Src="BVModules/Controls/ViewOrder.ascx" TagName="ViewOrder" TagPrefix="uc1" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/AnalyticsTags.ascx" TagName="AnalyticsTags"
    TagPrefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div class="breadcrumb">
        <a href="Default.aspx">Home</a> &gt; <a href="Cart.aspx">Shopping Cart</a> &gt;
        Receipt
    </div>
    <h1>
        <span>Thank You! </span>
    </h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <div id="product_det-blk">
        <asp:Label ID="lblOrderNumber" runat="server"></asp:Label>
        <asp:Panel ID="DownloadsPanel" runat="server" Visible="false">
            <h2>
                File Downloads</h2>
            <asp:GridView ID="FilesGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin">
                <Columns>
                    <asp:BoundField DataField="ShortDescription" HeaderText="File Name" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="DownloadImageButton" runat="server" AlternateText="Download"
                                CommandName="Download" ImageUrl="~/BVModules/Themes/Print Book/images/Buttons/Download.png" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            &nbsp;<br />
        </asp:Panel>
        <asp:HyperLink ID="lnkDownloadAgain" runat="Server" Visible="false" NavigateUrl="~/MyAccount_Orders.aspx"
            Text="You can download files at anytime from the My Account section of the store."></asp:HyperLink>
        <uc1:ViewOrder DisableReturns="true" ID="ViewOrder1" runat="server" DisableNotesAndPayment="true"
            DisableStatus="true" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="EndOfForm" runat="server">
    <!-- Google Code for Purchase Conversion Page -->
    <script type="text/javascript">
        /* <![CDATA[ */
        var google_conversion_id = 981512774;
        var google_conversion_language = "en";
        var google_conversion_format = "2";
        var google_conversion_color = "ffffff";
        var google_conversion_label = "2N7dCMqSjwkQxuSC1AM";
        var google_conversion_value = 1200.000000;
        var google_remarketing_only = false;
        /* ]]> */
    </script>
    <script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
    </script>
    <noscript>
        <div style="display: inline;">
            <img height="1" width="1" style="border-style: none;" alt="" src="//www.googleadservices.com/pagead/conversion/981512774/?value=1200.000000&amp;label=2N7dCMqSjwkQxuSC1AM&amp;guid=ON&amp;script=0" />
        </div>
    </noscript>
    <script type="text/javascript">        if (!window.mstag) mstag = { loadTag: function () { }, time: (new Date()).getTime() };</script>
    <script id="mstag_tops" type="text/javascript" src="//flex.msn.com/mstag/site/9381c8d2-3f78-46fb-b04c-97f55f468f53/mstag.js"></script>
    <script type="text/javascript">        mstag.loadTag("analytics", { dedup: "1", domainId: "3038567", type: "1", actionid: "250119" })</script>
    <noscript>
        <iframe src="//flex.msn.com/mstag/tag/9381c8d2-3f78-46fb-b04c-97f55f468f53/analytics.html?dedup=1&domainId=3038567&type=1&actionid=250119"
            frameborder="0" scrolling="no" width="1" height="1" style="visibility: hidden;
            display: none"></iframe>
    </noscript>
    <uc4:AnalyticsTags ID="AnalyticsTags1" runat="server" />
</asp:Content>
