<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_Editors_TinyMCE_editor" %>

<script type="text/javascript">
	$(document).ready(function(){	    
        $("#<%=EditorField.ClientID %>").tinymce({
            script_url: '<%=Page.ResolveUrl("~/BVModules/Editors/TinyMCE/tiny_mce/tiny_mce.js")%>',
			relative_urls: false,
			remove_script_host: true,
			document_base_url: '<%=BVSoftware.Bvc5.Core.WebAppSettings.SiteStandardRoot%>',
			theme: "advanced",
			plugins: "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist",
			theme_advanced_buttons1: "code,fullscreen,preview,|,undo,redo,|,cut,copy,paste,|,search,replace,|,image,media,charmap",
			theme_advanced_buttons2: "formatselect,bold,italic,removeformat,|,bullist,numlist,table,|,link,unlink",
			theme_advanced_buttons3: "",
			theme_advanced_buttons4: "",
			theme_advanced_toolbar_location: "top",
			theme_advanced_toolbar_align: "left",
			theme_advanced_statusbar_location: "bottom",
			theme_advanced_resizing: true,
			//content_css: '<%=Page.ResolveUrl(BVSoftware.Bvc5.Core.PersonalizationServices.GetPersonalizedThemeVirtualPath() + "/styles/styles.css")%>',
			extended_valid_elements: "a[id|class|style|title|dir<ltr?rtl|lang|xml::lang|onclick|ondblclick|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onkeypress|onkeydown|onkeyuprel|rev|charset|hreflang|tabindex|accesskey|type|name|href|target|title|class|onfocus|onblur]"
		});
	});
</script>

<asp:TextBox ID="EditorField"  runat="server" Height="120px" TextMode="MultiLine" Width="300px" Wrap="False" />