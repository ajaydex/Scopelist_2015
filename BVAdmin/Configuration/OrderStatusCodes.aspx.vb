Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_OrderStatusCodes
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Order Status Code Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadCodes()
        End If
    End Sub

    Private Sub LoadCodes()
        Me.GridView1.DataSource = Orders.OrderStatusCode.FindAll
        Me.GridView1.DataBind()
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Me.msg.ClearMessage()
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        Orders.OrderStatusCode.MoveDown(bvin)
        LoadCodes()
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Me.msg.ClearMessage()
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        Orders.OrderStatusCode.MoveUp(bvin)
        LoadCodes()
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Me.msg.ClearMessage()
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString

        Dim c As Orders.OrderStatusCode = Orders.OrderStatusCode.FindByBvin(bvin)
        If c IsNot Nothing Then
            If c.SystemCode = True Then
                Me.msg.ShowWarning("System codes can not be deleted")
            Else
                Orders.OrderStatusCode.Delete(bvin)
            End If
        End If

        LoadCodes()
    End Sub

    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOk.Click
        Response.Redirect("Orders.aspx")
    End Sub

    Protected Sub btnNet_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNet.Click
        msg.ClearMessage()
        If Me.NewStatusNameField.Text.Trim.Length > 0 Then
            Dim c As New Orders.OrderStatusCode
            c.StatusName = Me.NewStatusNameField.Text.Trim
            c.SystemCode = False
            Orders.OrderStatusCode.Insert(c)
        Else
            msg.ShowWarning("Please enter a name for the new status code.")
        End If
        LoadCodes()
    End Sub
End Class
