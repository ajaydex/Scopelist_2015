Imports BVSoftware.Bvc5.Core
Imports System.IO
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Controls_KitComponentsDisplay
    Inherits System.Web.UI.UserControl
    Implements IKitDisplay

    Private _kit As Catalog.Product = Nothing
    Private _kitSelections As Catalog.KitSelections = Nothing
    Private _isValid As Boolean = False

    Public Property Kit() As Catalog.Product
        Get
            Return _kit
        End Get
        Set(ByVal value As Catalog.Product)
            _kit = value
        End Set
    End Property

    Public Property KitSelections() As Catalog.KitSelections
        Get
            Return _kitSelections
        End Get
        Set(ByVal value As Catalog.KitSelections)
            _kitSelections = value
        End Set
    End Property

    Public Event KitComponentsChanged(ByVal sender As Object, ByVal args As KitComponentsChangedEventArgs)

    Public Function GetSelections(ByVal currentProduct As BVSoftware.Bvc5.Core.Catalog.Product) As BVSoftware.Bvc5.Core.Catalog.KitSelections Implements IKitDisplay.GetSelections
        Return Me.KitSelections
    End Function

    Public Function IsValid() As Boolean Implements IKitDisplay.IsValid        
        Return Services.KitService.IsKitValid(Me.Kit, Me.KitSelections)
    End Function

    Public Sub WriteToLineItem(ByVal item As BVSoftware.Bvc5.Core.Orders.LineItem) Implements IKitDisplay.WriteToLineItem
        Services.KitService.WriteKitToLineItem(item, Me.KitSelections)
    End Sub

    Public Sub Initialize(ByVal lineItemId As String)
        Dim li As Orders.LineItem = Orders.LineItem.FindByBvin(lineItemId)
        If li.AssociatedProduct IsNot Nothing Then
            Initialize(li.AssociatedProduct)
        End If
    End Sub

    Public Sub Initialize(ByVal product As Catalog.Product)
        Me.KitSelections = New Catalog.KitSelections(product)
        Me.Kit = product
        If product.IsKit Then
            If Page.IsPostBack Then
                For Each key As String In Request.Form.AllKeys
                    For Each Group As Catalog.KitGroup In Me.Kit.Groups
                        For Each component As Catalog.KitComponent In Group.Components
                            If key.Contains(component.Bvin) Then
                                Dim value As String = Request.Form(key)
                                If Not Me.KitSelections.SelectedValues.ContainsKey(component) Then
                                    Me.KitSelections.SelectedValues.Add(component, New Collection(Of String)())
                                End If
                                Me.KitSelections.SelectedValues(component).Add(value)
                                Exit For
                            End If
                        Next
                    Next
                Next
            End If
	    
            RenderControls()
	        
        End If
    End Sub

    Public Sub LoadFromLineItem(ByVal li As Orders.LineItem)
        If li.AssociatedProduct Is Nothing Then
            Return
        End If

        Me.Kit = li.AssociatedProduct
        If li.KitSelections IsNot Nothing Then
            Me.KitSelections = li.KitSelections
        Else
            Me.KitSelections = Services.KitService.GetKitDefaultSelections(Me.Kit)
        End If

        RenderControls()
    End Sub

    Private Sub RenderControls()
        For Each component As Catalog.KitComponent In Me.Kit.Groups(0).Components
            If KitDisplayHelper.DoRenderComponent(component) Then
                Dim tr1 As New HtmlTableRow
                componentsTable.Controls.Add(tr1)
                Dim td1 As New HtmlTableCell
                Dim cellContents As String = KitDisplayHelper.RenderComponentSmallImage(component, Me.Page) + KitDisplayHelper.RenderNameWithWrapper(component)
                td1.InnerHtml = cellContents
                tr1.Controls.Add(td1)

                Dim tr2 As New HtmlTableRow
                componentsTable.Controls.Add(tr2)
                Dim input As HtmlGenericControl = KitDisplayHelper.RenderComponentInput(Me.KitSelections, component)
                Dim td2 As New HtmlTableCell
                td2.Controls.Add(input)
                tr2.Controls.Add(td2)
            End If
        Next
    End Sub

End Class
