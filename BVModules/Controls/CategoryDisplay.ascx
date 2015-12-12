<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CategoryDisplay.ascx.vb" Inherits="BVModules_Controls_CategoryDisplay" %>

<div class="viewswrapper">
    <a id="GridView" class="<%= If(Me.IsGridView(), "active", "")%>">Grid</a> <a id="ListView" class="<%= If(Me.IsListView(), "active", "")%>">List</a>
</div>