<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_Editors_Markdown_editor" %>
<asp:TextBox ID="EditorField"  runat="server" Height="120px" TextMode="MultiLine"
    Width="300px" Wrap="False"></asp:TextBox><br />
    <span class="tiny">This editor supports <asp:hyperlink ID="lnkMarkdown" runat="server" Target="_blank" NavigateUrl="~/BVModules/Editors/Markdown/Help.aspx" Text="Markdown"></asp:hyperlink></span>