<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MessageBox.ascx.vb" Inherits="BVModules_Controls_MessageBox"
    EnableViewState="false" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%--<anthem:Panel runat="server" ID="pnlMain" Visible="false" EnableViewState="false">
    <div class="messagebox">
        <ul id="MessageList" runat="server" enableviewstate="false"></ul>                        
    </div>
    <div style="clear: both;"></div>
</anthem:Panel>--%>
<anthem:Panel runat="server" ID="pnlMain" Visible="false" EnableViewState="false">
    <%--    <div class="error_panel" style="padding-top: 3px;">
        <div class="blk_er">
            <ul id="MessageList" runat="server" enableviewstate="false">
            </ul>
        </div>
    </div>--%>
    <div style="margin-top: 3px;" runat="server" id="divInfo">
        <div runat="server" id="divInnerInfo">
            <ul id="MessageList" runat="server" enableviewstate="false" class="info_message"
                style="margin-top: 0px;">
            </ul>
        </div>
    </div>
    <div style="margin-top: 3px;" runat="server" id="divWarning">
        <div runat="server" id="divInnerWarning">
            <ul id="WarningList" runat="server" enableviewstate="false" class="info_warning">
            </ul>
        </div>
    </div>
    <div style="margin-top: 3px;" runat="server" id="dvSuccess">
        <div runat="server" id="divInnerSuccess">
            <ul id="SuccessList" runat="server" enableviewstate="false" class="info_Success">
            </ul>
        </div>
    </div>
    <div style="margin-top: 3px;" runat="server" id="divError">
        <div runat="server" id="divInnerError">
            <ul id="ErrorList" runat="server" enableviewstate="false" class="info_error">
            </ul>
        </div>
    </div>
    <div style="margin-top: 3px;" runat="server" id="divQuestion">
        <div runat="server" id="divInnerQuestion">
            <ul id="QuestionList" runat="server" enableviewstate="false" class="info_Question">
            </ul>
        </div>
    </div>
    <div style="margin-top: 3px;" runat="server" id="divException">
        <div runat="server" id="divInnerException">
            <ul id="ExceptionList" runat="server" enableviewstate="false" class="info_message">
            </ul>
        </div>
    </div>
    <div style="clear: both;">
    </div>
</anthem:Panel>
