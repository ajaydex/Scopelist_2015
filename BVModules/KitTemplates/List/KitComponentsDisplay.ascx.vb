Imports BVSoftware.Bvc5.Core
Imports System.IO
Imports System.Collections.ObjectModel

Partial Class BVModules_KitTemplates_List_KitComponentsDisplay
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
        Return _isValid
    End Function

    Public Sub WriteToLineItem(ByVal item As BVSoftware.Bvc5.Core.Orders.LineItem) Implements IKitDisplay.WriteToLineItem
        Services.KitService.WriteKitToLineItem(item, Me.KitSelections)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If TypeOf Me.Page Is BaseStoreProductPage Then
            Me.Kit = DirectCast(Me.Page, BaseStoreProductPage).LocalProduct

            If Me.Kit.IsInStock Then
                Me.Visible = True
                Dim kitComponentsArgs As New KitComponentsChangedEventArgs()
                kitComponentsArgs.KitSelections = New Catalog.KitSelections(Me.Kit)

                If Page.IsPostBack Then
                    For Each key As String In Request.Form.AllKeys
                        For Each Group As Catalog.KitGroup In Me.Kit.Groups
                            For Each component As Catalog.KitComponent In Group.Components
                                If key.Contains(component.Bvin) Then
                                    Dim value As String = Request.Form(key)
                                    If Not kitComponentsArgs.KitSelections.SelectedValues.ContainsKey(component) Then
                                        kitComponentsArgs.KitSelections.SelectedValues.Add(component, New Collection(Of String)())
                                    End If
                                    kitComponentsArgs.KitSelections.SelectedValues(component).Add(value)
                                    Exit For
                                End If
                            Next
                        Next
                    Next
                Else
                    Dim lineItemId As String = Request.QueryString("LineItemId")
                    If (lineItemId IsNot Nothing) AndAlso (Not String.IsNullOrEmpty(lineItemId)) Then
                        Dim lineItem As Orders.LineItem = Orders.LineItem.FindByBvin(lineItemId)
                        If lineItem.KitSelections IsNot Nothing Then
                            kitComponentsArgs.KitSelections = lineItem.KitSelections
                        Else
                            kitComponentsArgs.KitSelections = Services.KitService.GetKitDefaultSelections(Me.Kit)
                        End If
                    Else
                        kitComponentsArgs.KitSelections = Services.KitService.GetKitDefaultSelections(Me.Kit)
                    End If
                End If

                Me.KitSelections = kitComponentsArgs.KitSelections

                'check to see if we have all of our selections
                _isValid = Services.KitService.IsKitValid(Me.Kit, Me.KitSelections)

                'render controls
                For Each component As Catalog.KitComponent In Me.Kit.Groups(0).Components
                    If KitDisplayHelper.DoRenderComponent(component) Then
                        Dim tr1 As New HtmlTableRow
                        componentsTable.controls.add(tr1)
                        Dim td1 As New HtmlTableCell
                        Dim cellContents As String = KitDisplayHelper.RenderComponentSmallImage(component, Me.Page) + KitDisplayHelper.RenderNameWithWrapper(component)
                        td1.InnerHtml = cellContents
                        tr1.Controls.Add(td1)

                        Dim tr2 As New HtmlTableRow
                        componentsTable.controls.add(tr2)
                        Dim input As HtmlGenericControl = KitDisplayHelper.RenderComponentInput(Me.KitSelections, component)
                        Dim td2 As New HtmlTableCell
                        td2.Controls.Add(input)
                        tr2.Controls.Add(td2)
                    End If
                Next

                RaiseEvent KitComponentsChanged(Me, kitComponentsArgs)
            Else
                Me.Visible = False
            End If
        End If
    End Sub

    
End Class
