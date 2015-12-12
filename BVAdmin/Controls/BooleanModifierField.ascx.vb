Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_BooleanModifierField
    Inherits Controls.ModificationControl(Of Boolean)

    Public Enum Modes
        YesNo = 0
        EnabledDisabled = 1
    End Enum

    Public Property DisplayMode() As Modes
        Get
            Dim obj As Object = ViewState("mode")
            If obj IsNot Nothing Then
                Return DirectCast(obj, Modes)
            Else
                Return Modes.YesNo
            End If

        End Get
        Set(ByVal value As Modes)
            ViewState("mode") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If DisplayMode = Modes.YesNo Then
                BooleanDropDownList.Items.Clear()
                Dim li As New ListItem("Yes", "1", True)
                li.Selected = True
                BooleanDropDownList.Items.Add(li)
                li = New ListItem("No", "0", True)
                BooleanDropDownList.Items.Add(li)
            ElseIf DisplayMode = Modes.EnabledDisabled Then
                BooleanDropDownList.Items.Clear()
                Dim li As New ListItem("Enabled", "1", True)
                li.Selected = True
                BooleanDropDownList.Items.Add(li)
                li = New ListItem("Disabled", "0", True)
                BooleanDropDownList.Items.Add(li)
            End If
        End If
    End Sub

    Public Overloads Overrides Function ApplyChanges(ByVal item As Boolean) As Boolean
        If Me.BooleanDropDownList.SelectedValue = "0" Then
            Return False
        Else
            Return True
        End If
    End Function
End Class
