<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Categories_ManualSelection.aspx.vb" Inherits="BVAdmin_Catalog_Categories_ManualSelection"
    Title="Category Selection" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc1" %>


<asp:Content ContentPlaceHolderID="headcontent" runat="server" ID="headcss">
    <style type="text/css">
        .selected-products {padding:5px 0;}
        .dragitem 
        {
            border:solid 1px #ccc; background-color:#efefef; padding:5px;
            -webkit-border-radius:3px;
            -moz-border-radius:3px;
        }
        .ui-state-highlight {height:35px; background-color:#ff0;}
        .actionlink {font-size:18px;}
    </style>    
    <script type="text/javascript">

         function RemoveProduct(lnk) {

             var id = $(lnk).attr('id');
             $.post('Categories_RemoveProduct.aspx',
                                                { id: id.replace('rem', ''),
                                                    categoryid: '<%=CategoryBvin %>'
                                                },
                                                 function() {
                                                     lnk.parent().parent().parent().parent().parent().slideUp('slow');
                                                     lnk.parent().parent().parent().parent().parent().remove();
                                                 }
                                                );                                                               
         }
     </script>
    <script type="text/javascript">                                         
        // Jquery Setup
         $(document).ready(function() {
             $(".selected-products").sortable({
                 placeholder: 'ui-state-highlight',
                 axis: 'y',
                 opacity: '0.75',
                 cursor: 'move',
                 update: function(event, ui) {
                     //alert('Sending Sort:' + $(this).sortable('toArray'));
                     $.post('Categories_SortProducts.aspx',
                                                { ids: $(this).sortable('toArray').toString(),
                                                    categoryid: '<%=CategoryBvin %>'
                                                }
                                                );
                 }
             });
             $(".selected-products").disableSelection();

             $('.trash').click(function() {
                 RemoveProduct($(this));                 
                 return false;
             });

         });
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Select Products for Category</h1>
    <uc2:MessageBox ID="msg" runat="server" />
    
    <div class="f-row">
    	<div class="six columns">
            <h2>Selected Products</h2>
            <asp:HyperLink ID="lnkImportExport" runat="server" ToolTip="Import/Export" ImageUrl="~/BVAdmin/Images/Buttons/ImportExport.png" CssClass="iframe" />
            <div class="selected-products">
                <asp:Literal ID="litProducts" runat="server"></asp:Literal>
            </div>
            <asp:hyperlink class="actionlink" ID="lnkBack" runat="server">&laquo; Return to Category</asp:hyperlink>
        </div>

        <div class="six columns">
            <h2>Pick Products To Add</h2>
            <uc1:ProductPicker ID="ProductPicker1" runat="server" DisplayKits="true" />
            <br />
            <asp:ImageButton ID="btnAdd" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" />
        </div>
    </div>     
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>
