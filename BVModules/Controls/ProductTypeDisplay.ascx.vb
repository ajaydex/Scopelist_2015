Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_ProductTypeDisplay
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.Visible = False

            If TypeOf Me.Page Is BaseStoreProductPage Then
                Dim prodPage As BaseStoreProductPage = DirectCast(Me.Page, BaseStoreProductPage)
                Dim productTypeId As String = String.Empty
                Dim productId As String = String.Empty
                If prodPage.LocalProduct.ParentId <> String.Empty Then
                    Dim parentProduct As Catalog.Product = Catalog.InternalProduct.FindByBvin(prodPage.LocalProduct.ParentId)
                    If parentProduct IsNot Nothing Then
                        productId = parentProduct.Bvin
                        productTypeId = parentProduct.ProductTypeId
                    End If
                Else
                    productId = prodPage.LocalProduct.Bvin
                    productTypeId = prodPage.LocalProduct.ProductTypeId
                End If

                Dim productTypePropertiesValues As New Collection(Of String)
                If productTypeId.Trim <> String.Empty Then
                    Dim props As Collections.Generic.List(Of Catalog.ProductProperty) = Catalog.ProductType.FindPropertiesForType(productTypeId)
                    For Each prop As Catalog.ProductProperty In props
                        productTypePropertiesValues.Add(Catalog.InternalProduct.GetPropertyValue(productId, prop.Bvin))
                    Next
                    Dim sb As New StringBuilder()
                    Dim initialized As Boolean = False
                    For i As Integer = 0 To (props.Count - 1)
                        If props(i).DisplayOnSite Then
                            Me.Visible = True

                            Dim currentValue As String = Catalog.ProductProperty.GetProductTypePropertyValue(props(i), productTypePropertiesValues(i))

                            'If text property is empty, do not display                            
                            If Not WebAppSettings.TypePropertiesDisplayEmptyProperties Then
                                If (currentValue = String.Empty) Then
                                    Continue For
                                End If
                            End If

                            If Not initialized Then
                                initialized = True
                                sb.Append("<ul class=""typedisplay"">")
                            End If

                            If i Mod 2 = 0 Then
                                sb.Append("<li>")
                            Else
                                sb.Append("<li class=""alt"">")
                            End If
                            sb.Append("<span class=""productpropertylabel"">")
                            sb.Append(props(i).DisplayName)
                            sb.Append("</span>")
                            sb.Append("<span class=""productpropertyvalue"">")
                            sb.Append(currentValue)
                            sb.Append("</span>")
                            sb.Append("</li>")
                        End If
                    Next
                    If initialized Then
                        sb.Append("</ul>")
                    End If
                    TypeLiteral.Text = sb.ToString()
                End If
            End If
        End If
    End Sub

    
End Class