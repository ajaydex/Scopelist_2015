<%@ Control Language="vb" AutoEventWireup="false" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_StyleSheetSelector" CodeFile="StyleSheetSelector.ascx.vb" %>

<h2>Themes</h2>
<div class="row">
    <div class="large-6 small-6 columns">
        <label>Select a Theme</label>
        <asp:DropDownList ID="ThemeField" runat="server" AutoPostBack="True"></asp:DropDownList>
        <asp:ImageButton ID="btnSave" CausesValidation="true" ToolTip="Save Changes" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/SaveChanges.png"></asp:ImageButton>
        <br /><br />
        <asp:ImageButton ID="btnCancel" runat="server" ToolTip="Cancel" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
    </div>
    <div class="large-6 small-6 columns">
        <asp:Image ID="PreviewImage" runat="server" />
    </div>
</div>

       
        




