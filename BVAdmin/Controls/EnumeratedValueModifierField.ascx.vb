Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_EnumeratedValueModifierField
    Inherits Controls.ModificationControl(Of String)

    Public Property DisplayNone() As Boolean
        Get
            Dim val As Object = ViewState("displayNone")
            If val IsNot Nothing Then
                Return DirectCast(val, Boolean)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("displayNone") = value
        End Set
    End Property

    Public Property Datasource() As Object
        Get
            Return EnumeratedValueDropDownList.DataSource
        End Get
        Set(ByVal value As Object)
            EnumeratedValueDropDownList.DataSource = value
        End Set
    End Property

    Public Property DataTextField() As String
        Get
            Return EnumeratedValueDropDownList.DataTextField
        End Get
        Set(ByVal value As String)
            EnumeratedValueDropDownList.DataTextField = value
        End Set
    End Property

    Public Property DataValueField() As String
        Get
            Return EnumeratedValueDropDownList.DataValueField
        End Get
        Set(ByVal value As String)
            EnumeratedValueDropDownList.DataValueField = value
        End Set
    End Property

    Public Overrides Function ApplyChanges(ByVal item As String) As String
        Return EnumeratedValueDropDownList.SelectedValue
    End Function

    Public Overrides Sub DataBind()
        EnumeratedValueDropDownList.DataBind()
        If DisplayNone Then
            Dim li As New ListItem("None", "")
            EnumeratedValueDropDownList.Items.Insert(0, li)
        End If
    End Sub
End Class
