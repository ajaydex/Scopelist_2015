'Imports BVSoftware.Bvc5.Core

'Partial Class BVAdmin_People_ContactUsQuestionEdit
'    Inherits BaseAdminPage

'    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
'        If Not Page.IsPostBack Then
'            Me.Page.Form.DefaultButton = CancelImageButton.UniqueID
'            If Request.QueryString("id") IsNot Nothing Then
'                Dim question As Contacts.ContactUsQuestion = Contacts.ContactUsQuestion.FindByBvin(Request.QueryString("id"))
'                ViewState("Question") = question
'                If question.Type = Contacts.ContactUsQuestionType.MultipleChoice Then
'                    QuestionTextBox.Text = question.Values(question.Values.Count - 1).Value
'                    question.Values.RemoveAt(question.Values.Count - 1)
'                End If
'            Else
'                ViewState("Question") = New Contacts.ContactUsQuestion()
'            End If

'            InitializeInput()
'        Else
'            Dim question As Contacts.ContactUsQuestion = ViewState("Question")
'            If QuestionTypeRadioButtonList.SelectedIndex = Contacts.ContactUsQuestionType.MultipleChoice Then
'                For Each row As GridViewRow In ValuesGridView.Rows
'                    If row.RowType = DataControlRowType.DataRow Then
'                        question.Values(row.RowIndex).Value = DirectCast(row.FindControl("ValueTextBox"), TextBox).Text
'                    End If
'                Next
'            End If
'            ViewState("Question") = question
'        End If
'    End Sub

'    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
'        If QuestionTypeRadioButtonList.SelectedIndex = Contacts.ContactUsQuestionType.MultipleChoice Then
'            Dim question As Contacts.ContactUsQuestion = ViewState("Question")
'            InitializeGrid(question)
'        End If
'    End Sub

'    Protected Sub InitializeGrid(ByVal question As Contacts.ContactUsQuestion)
'        For Each row As GridViewRow In ValuesGridView.Rows
'            If row.RowType = DataControlRowType.DataRow Then
'                DirectCast(row.FindControl("ValueTextBox"), TextBox).Text = question.Values(row.RowIndex).Value
'            End If
'        Next
'    End Sub

'    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
'        Me.PageTitle = "Contact Us Config"
'        Me.CurrentTab = AdminTabType.People
'        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
'    End Sub

'    Protected Sub InitializeInput()
'        Dim question As Contacts.ContactUsQuestion = ViewState("Question")
'        QuestionTypeRadioButtonList.SelectedIndex = question.Type
'        NameTextBox.Text = question.Name
'        If question.Type = Contacts.ContactUsQuestionType.FreeAnswer Then
'            MultipleChoicePanel.Visible = False
'            If question.Values.Count = 0 Then
'                Dim questionOption As New Contacts.ContactUsQuestionOption()
'                questionOption.Bvin = System.Guid.NewGuid.ToString()
'                question.Values.Add(questionOption)
'            End If
'            QuestionTextBox.Text = question.Values(0).Value
'        ElseIf question.Type = Contacts.ContactUsQuestionType.MultipleChoice Then
'            MultipleChoicePanel.Visible = True
'            QuestionTypeRadioButtonList.SelectedIndex = question.Type
'            BindQuestionOptionsGrid(question)
'        End If
'    End Sub

'    Protected Sub QuestionTypeRadioButtonList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles QuestionTypeRadioButtonList.SelectedIndexChanged
'        Dim question As Contacts.ContactUsQuestion = ViewState("Question")
'        question.Values.Clear()
'        If QuestionTypeRadioButtonList.SelectedIndex = Contacts.ContactUsQuestionType.FreeAnswer Then
'            MultipleChoicePanel.Visible = False
'        ElseIf QuestionTypeRadioButtonList.SelectedIndex = Contacts.ContactUsQuestionType.MultipleChoice Then
'            MultipleChoicePanel.Visible = True
'        End If
'        ViewState("Question") = question
'    End Sub

'    Protected Sub NewOptionImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles NewOptionImageButton.Click
'        Dim question As Contacts.ContactUsQuestion = ViewState("Question")
'        Dim questionOption As New Contacts.ContactUsQuestionOption()
'        questionOption.Bvin = System.Guid.NewGuid().ToString()
'        question.Values.Add(questionOption)
'        BindQuestionOptionsGrid(question)
'        ViewState("Question") = question
'    End Sub

'    Protected Sub BindQuestionOptionsGrid(ByVal question As Contacts.ContactUsQuestion)
'        ValuesGridView.DataSource = question.Values
'        ValuesGridView.DataKeyNames = New String() {"bvin"}
'        ValuesGridView.DataBind()
'    End Sub

'    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
'        Dim question As Contacts.ContactUsQuestion = ViewState("Question")
'        question.Type = QuestionTypeRadioButtonList.SelectedIndex
'        question.Name = NameTextBox.Text
'        If question.Type = Contacts.ContactUsQuestionType.FreeAnswer Then
'            question.Values.Clear()
'            Dim item As New Contacts.ContactUsQuestionOption(QuestionTextBox.Text)
'            question.Values.Add(item)
'        ElseIf question.Type = Contacts.ContactUsQuestionType.MultipleChoice Then
'            For Each row As GridViewRow In ValuesGridView.Rows
'                If row.RowType = DataControlRowType.DataRow Then
'                    question.Values(row.RowIndex).Value = DirectCast(row.FindControl("ValueTextBox"), TextBox).Text
'                End If
'            Next
'            question.Values.Add(New Contacts.ContactUsQuestionOption(QuestionTextBox.Text))
'        End If

'        If question.Bvin = String.Empty Then
'            Contacts.ContactUsQuestion.Insert(question)
'        Else
'            Contacts.ContactUsQuestion.Update(question)
'        End If
'        Response.Redirect("~/BVAdmin/People/ContactUsConfig.aspx")
'    End Sub

'    Protected Sub ValuesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ValuesGridView.RowDeleting
'        Dim question As Contacts.ContactUsQuestion = ViewState("Question")
'        Dim itemToRemove As Contacts.ContactUsQuestionOption = Nothing
'        Dim key As String = ValuesGridView.DataKeys(e.RowIndex).Value
'        For Each item As Contacts.ContactUsQuestionOption In question.Values
'            If item.Bvin = key Then
'                itemToRemove = item
'            End If
'        Next
'        question.Values.Remove(itemToRemove)
'        BindQuestionOptionsGrid(question)
'        ViewState("Question") = question
'    End Sub

'    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
'        Response.Redirect("~/BVAdmin/People/ContactUsConfig.aspx")
'    End Sub
'End Class

Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_People_ContactUsQuestionEdit
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.Page.Form.DefaultButton = CancelImageButton.UniqueID
            If Request.QueryString("id") IsNot Nothing Then
                Dim question As Contacts.ContactUsQuestion = Contacts.ContactUsQuestion.FindByBvin(Request.QueryString("id"))
                ViewState("Question") = question
                If question.Type = Contacts.ContactUsQuestionType.MultipleChoice Then
                    QuestionTextBox.Text = question.Values(question.Values.Count - 1).Value
                    question.Values.RemoveAt(question.Values.Count - 1)
                End If
            Else
                ViewState("Question") = New Contacts.ContactUsQuestion()
            End If

            InitializeInput()
        Else
            Dim question As Contacts.ContactUsQuestion = ViewState("Question")
            If QuestionTypeRadioButtonList.SelectedIndex = Contacts.ContactUsQuestionType.MultipleChoice Then
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
        If QuestionTypeRadioButtonList.SelectedIndex = Contacts.ContactUsQuestionType.MultipleChoice Then
            Dim question As Contacts.ContactUsQuestion = ViewState("Question")
            InitializeGrid(question)
        End If
    End Sub

    Protected Sub InitializeGrid(ByVal question As Contacts.ContactUsQuestion)
        For Each row As GridViewRow In ValuesGridView.Rows
            If row.RowType = DataControlRowType.DataRow Then
                DirectCast(row.FindControl("ValueTextBox"), TextBox).Text = question.Values(row.RowIndex).Value
            End If
        Next
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Contact Us Config"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub InitializeInput()
        Dim question As Contacts.ContactUsQuestion = ViewState("Question")
        QuestionTypeRadioButtonList.SelectedIndex = question.Type
        NameTextBox.Text = question.Name
        If question.Type = Contacts.ContactUsQuestionType.FreeAnswer Then
            MultipleChoicePanel.Visible = False
            If question.Values.Count = 0 Then
                Dim questionOption As New Contacts.ContactUsQuestionOption()
                questionOption.Bvin = System.Guid.NewGuid.ToString()
                question.Values.Add(questionOption)
            End If
            QuestionTextBox.Text = question.Values(0).Value
        ElseIf question.Type = Contacts.ContactUsQuestionType.TextArea Then
            MultipleChoicePanel.Visible = False
            If question.Values.Count = 0 Then
                Dim questionOption As New Contacts.ContactUsQuestionOption()
                questionOption.Bvin = System.Guid.NewGuid.ToString()
                question.Values.Add(questionOption)
            End If
            QuestionTextBox.Text = question.Values(0).Value
        ElseIf question.Type = Contacts.ContactUsQuestionType.MultipleChoice Then
            MultipleChoicePanel.Visible = True
            QuestionTypeRadioButtonList.SelectedIndex = question.Type
            BindQuestionOptionsGrid(question)
        End If
    End Sub

    Protected Sub QuestionTypeRadioButtonList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles QuestionTypeRadioButtonList.SelectedIndexChanged
        Dim question As Contacts.ContactUsQuestion = ViewState("Question")
        question.Values.Clear()
        If QuestionTypeRadioButtonList.SelectedIndex = Contacts.ContactUsQuestionType.FreeAnswer Then
            MultipleChoicePanel.Visible = False
        ElseIf QuestionTypeRadioButtonList.SelectedIndex = Contacts.ContactUsQuestionType.TextArea Then
            MultipleChoicePanel.Visible = False
        ElseIf QuestionTypeRadioButtonList.SelectedIndex = Contacts.ContactUsQuestionType.MultipleChoice Then
            MultipleChoicePanel.Visible = True
        End If
        ViewState("Question") = question
    End Sub

    Protected Sub NewOptionImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles NewOptionImageButton.Click
        Dim question As Contacts.ContactUsQuestion = ViewState("Question")
        Dim questionOption As New Contacts.ContactUsQuestionOption()
        questionOption.Bvin = System.Guid.NewGuid().ToString()
        question.Values.Add(questionOption)
        BindQuestionOptionsGrid(question)
        ViewState("Question") = question
    End Sub

    Protected Sub BindQuestionOptionsGrid(ByVal question As Contacts.ContactUsQuestion)
        ValuesGridView.DataSource = question.Values
        ValuesGridView.DataKeyNames = New String() {"bvin"}
        ValuesGridView.DataBind()
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        Dim question As Contacts.ContactUsQuestion = ViewState("Question")
        question.Type = QuestionTypeRadioButtonList.SelectedIndex
        question.Name = NameTextBox.Text
        If question.Type = Contacts.ContactUsQuestionType.FreeAnswer Then
            question.Values.Clear()
            Dim item As New Contacts.ContactUsQuestionOption(QuestionTextBox.Text)
            question.Values.Add(item)
        ElseIf question.Type = Contacts.ContactUsQuestionType.TextArea Then
            question.Values.Clear()
            Dim item As New Contacts.ContactUsQuestionOption(QuestionTextBox.Text)
            question.Values.Add(item)
        ElseIf question.Type = Contacts.ContactUsQuestionType.MultipleChoice Then
            For Each row As GridViewRow In ValuesGridView.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    question.Values(row.RowIndex).Value = DirectCast(row.FindControl("ValueTextBox"), TextBox).Text
                End If
            Next
            question.Values.Add(New Contacts.ContactUsQuestionOption(QuestionTextBox.Text))
        End If

        If question.Bvin = String.Empty Then
            Contacts.ContactUsQuestion.Insert(question)
        Else
            Contacts.ContactUsQuestion.Update(question)
        End If
        Response.Redirect("~/BVAdmin/People/ContactUsConfig.aspx")
    End Sub

    Protected Sub ValuesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ValuesGridView.RowDeleting
        Dim question As Contacts.ContactUsQuestion = ViewState("Question")
        Dim itemToRemove As Contacts.ContactUsQuestionOption = Nothing
        Dim key As String = ValuesGridView.DataKeys(e.RowIndex).Value
        For Each item As Contacts.ContactUsQuestionOption In question.Values
            If item.Bvin = key Then
                itemToRemove = item
            End If
        Next
        question.Values.Remove(itemToRemove)
        BindQuestionOptionsGrid(question)
        ViewState("Question") = question
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        Response.Redirect("~/BVAdmin/People/ContactUsConfig.aspx")
    End Sub
End Class

