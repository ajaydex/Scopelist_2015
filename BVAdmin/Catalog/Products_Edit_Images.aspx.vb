Imports System.IO
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Drawing.Drawing2D
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class products_products_edit_images
    Inherits BaseProductAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Product Images"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load

        Response.Cache.SetExpires(System.DateTime.UtcNow.ToLocalTime)
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetValidUntilExpires(True)

        RegisterWindowScripts()

        If Not Page.IsPostBack Then
            Me.ProductIdField.Value = Request.QueryString("id")
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.ProductIdField.Value)
            If Not String.IsNullOrEmpty(p.ParentId) Then
                Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, p.ParentId))
            End If
            LoadImages()
        End If

    End Sub

    Private Sub LoadImages()
        Dim images As Collection(Of Catalog.ProductImage) = Catalog.ProductImage.FindByProductId(Me.ProductIdField.Value)
        If images.Count > 0 Then
            If images(0).SortOrder = -1 Then
                Dim order As Integer = 0
                For Each image As Catalog.ProductImage In images
                    image.SortOrder = order
                    order += 1
                    Catalog.ProductImage.Update(image)
                Next
            End If
        End If

        Me.GridView1.DataSource = images
        Me.GridView1.DataBind()
    End Sub

    Private Sub LoadEditor(ByVal bvin As String)
        Dim pi As Catalog.ProductImage = Catalog.ProductImage.FindByBvin(bvin)
        btnSave.Visible = False
        btnUpdate.Visible = True
        LoadEditorWithImage(pi)
    End Sub

    Private Sub LoadEditorWithImage(ByVal pi As Catalog.ProductImage)
        Me.EditBvin.Value = pi.Bvin
        Me.FileNameField.Text = pi.FileName        
        Me.CaptionField.Text = pi.Caption
        Me.AlternateTextField.Text = pi.AlternateText

        If File.Exists(Path.Combine(Request.PhysicalApplicationPath, pi.FileName)) = True Then
            Dim info As Utilities.ImageInfo
            info = Utilities.ImageHelper.GetImageInformation(Path.Combine(Request.PhysicalApplicationPath, pi.FileName))
            'Dim maxInfo As Utilities.ImageInfo = Utilities.ImageHelper.GetProportionalImageDimensionsForImage(info, 220, 220)
            'imgPreview.Width = maxInfo.Width
            'imgPreview.Height = maxInfo.Height
            Dim pictureUrl As String = "~/" & pi.FileName
            imgPreview.ImageUrl = pictureUrl.Replace("\", "/")
        Else
            imgPreview.ImageUrl = "~/BVAdmin/images/NoPreview.gif"
            'imgPreview.Width = Unit.Pixel(110)
            'imgPreview.Height = Unit.Pixel(110)
        End If

    End Sub

    Private Sub ClearEditor()
        Me.EditBvin.Value = String.Empty
        Me.FileNameField.Text = String.Empty
        Me.CaptionField.Text = String.Empty
        Me.AlternateTextField.Text = String.Empty
        imgPreview.ImageUrl = "~/BVAdmin/images/NoPreview.gif"
        'imgPreview.Width = Unit.Pixel(110)
        'imgPreview.Height = Unit.Pixel(110)
        Me.GridView1.EditIndex = -1
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        pnlEditor.Visible = True
        msg.ClearMessage()
        btnSave.Visible = True
        btnUpdate.Visible = False
        'Dim pi As New Catalog.ProductImage
        'pi.ProductID = Me.ProductIdField.Value
        'pi.FileName = ""
        'pi.Caption = "New Image"
        'If Catalog.ProductImage.Insert(pi) = True Then
        '    LoadEditorWithImage(pi)
        '    Me.LoadImages()
        'Else
        '    msg.ShowError("Couldn't Save New Product Image!")
        'End If
        ClearEditor()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        pnlEditor.Visible = False
        msg.ClearMessage()
        ClearEditor()
        LoadImages()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim pi As Catalog.ProductImage = CType(e.Row.DataItem, Catalog.ProductImage)

            Dim imgProduct As System.Web.UI.WebControls.Image
            imgProduct = CType(e.Row.Cells(0).FindControl("imgProduct"), System.Web.UI.WebControls.Image)
            If imgProduct IsNot Nothing Then
                If File.Exists(Path.Combine(Request.PhysicalApplicationPath, pi.FileName)) = True Then
                    Dim info As Utilities.ImageInfo = Utilities.ImageHelper.GetImageInformation(Path.Combine(Request.PhysicalApplicationPath, pi.FileName))
                    Dim maxInfo As Utilities.ImageInfo = Utilities.ImageHelper.GetProportionalImageDimensionsForImage(info, 110, 110)
                    imgProduct.Width = maxInfo.Width
                    imgProduct.Height = maxInfo.Height
                    imgProduct.ImageUrl = "~/" & pi.FileName.Replace("\", "/")
                    imgProduct.AlternateText = pi.AlternateText
                    imgProduct.ToolTip = pi.AlternateText
                Else
                    imgProduct.ImageUrl = "~/Bvadmin/images/NoPreview.gif"
                    imgProduct.Width = Unit.Pixel(110)
                    imgProduct.Height = Unit.Pixel(110)
                End If
            End If

            Dim lblFilename As Label = CType(e.Row.Cells(1).FindControl("lblFilename"), Label)
            If lblFilename IsNot Nothing Then
                lblFilename.Text = pi.FileName
            End If

            Dim litCaption As Literal = CType(e.Row.Cells(1).FindControl("litCaption"), Literal)
            If litCaption IsNot Nothing Then
                If Not String.IsNullOrEmpty(pi.Caption) Then
                    litCaption.Text = String.Format("<p style=""font-style: italic"">{0}</p>", pi.Caption)
                End If
            End If

            Dim btn As ImageButton = DirectCast(e.Row.FindControl("btnUp"), ImageButton)
            btn.CommandArgument = e.Row.DataItemIndex   'pi.Bvin

            btn = DirectCast(e.Row.FindControl("btnDown"), ImageButton)
            btn.CommandArgument = e.Row.DataItemIndex   'pi.Bvin
        End If
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As GridViewEditEventArgs) Handles GridView1.RowEditing

    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As GridViewDeleteEventArgs) Handles GridView1.RowDeleting

    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles btnSave.Click
        If Page.IsValid Then
            Save()
        End If
    End Sub

    Protected Overrides Function Save() As Boolean
        Dim result As Boolean = False
        If btnSave.Visible Then
            Dim pi As New Catalog.ProductImage
            pi.Bvin = Me.EditBvin.Value
            pi.ProductId = Me.ProductIdField.Value
            pi.AlternateText = Me.AlternateTextField.Text
            pi.Caption = Me.CaptionField.Text
            pi.FileName = Me.FileNameField.Text
            If Catalog.ProductImage.Insert(pi) = True Then
                Me.ClearEditor()
                msg.ShowOk("Changes Saved")
                result = True
            Else
                msg.ShowError("Error while saving changes")
            End If
            LoadImages()
            pnlEditor.Visible = False
        Else
            result = True
        End If
        
        Return result
    End Function

    Private Sub RegisterWindowScripts()

        Dim sb As New StringBuilder

        sb.Append("var w;")
        sb.Append("function popUpWindow(parameters) {")
        sb.Append("w = window.open(parameters, 'imageBrowser', 'resizable=yes, scrollbars=yes,height=505, width=950');")
        sb.Append("w.focus();")
        sb.Append("}")

        sb.Append("function closePopup() {")
        sb.Append("w.close();")
        sb.Append("self.focus();")
        sb.Append("}")

        sb.Append("function SetEditorImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.FileNameField.ClientID)
        sb.Append("').value = fileName;")
        sb.Append("document.getElementById('")
        sb.Append(Me.imgPreview.ClientID)
        sb.Append("').src = '../../'+fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "WindowScripts", sb.ToString, True)
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnUpdate.Click
        Dim pi As New Catalog.ProductImage
        pi.Bvin = Me.EditBvin.Value
        pi.ProductId = Me.ProductIdField.Value
        pi.AlternateText = Me.AlternateTextField.Text
        pi.Caption = Me.CaptionField.Text
        pi.FileName = Me.FileNameField.Text
        If Catalog.ProductImage.Update(pi) = True Then
            Me.ClearEditor()
            msg.ShowOk("Changes Saved")
        Else
            msg.ShowError("Error while saving changes")
        End If
        LoadImages()
        pnlEditor.Visible = False
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        msg.ClearMessage()
        Dim bvin As String = GridView1.DataKeys(e.CommandArgument).Value

        If e.CommandName = "Edit" Then
            pnlEditor.Visible = True
            Me.LoadEditor(bvin)
        ElseIf e.CommandName = "Delete" Then
            If Catalog.ProductImage.Delete(bvin) Then
                If bvin = Me.EditBvin.Value Then
                    pnlEditor.Visible = False
                End If
            End If
            LoadImages()
        ElseIf e.CommandName = "Up" Then
            Dim img As Catalog.ProductImage = Catalog.ProductImage.FindByBvin(bvin)
            If img IsNot Nothing AndAlso img.Bvin <> String.Empty Then
                Catalog.ProductImage.MoveUp(img)
            End If
            LoadImages()
        ElseIf e.CommandName = "Down" Then
            Dim img As Catalog.ProductImage = Catalog.ProductImage.FindByBvin(bvin)
            If img IsNot Nothing AndAlso img.Bvin <> String.Empty Then
                Catalog.ProductImage.MoveDown(img)
            End If
            LoadImages()
        End If
    End Sub

End Class