Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.Collections.ObjectModel


Partial Class BVModules_ContentBlocks_Reviews_to_Moderate_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim reviews As String = Catalog.ProductReview.GetNotApproved.Count.ToString

            If reviews <= 0 Then
                ModerateLink.Text = "No Reviews to Moderate"
            ElseIf reviews = 1 Then
                ModerateLink.Text = "Moderate " & reviews & " Review"
            Else
                ModerateLink.Text = "Moderate " & reviews & " Reviews"
            End If
        End If

    End Sub
End Class
