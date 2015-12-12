<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="EventLog.aspx.vb" Inherits="BVAdmin_Configuration_EventLog" Title="Untitled Page" %>

<asp:Content ID="header" ContentPlaceHolderID="headcontent" runat="server">

<style type="text/css">
    .popbg{  
        display:none;  
        position:fixed;   
        _position:absolute; /* hack for internet explorer 6*/ 
        height:100%;  
        width:100%;  
        top:0;  
        left:0;  
        background:#000000;  
        border:1px solid #cecece;  
        z-index:1;  
    }  
    .popup .description {}
    .popup{  
        display:none;  
        position:fixed;  
        _position:absolute; /* hack for internet explorer 6*/  
        top: 20%;
	    left: 20%;
	    right: 20%; 
        background:#ffffee;  
        border:2px solid #cecece;  
        z-index:2;  
        padding:30px;  
        font-size:13px;  
    }  
    .popupclose {
	    display:block;
	    text-align:center;
	    position: absolute;
	    top: 10px;
	    right: 15px;
    }
</style>



    <script type="text/javascript">

        function ShowPopup(pop) {

            var windowWidth = document.documentElement.clientWidth;
            var windowHeight = document.documentElement.clientHeight;
            var popupHeight = 300;
            var popupWidth = 500;

            $('.popbg').css({  
             "opacity": "0.7"  
            });  

            $('.popbg').fadeIn('fast');
            $(pop).fadeIn('fast');  
            
        }
                   
        function ClosePopup(pop)
        {
            $(pop).hide();
            $('.popbg').hide();
        }
           
        // Jquery Setup
        $(document).ready(function() {
            $('.popuplink').click(
                function() {
                    var p = $(this).parent();
                    ShowPopup(p.children('.popup'));
                    return false;
                }
            );
            
            $('.popupclose').click(
                function()
                {
                    var p = $(this).parent();
                    ClosePopup(p);
                    return false;
                }
            )
            
            $('.popbg').click(
                function()
                {                    
                    var p = $('.popup:visible');
                    ClosePopup(p);
                    return false;
                }
            )

        });
    </script>

</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    
    <h1>Audit Log</h1>
    
    <div class="f-row">
		<div class="three columns">
        	<asp:RadioButtonList ID="lstFilter" runat="server" AutoPostBack="True">
                <asp:ListItem Value="">All</asp:ListItem>
                <asp:ListItem Value="0">General</asp:ListItem>
                <asp:ListItem Value="1">Catalog</asp:ListItem>
                <asp:ListItem Value="2">Inventory</asp:ListItem>
                <asp:ListItem Value="3">Users</asp:ListItem>
                <asp:ListItem Value="4">Marketing</asp:ListItem>
                <asp:ListItem Value="5">Payment</asp:ListItem>
                <asp:ListItem Value="6">Orders</asp:ListItem>
                <asp:ListItem Value="7">Reporting</asp:ListItem>
                <asp:ListItem Value="8">Plug-Ins</asp:ListItem>
                <asp:ListItem Value="98">System</asp:ListItem>
                <asp:ListItem Value="99">BV Internal</asp:ListItem>                
            </asp:RadioButtonList>
            <br />
            <asp:ImageButton ID="ClearEventsButton" ImageUrl="../images/buttons/ClearAll.png" OnClientClick="return window.confirm('Are you sure you want to clear events older than 1 year?');" runat="server" ToolTip="Clear All" />
            <br /><br /><span class="smallText">(only events older than 1 year<br /> will be removed)</span>
        </div>
        <div class="nine columns">
        	<asp:Literal ID="litEvents" runat="server" EnableViewState="false"></asp:Literal>
            <asp:Literal ID="litPager" runat="server" EnableViewState="false"></asp:Literal>  
            <div class="popbg">&nbsp;</div>          
        </div>
    </div>
 
</asp:Content>
