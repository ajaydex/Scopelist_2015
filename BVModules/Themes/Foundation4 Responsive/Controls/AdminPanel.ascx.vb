Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_AdminPanel
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.pnlMain.Visible = False

        Dim newWindow As String
        If WebAppSettings.StoreAdminLinksInNewWindow = True Then
            newWindow = "_blank"
        Else
            newWindow = ""
        End If

        If SessionManager.IsAdminUser = True Then
            Me.pnlMain.Visible = True

            Dim s As New StringBuilder
            's.Append("<a href=""" & Page.ResolveUrl("~/") & "BVAdmin/Default.aspx" & """ target=""" & newWindow & """>")
            's.Append("Go To Admin")
            's.Append("</a>")
            Me.lnkGoToAdmin.NavigateUrl = Page.ResolveUrl("~/") & "BVAdmin/Default.aspx"
            Me.lnkGoToAdmin.Text = "Go To Admin"
            Me.lnkGoToAdmin.Target = newWindow

            ' Store open/closed
            If WebAppSettings.StoreClosed = True Then
                Me.btnToggleStore.ToolTip = "Store is CLOSED"
                Me.btnToggleStore.Text = "Open Store"
                Me.btnToggleStore.OnClientClick = "return window.confirm('OPEN store?');"
            Else
                Me.btnToggleStore.ToolTip = "Store is OPEN"
                Me.btnToggleStore.Text = "Close Store"
                Me.btnToggleStore.OnClientClick = "return window.confirm('Are you sure that you want to CLOSE the store (customers will not be able to view the site)?');"
            End If

            If TypeOf Me.Page Is BaseStoreProductPage Then
                Dim prodId As String = Request.QueryString("productID")
                Dim product As Catalog.Product = Nothing
                If Not String.IsNullOrEmpty(prodId) Then
                    product = Catalog.InternalProduct.FindByBvinLight(prodId)
                End If

                If product IsNot Nothing Then
                    Dim sb As New StringBuilder()
                    If product.SpecialProductType = Catalog.SpecialProductTypes.Normal Then
                        sb.Append("<a href=""" & Page.ResolveUrl("~/") & "BVAdmin/Catalog/Products_Edit.aspx?id=" & Request.QueryString("productID") & """ target=""" & newWindow & """ TabIndex=""3""> <i class=""fa fa-pencil-square-o""></i> ")
                        sb.Append("Edit this Product")
                        sb.Append("</a>")
                    ElseIf product.SpecialProductType = Catalog.SpecialProductTypes.GiftCertificate OrElse product.SpecialProductType = Catalog.SpecialProductTypes.ArbitrarilyPricedGiftCertificate Then
                        sb.Append("<a href=""" & Page.ResolveUrl("~/") & "BVAdmin/Catalog/GiftCertificateEdit.aspx?id=" & Request.QueryString("productID") & """ target=""" & newWindow & """ TabIndex=""3""> <i class=""fa fa-pencil-square-o""></i> ")
                        sb.Append("Edit this Gift Certificate")
                        sb.Append("</a>")
                    ElseIf product.SpecialProductType = Catalog.SpecialProductTypes.Kit Then
                        sb.Append("<a href=""" & Page.ResolveUrl("~/") & "BVAdmin/Catalog/Kit_Edit.aspx?id=" & Request.QueryString("productID") & """ target=""" & newWindow & """ TabIndex=""3""> <i class=""fa fa-pencil-square-o""></i> ")
                        sb.Append("Edit this Kit")
                        sb.Append("</a>")
                    Else
                        Throw New InvalidOperationException("The special product type of " & [Enum].GetName(GetType(Catalog.SpecialProductTypes), product.SpecialProductType) & " is invalid for this method.")
                    End If
                    Me.editLinks.Text = sb.ToString()
                    Me.editLinks.Visible = True
                End If

            ElseIf TypeOf Me.Page Is BaseStoreCategoryPage Then
                Dim catId As String = Request.QueryString("categoryID")
                If Not String.IsNullOrEmpty(catId) Then
                    Dim sb As New StringBuilder()
                    sb.Append("<a href=""" & Page.ResolveUrl("~/") & "BVAdmin/Catalog/Categories_Edit.aspx?id=" & catId & """ target=""" & newWindow & """ TabIndex=""3""> <i class=""fa fa-pencil-square-o""></i> ")
                    sb.Append("Edit this Category")
                    sb.Append("</a>")
                    Me.editLinks.Text = sb.ToString()
                    Me.editLinks.Visible = True
                End If

            ElseIf TypeOf Me.Page Is BaseStoreCustomPage Then
                Dim pageId As String = Request.QueryString("id")
                If Not String.IsNullOrEmpty(pageId) Then
                    Dim sb As New StringBuilder()
                    sb.Append("<a href=""" & Page.ResolveUrl("~/") & "BVAdmin/Content/CustomPages_Edit.aspx?id=" & pageId & """ target=""" & newWindow & """ TabIndex=""3""> <i class=""fa fa-pencil-square-o""></i> ")
                    sb.Append("Edit this Page")
                    sb.Append("</a>")
                    Me.editLinks.Text = sb.ToString()
                    Me.editLinks.Visible = True
                End If
            End If


            If String.Compare(Request.Url.AbsolutePath, "/" + WebAppSettings.DefaultHomePage, True) = 0 Then
                Dim sb As New StringBuilder
                sb.Append("<a href=""" & Page.ResolveUrl("~/") & "BVAdmin/Content/Columns_Edit.aspx?id=1"" target=""" & newWindow & """ TabIndex=""4""> <i class=""fa fa-pencil-square-o""></i> ")
                sb.Append("Column 1")
                sb.Append("</a>")
                sb.Append(" - ")
                sb.Append("<a href=""" & Page.ResolveUrl("~/") & "BVAdmin/Content/Columns_Edit.aspx?id=2"" target=""" & newWindow & """ TabIndex=""5""> <i class=""fa fa-pencil-square-o""></i> ")
                sb.Append("Column 2")
                sb.Append("</a>")
                sb.Append(" - ")
                sb.Append("<a href=""" & Page.ResolveUrl("~/") & "BVAdmin/Content/Columns_Edit.aspx?id=3"" target=""" & newWindow & """ TabIndex=""6""> <i class=""fa fa-pencil-square-o""></i> ")
                sb.Append("Column 3")
                sb.Append("</a>")
                Me.editLinks.Text = sb.ToString()
                Me.editLinks.Visible = True
            End If



            'Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
            'If u IsNot Nothing Then
            '    Me.lnkLogout.Text = "Logout (" & u.FirstName & " " & u.LastName & ")"
            'Else
            '    Me.lnkLogout.Text = "Logout"
            'End If

        End If

    End Sub

    Protected Sub btnToggleStore_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnToggleStore.Click
        Dim p As New Collection(Of String)
        p.Add(Membership.SystemPermissions.LoginToAdmin)
        p.Add(Membership.SystemPermissions.SettingsEdit)

        If Membership.UserAccount.DoesUserHaveAllPermissions(SessionManager.GetCurrentUserId, p) = True Then
            If WebAppSettings.StoreClosed = False Then
                WebAppSettings.StoreClosed = True
            Else
                WebAppSettings.StoreClosed = False
            End If
        End If

        Response.Redirect(Request.RawUrl)
    End Sub

End Class