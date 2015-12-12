Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Controls_KitComponentViewer
    Inherits System.Web.UI.UserControl

    Public Event PartsChanged As EventHandler

    Public Property ComponentId() As String
        Get
            Return Me.ComponentIdField.Value
        End Get
        Set(ByVal value As String)
            Me.ComponentIdField.Value = value
            LoadParts()
        End Set
    End Property

    Public Sub LoadParts()
        Dim ps As Collection(Of Catalog.KitPart) = Catalog.KitPart.FindByComponentId(Me.ComponentId)
        If ps IsNot Nothing Then
            Me.GridView1.DataSource = ps
            Me.GridView1.DataBind()

        End If
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        Catalog.KitPart.MoveUp(bvin)
        LoadParts()
        RaiseEvent PartsChanged(Me, System.EventArgs.Empty)
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim DescriptionLiteral As Literal = e.Row.FindControl("DescriptionLiteral")
            If DescriptionLiteral IsNot Nothing Then
                Dim descriptionText As String
                Dim k As Catalog.KitPart = CType(e.Row.DataItem, Catalog.KitPart)
                descriptionText = k.Description & " - " & k.Price.ToString("C")
                If k.Quantity > 1 Then
                    descriptionText += " Qty: " & k.Quantity
                End If

                If k.IsTiedToProduct Then                    
                    If (Not k.IsVisibleInKit) Then
                        descriptionText = "<del>" & descriptionText & "</del>"
                    End If

                    If (k.Product.Status = Catalog.ProductStatus.Disabled) Then
                        descriptionText = descriptionText & " *"
                    End If

                    Dim productUrl As String = Me.ResolveUrl("~/BVAdmin/Catalog/Products_Edit.aspx?id=" & k.ProductBvin)
                    DescriptionLiteral.Text = "<a href=""" & productUrl & """ title=""Strikethrough = out of stock, * = disabled product"">" & descriptionText & "</a>"
                Else
                    DescriptionLiteral.Text = descriptionText
                End If
            End If
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        Catalog.KitPart.Delete(bvin)
        LoadParts()
        RaiseEvent PartsChanged(Me, System.EventArgs.Empty)
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("~/BVAdmin/Catalog/KitPart_Edit.aspx?id=" & bvin)
    End Sub


    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        Catalog.KitPart.MoveDown(bvin)
        LoadParts()
        RaiseEvent PartsChanged(Me, System.EventArgs.Empty)
    End Sub

End Class
