Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_ContentBlocks_Category_Rotator_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load        
        Me.PreHtml.Text = SettingsManager.GetSetting("PreHtml")
        Me.PostHtml.Text = SettingsManager.GetSetting("PostHtml")

        Dim showInOrder As Boolean = SettingsManager.GetBooleanSetting("ShowInOrder")
        Dim nextIndex As Integer
        If Session(Me.BlockId & "NextImageIndex") IsNot Nothing Then
            nextIndex = CInt(Session(Me.BlockId & "NextImageIndex"))
        Else
            nextIndex = 0
        End If
        Dim settings As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Categories")

        If settings.Count <> 0 Then
            If settings.Count > nextIndex Then
                LoadCategory(settings(nextIndex).Setting1)
            ElseIf nextIndex >= settings.Count Then
                If showInOrder Then
                    nextIndex = 0
                Else
                    nextIndex = BVSoftware.Web.RandomNumbers.RandomInteger(settings.Count - 1, 0)
                End If
                LoadCategory(settings(nextIndex).Setting1)
            End If

            If showInOrder Then
                nextIndex += 1
            Else
                nextIndex = BVSoftware.Web.RandomNumbers.RandomInteger(settings.Count - 1, 0)
            End If
            Session(Me.BlockId & "NextImageIndex") = nextIndex
        End If
    End Sub

    Private Sub LoadCategory(ByVal categoryId As String)        
        Dim c As Catalog.Category = Catalog.Category.FindByBvin(categoryId)
        If c IsNot Nothing Then
            If c.Bvin <> String.Empty Then
                Dim destination As String = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, Catalog.Category.FindAllLight())

                If c.ImageUrl.StartsWith("~") OrElse c.ImageUrl.StartsWith("http://") Then
                    Me.CategoryIconLink.ImageUrl = Utilities.ImageHelper.SafeImage(Page.ResolveUrl(c.ImageUrl))
                Else
                    Me.CategoryIconLink.ImageUrl = Utilities.ImageHelper.SafeImage(Page.ResolveUrl("~/" & c.ImageUrl))
                End If

                Me.CategoryIconLink.NavigateUrl = destination
                Me.CategoryIconLink.ToolTip = c.MetaTitle

                Me.CategoryLink.Text = c.Name
                Me.CategoryLink.NavigateUrl = destination
                Me.CategoryLink.ToolTip = c.MetaTitle                

                If c.SourceType = Catalog.CategorySourceType.CustomLink Then
                    If c.CustomPageOpenInNewWindow = True Then
                        Me.CategoryLink.Target = "_blank"
                        Me.CategoryIconLink.Target = "_blank"
                    End If
                End If

            End If
        End If
    End Sub
End Class
