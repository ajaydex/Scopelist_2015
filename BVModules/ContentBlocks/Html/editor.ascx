<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Html_editor" %>
<%@ Register Src="../../../BVAdmin/Controls/HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc1" %>
<%@ Register Src="~/BVAdmin/Controls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc2" %>

<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
    <script type="text/javascript">
        function MoveVarsTo(id) {
            document.getElementById('<%= EnableReplacementTags.ClientID %>').checked = true;

            var textbox = $('textarea[id^="' + id + '"]')[0];
            var listbox = $('#<%= Tags.ClientID%>')[0];
            textbox.value += listbox.options[listbox.selectedIndex].value;
            textbox.focus();
        }

        $(document).ready(function() {
            $('#startEndDates').toggle(<%= EnableScheduledContent.Checked.ToString().ToLower()%>)
            $('#queryStringParams').toggle(<%= ShowHideByQueryString.Checked.ToString().ToLower()%>);
        });
    </script>

    <div class="f-row">

        <div class="nine columns">

            <div class="f-row">
                <div class="ten columns">
                    <span>Default HTML Code:</span> <br />
                    <uc1:HtmlEditor ID="HtmlEditor1" runat="server" EditorHeight="300" EditorWidth="570" EditorWrap="true" />
                </div>
                <div class="two columns">
                    <br />
                    <input type="button" value="<" onclick="MoveVarsTo('<%= HtmlEditor1.ClientID%>')" />
                </div>
            </div>
            
            <br />
            <br />
            <asp:CheckBox ID="EnableScheduledContent" Text=" Schedule alternate Html" onclick="$('#startEndDates').toggle()" runat="server" />
            
            <div id="startEndDates" class="f-row">
                <br />
                <div class="ten columns">
                    <span>Scheduled Html Code:</span> <br />
                    <uc1:HtmlEditor ID="HtmlEditor2" runat="server" EditorHeight="300" EditorWidth="570" EditorWrap="true" />

                    <br />
                    <br />

                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="formlabel">Start Date</td>
                            <td class="formfield" colspan="2">
                                <uc2:DatePicker ID="StartDatePicker" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">End Date</td>
                            <td class="formfield" colspan="2">
                                <uc2:DatePicker ID="EndDatePicker" runat="server" />
                            </td>
                        </tr>
                    </table>

                </div>
                <div class="two columns">
                    <br />
                    <input type="button" value="<" onclick="MoveVarsTo('<%= HtmlEditor2.ClientID%>')" />
                </div>
            </div>

            <br />
            <br />
            <asp:CheckBox ID="ShowHideByQueryString" Text=" Show/Hide content based on query string" onclick="$('#queryStringParams').toggle()" runat="server" /><br />
            (e.g. <%= BVSoftware.BVC5.Core.WebAppSettings.SiteStandardRoot%>AnyPage.aspx?<strong>name</strong>=<strong>value</strong>)
            
            <div id="queryStringParams" class="f-row">
                <br />
                <div class="ten columns">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="formlabel">Name:</td>
                            <td class="formfield"><asp:TextBox ID="QueryStringName" runat="server" /></td>
                        </tr>
                        <tr>
                            <td class="formlabel">Value:</td>
                            <td class="formfield"><asp:TextBox ID="QueryStringValue" runat="server" /></td>
                        </tr>
                    </table>
                </div>
            </div>

            <br />
            <br />
            <asp:CheckBox ID="RemoveWrappingDiv" Text="Remove wrapping div tag - only the HTML entered above will be displayed" runat="server" />
        </div>

        <div class="three columns">
            <span>Available Tags:</span><br />
            <asp:ListBox ID="Tags" style="font-size:11px;" runat="server" Height="420" SelectionMode="single"></asp:ListBox>
            <br />
            <br />
            <asp:CheckBox ID="EnableReplacementTags" Text=" Use Replacement Tags" runat="server" />
        </div>  
    </div>

    <hr />

    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
    &nbsp;
    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />

    <hr />
</asp:Panel>