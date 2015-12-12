<%@ Control Language="VB" AutoEventWireup="false" CodeFile="DatePicker.ascx.vb" Inherits="BVAdmin_Controls_DatePicker" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<div style="position: relative;">
    <anthem:TextBox ID="DateTextBox" runat="server"></anthem:TextBox>
    <anthem:ImageButton ID="CalendarShowImageButton" runat="server" style="vertical-align:middle;" ImageUrl="~/BVAdmin/Images/Buttons/Calendar.png" CausesValidation="False" />
    
    <bvc5:BVCustomValidator ID="DateCustomValidator" runat="server" ControlToValidate="DateTextBox" display="dynamic">*</bvc5:BVCustomValidator>
    <bvc5:BVRequiredFieldValidator ID="DateRequiredValidator" runat="server" ControlToValidate="DateTextBox" display="dynamic">*</bvc5:BVRequiredFieldValidator>

	<anthem:Calendar ID="Calendar" runat="server" Visible="False" style="position:absolute; top:30px; left:0; z-index: 100;" BackColor="White" />
</div>



