Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_People_UserQuestionEdit
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.Page.Form.DefaultButton = CancelImageButton.UniqueID
            If Request.QueryString("id") IsNot Nothing Then
                Dim question As Membership.UserQuestion = Membership.UserQuestion.FindByBvin(Request.QueryString("id"))
                ViewState("Question") = question
                If question.Type = Membership.UserQuestionType.MultipleChoice Then
                    QuestionTextBox.Text = question.Values(question.Values.Count - 1).Value
                    question.Values.RemoveAt(question.Values.Count - 1)
                End If
            Else
                ViewState("Question") = New Membership.UserQuestion()
            End If

            InitializeInput()
        Else
            Dim question As Membership.UserQuestion = ViewState("Question")
            If QuestionTypeRadioButtonList.SelectedIndex = Membership.UserQuestionType.MultipleChoice Then
                For Each row As GridViewRow In ValuesGridView.Rows
                    If row.RowType = DataControlRowType.DataRow Then
                        question.Values(row.RowIndex).Value = DirectCast(row.FindControl("ValueTextBox"), TextBox).Text
                    End If
                Next
            End If
            ViewState("Question") = question
        End If
    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If QuestionTypeRadioButtonList.SelectedIndex = Membership.UserQuestionType.MultipleChoice Then
            Dim question As Membership.UserQuestion = ViewState("Question")
            InitializeGrid(question)
        End If
    End Sub

    Protected Sub InitializeGrid(ByVal question As Membership.UserQuestion)
        For Each row As GridViewRow In ValuesGridView.Rows
            If row.RowType = DataControlRowType.DataRow Then
                DirectCast(row.FindControl("ValueTextBox"), TextBox).Text = question.Values(row.RowIndex).Value
            End If
        Next
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "User Signup Config"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub InitializeInput()
        Dim question As Membership.UserQuestion = ViewState("Question")
        QuestionTypeRadioButtonList.SelectedIndex = question.Type
        NameTextBox.Text = question.Name
        If question.Type = Membership.UserQuestionType.FreeAnswer Then
            MultipleChoicePanel.Visible = False
            If question.Values.Count = 0 Then
                Dim questionOption As New Membership.UserQuestionOption()
                questionOption.Bvin = System.Guid.NewGuid.ToString()
                question.Values.Add(questionOption)
            End If
            QuestionTextBox.Text = question.Values(0).Value
        ElseIf question.Type = Membership.UserQuestionType.MultipleChoice Then
            MultipleChoicePanel.Visible = True
            QuestionTypeRadioButtonList.SelectedIndex = question.Type
            BindQuestionOptionsGrid(question)
        End If
    End Sub

    Protected Sub QuestionTypeRadioButtonList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles QuestionTypeRadioButtonList.SelectedIndexChanged
        Dim question As Membership.UserQuestion = ViewState("Question")
        question.Values.Clear()
        If QuestionTypeRadioButtonList.SelectedIndex = Membership.UserQuestionType.FreeAnswer Then
            MultipleChoicePanel.Visible = False
        ElseIf QuestionTypeRadioButtonList.SelectedIndex = Membership.UserQuestionType.MultipleChoice Then
            MultipleChoicePanel.Visible = True
        End If
        ViewState("Question") = question
    End Sub

    Protected Sub NewOptionImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles NewOptionImageButton.Click
        Dim question As Membership.UserQuestion = ViewState("Question")
        Dim questionOption As New Membership.UserQuestionOption()
        questionOption.Bvin = System.Guid.NewGuid().ToString()
        question.Values.Add(questionOption)
        BindQuestionOptionsGrid(question)
        ViewState("Question") = question
    End Sub

    Protected Sub BindQuestionOptionsGrid(ByVal question As Membership.UserQuestion)
        ValuesGridView.DataSource = question.Values
        ValuesGridView.DataKeyNames = New String() {"bvin"}
        ValuesGridView.DataBind()
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        Dim question As Membership.UserQuestion = ViewState("Question")
        question.Type = QuestionTypeRadioButtonList.SelectedIndex
        question.Name = NameTextBox.Text
        If question.Type = Membership.UserQuestionType.FreeAnswer Then
            question.Values.Clear()
            Dim item As New Membership.UserQuestionOption(QuestionTextBox.Text)
            question.Values.Add(item)
        ElseIf question.Type = Membership.UserQuestionType.MultipleChoice Then
            For Each row As GridViewRow In ValuesGridView.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    question.Values(row.RowIndex).Value = DirectCast(row.FindControl("ValueTextBox"), TextBox).Text
                End If
            Next
            question.Values.Add(New Membership.UserQuestionOption(QuestionTextBox.Text))
        End If

        If question.Bvin = String.Empty Then
            Membership.UserQuestion.Insert(question)
        Else
            Membership.UserQuestion.Update(question)
        End If
        Response.Redirect("~/BVAdmin/People/UserSignupConfig.aspx")
    End Sub

    Protected Sub ValuesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ValuesGridView.RowDeleting
        Dim question As Membership.UserQuestion = ViewState("Question")
        Dim itemToRemove As Membership.UserQuestionOption = Nothing
        Dim key As String = ValuesGridView.DataKeys(e.RowIndex).Value
        For Each item As Membership.UserQuestionOption In question.Values
            If item.Bvin = key Then
                itemToRemove = item
            End If
        Next
        question.Values.Remove(itemToRemove)
        BindQuestionOptionsGrid(question)
        ViewState("Question") = question
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        Response.Redirect("~/BVAdmin/People/UserSignupConfig.aspx")
    End Sub
End Class
