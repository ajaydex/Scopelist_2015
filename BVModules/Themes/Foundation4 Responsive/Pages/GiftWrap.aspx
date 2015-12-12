<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="GiftWrap.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_GiftWrap" Title="Gift Wrap" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <h1>Gift Wrap</h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <asp:Panel ID="pnlDesc" runat="server">
        <asp:Literal ID="Description" runat="server" Text="<p>We'll wrap some or all of the items in your order and include the personalized message. Choose the item you wish to gift wrap, check the Gift Wrap option, then enter your name in the From field and the name of the recipient in the To field. Enter a special greeting in the Message field and when you are finished, click Continue.</p>"></asp:Literal>
    </asp:Panel>

    <div class="row">
        <div class="large-2 columns">
            <asp:Image ID="imgProduct" runat="server" AlternateText="" />
        </div>
        <div class="large-10 columns">
            <h2><asp:Label ID="lblitemdescription" runat="server"></asp:Label></h2>
            <h3>Gift Wrap Price: <strong><asp:Label ID="lblgiftwrapprice" runat="server"></asp:Label>/each</strong></h3>

            
                
            <asp:Repeater ID="repeatercontrol" runat="server">
                <ItemTemplate>
                    <fieldset>
                        <!--<h4><asp:Literal ID="lblGiftMessage" runat="server" Text="Gift Message"></asp:Literal></h4>-->
                                
                        <asp:CheckBox ID="chkGiftWrap" runat="server" Text="Gift Wrap This Product" />
                                
                        <div class="row">
                            <div class="large-6 columns">
                                <label><asp:Literal ID="lblTo" runat="server" Text="To:"></asp:Literal></label>
                                <asp:TextBox ID="txtToField" runat="server"></asp:TextBox>
                            </div>
                            <div class="large-6 columns">
                                <label><asp:Literal ID="lblFrom" runat="server" Text="From:"></asp:Literal></label>
                                <asp:TextBox ID="txtFromField" runat="server"></asp:TextBox>
                            </div>
                            <div class="large-12 columns">
                                <label><asp:Literal ID="lblMessage" runat="server" Text="Message:"></asp:Literal></label>
                                <asp:TextBox ID="txtMessageField" runat="server" Columns="50" TextMode="MultiLine" Rows="3"></asp:TextBox>
                            </div>
                        </div>
                               
                    </fieldset>
                </ItemTemplate>
            </asp:Repeater>
                    
            <asp:ImageButton ID="btnContinue" runat="server" CausesValidation="false" ImageUrl="~/BVModules/Themes/Print Book/Images/Buttons/ContinueToCart.png" AlternateText="Continue" />
                  
        </div>
    </div>
</asp:Content>
