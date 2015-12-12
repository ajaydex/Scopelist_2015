Imports Microsoft.VisualBasic

Public Class BaseStoreProductMasterPage
    Inherits System.Web.UI.MasterPage

    Private _errorMessage As IMessageBox = Nothing
    Private _childContentHolder As ContentPlaceHolder = Nothing

    Public Property MessageBox() As IMessageBox
        Get
            Return _errorMessage
        End Get
        Set(ByVal value As IMessageBox)
            _errorMessage = value
        End Set
    End Property

    Public Property ChildContentHolder() As ContentPlaceHolder
        Get
            Return _childContentHolder
        End Get
        Set(ByVal value As ContentPlaceHolder)
            _childContentHolder = value
        End Set
    End Property

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If (Me.ChildContentHolder IsNot Nothing) AndAlso (Me.MessageBox IsNot Nothing) Then
            If TypeOf Me.Page Is BaseStoreProductPage Then
                Dim productPage As BaseStoreProductPage = DirectCast(Me.Page, BaseStoreProductPage)
                If productPage.LocalProduct IsNot Nothing Then
                    If productPage.LocalProduct.Status = BVSoftware.Bvc5.Core.Catalog.ProductStatus.Disabled Then
                        Me.ChildContentHolder.Visible = False
                        Me.MessageBox.ShowError("Product Could Not Be Found.")
                    End If
                Else
                    Me.ChildContentHolder.Visible = False
                    Me.MessageBox.ShowError("Product Could Not Be Found.")
                End If
                productPage.MessageBox = Me.MessageBox
            End If
        End If
    End Sub
End Class
