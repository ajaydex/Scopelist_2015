
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_People_AffiliateSignupConfig
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'update questions with an order
            Dim questions As Collection(Of Contacts.AffiliateQuestion) = Contacts.AffiliateQuestion.FindAll()
            Dim count As Integer = 1
            For Each question As Contacts.AffiliateQuestion In questions
                If count = 1 Then
                    If question.Order <> 0 Then
                        Exit For
                    End If
                End If
                question.Order = count
                count += 1
                Contacts.AffiliateQuestion.Update(question)
            Next

            BindQuestionsGrid()
        End If
    End Sub

    Protected Sub BindQuestionsGrid()
        QuestionsGridView.DataSource = Contacts.AffiliateQuestion.FindAll()
        QuestionsGridView.DataKeyNames = New String() {"bvin"}
        QuestionsGridView.DataBind()
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Affiliate Signup Config"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub QuestionsGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles QuestionsGridView.RowEditing
        Response.Redirect("~/BVAdmin/People/AffiliateQuestionEdit.aspx?id=" & HttpUtility.UrlEncode(QuestionsGridView.DataKeys(e.NewEditIndex).Value))
    End Sub

    Protected Sub QuestionsGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles QuestionsGridView.RowDeleting
        Contacts.AffiliateQuestion.Delete(QuestionsGridView.DataKeys(e.RowIndex).Value)
        BindQuestionsGrid()
    End Sub

    Protected Sub NewImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles NewImageButton.Click
        Response.Redirect("~/BVAdmin/People/AffiliateQuestionEdit.aspx")
    End Sub

    Protected Sub QuestionsGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles QuestionsGridView.RowCommand
        If e.CommandName = "MoveItem" Then
            If TypeOf e.CommandSource Is ImageButton Then
                Dim row As GridViewRow = DirectCast(DirectCast(e.CommandSource, ImageButton).Parent.Parent, GridViewRow)
                Dim _primaryKey As String = DirectCast(sender, GridView).DataKeys(row.RowIndex).Value
                'the down arrow actually moves items up the list
                If e.CommandArgument = "Down" Then
                    Contacts.AffiliateQuestion.MoveUp(_primaryKey)
                ElseIf e.CommandArgument = "Up" Then
                    Contacts.AffiliateQuestion.MoveDown(_primaryKey)
                End If
                BindQuestionsGrid()
            End If
        End If
    End Sub
End Class
