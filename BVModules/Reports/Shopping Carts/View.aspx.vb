Imports System.Collections.ObjectModel
Imports System.Collections.Generic
Imports System.Data
Imports System.Linq

Imports BVSoftware.BVC5.Core

Partial Class BVModules_Reports_Shopping_Carts_Default
    Inherits BaseAdminPage

    Private TotalSub As Decimal = 0    
    Private TotalCount As Integer = 0

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Reports - Shopping Carts"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack() Then
            LoadData()
            LoadTemplates()
        End If
    End Sub

    Sub LoadData()
        Try
            TotalSub = 0
            TotalCount = 0

            Dim c As New Orders.OrderSearchCriteria
            c.IsPlaced = False

            Dim carts As List(Of Orders.Order) = Orders.Order.FindByCriteria(c).ToList()

            ' filters
            If Me.chkExcludeEmptyCarts.Checked Then
                carts = carts.Where(Function(o) o.SubTotal > 0).ToList()
            End If
            If Me.chkExcludeCartsWithoutEmailAddresses.Checked Then
                carts = carts.Where(Function(o) Not String.IsNullOrEmpty(o.UserEmail)).ToList()
            End If
            If Me.chkExcludeEmailedCarts.Checked Then
                Dim emailCount As Integer = 0
                If Integer.TryParse(Me.txtNumberOfEmails.Text, emailCount) Then
                    If emailCount = 0 Then
                        carts = carts.Where(Function(o) Not o.CustomPropertyExists("Develisys", "CartAbandonmentSendCount") OrElse o.CustomPropertyGet("Develisys", "CartAbandonmentSendCount") = "0").ToList()
                    Else
                        carts = carts.Where(Function(o) o.CustomPropertyGet("Develisys", "CartAbandonmentSendCount") = emailCount.ToString()).ToList()
                    End If
                End If
            End If

            ' sorting
            If ViewState("SortExpression") IsNot Nothing Then
                Dim sortField As String = ViewState("SortExpression").ToString()
                Dim sortDir As SortDirection = CType(ViewState("SortDirection"), SortDirection)

                Select Case sortField.ToLower()
                    Case "timeoforder"
                        carts = carts.OrderBy(Function(o) o.TimeOfOrder).ToList()

                    Case "lastupdated"
                        carts = carts.OrderBy(Function(o) o.LastUpdated).ToList()

                    Case "subtotal"
                        carts = carts.OrderBy(Function(o) o.SubTotal).ToList()

                    Case "emailcount"
                        carts = carts.OrderBy(Function(o) o.CustomPropertyGet("Develisys", "CartAbandonmentSendCount")).ToList()

                End Select

                If sortDir = SortDirection.Descending Then
                    carts.Reverse()
                End If
            End If

            TotalCount = carts.Count
            TotalSub = carts.Sum(Function(o) o.SubTotal)

            gvCarts.DataSource = carts
            gvCarts.DataBind()

        Catch ex As Exception
            msg.ShowException(ex)
            EventLog.LogEvent(ex)
        End Try
    End Sub

    Private Sub gvCarts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvCarts.RowDataBound
        If e.Row.RowType = ListItemType.Item OrElse e.Row.RowType = ListItemType.AlternatingItem Then
            Dim o As Orders.Order = DirectCast(e.Row.DataItem, Orders.Order)

            Dim u As New Membership.UserAccount()
            If Not String.IsNullOrEmpty(o.UserID) Then
                u = Membership.UserAccount.FindByBvin(o.UserID)
            End If

            Dim lblName As Label = CType(e.Row.FindControl("lblName"), Label)
            If lblName IsNot Nothing Then
                If Not String.IsNullOrEmpty(u.Bvin) Then
                    lblName.Text = String.Format("{0} {1}<br/>", u.FirstName, u.LastName)
                ElseIf Not String.IsNullOrEmpty(o.BillingAddress.FullName) Then
                    lblName.Text = o.BillingAddress.FullName + "<br/>"
                ElseIf Not String.IsNullOrEmpty(o.ShippingAddress.FullName) Then
                    lblName.Text = o.ShippingAddress.FullName + "<br/>"
                End If
            End If

            If Not String.IsNullOrEmpty(o.UserEmail) Then
                Dim lnkEmail As HyperLink = CType(e.Row.FindControl("lnkEmail"), HyperLink)
                If lnkEmail IsNot Nothing Then
                    lnkEmail.Text = o.UserEmail
                    lnkEmail.NavigateUrl = "mailto:" + o.UserEmail
                End If
            End If

            Dim lblEmailCount As Label = CType(e.Row.FindControl("lblEmailCount"), Label)
            If lblEmailCount IsNot Nothing Then
                Dim emailCount As String = o.CustomPropertyGet("Develisys", "CartAbandonmentSendCount")
                lblEmailCount.Text = If(String.IsNullOrEmpty(emailCount), "0", emailCount)
            End If

            Dim hfBvin As HiddenField = CType(e.Row.FindControl("hfBvin"), HiddenField)
            If hfBvin IsNot Nothing Then
                hfBvin.Value = o.Bvin
            End If

            Dim lnkView As HyperLink = CType(e.Row.FindControl("lnkView"), HyperLink)
            If lnkView IsNot Nothing Then
                lnkView.NavigateUrl = String.Format("~/BVAdmin/Orders/ViewOrder.aspx?id={0}", o.Bvin)
            End If
        ElseIf e.Row.RowType = ListItemType.Footer Then
            e.Row.Cells(4).Text = String.Format("{0:C}", TotalSub)
            e.Row.Cells(4).CssClass = "text-right"
            e.Row.Cells(6).Text = String.Format("{0} Carts", TotalCount.ToString())
            e.Row.Cells(6).CssClass = "text-center"
        End If
    End Sub

    Private Sub gvCarts_Sort(sender As Object, e As GridViewSortEventArgs) Handles gvCarts.Sorting
        If ViewState("SortExpression") IsNot Nothing AndAlso ViewState("SortExpression").ToString() = e.SortExpression Then
            If CType(ViewState("SortDirection"), SortDirection) = SortDirection.Ascending Then
                ViewState("SortDirection") = SortDirection.Descending
            Else
                ViewState("SortDirection") = SortDirection.Ascending
            End If
        Else
            ViewState("SortExpression") = e.SortExpression
            ViewState("SortDirection") = e.SortDirection
        End If

        LoadData()
    End Sub

    Private Sub btnFilter_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles btnFilter.Click
        LoadData()
    End Sub

    Private Sub LoadTemplates()
        Me.lstEmailTemplate.Items.Clear()
        Dim templates As Collection(Of Content.EmailTemplate) = Content.EmailTemplate.FindAll()
        If templates IsNot Nothing Then
            For Each t As Content.EmailTemplate In templates
                Dim li As New ListItem
                li.Text = t.DisplayName
                li.Value = t.Bvin
                If t.Bvin = "6312e781-9961-4384-82cb-84b1f2baa44f" Then
                    li.Selected = True
                End If
                Me.lstEmailTemplate.Items.Add(li)
            Next
        End If
    End Sub

    Protected Sub btnSendEmail_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSendEmail.Click
        Me.msg.ClearMessage()

        Dim sendCount As Integer = 0
        Dim failedSendCount As Integer = 0

        For Each row As GridViewRow In Me.gvCarts.Rows
            If row.RowType = DataControlRowType.DataRow Then
                Dim chkSelected As CheckBox = CType(row.FindControl("chkSelected"), CheckBox)
                If chkSelected.Checked Then
                    Dim lnkEmail As HyperLink = CType(row.FindControl("lnkEmail"), HyperLink)
                    If Not String.IsNullOrEmpty(lnkEmail.Text.Trim()) Then
                        Dim hfBvin As HiddenField = CType(row.FindControl("hfBvin"), HiddenField)

                        Dim o As Orders.Order = Orders.Order.FindByBvin(hfBvin.Value)
                        If Not String.IsNullOrEmpty(o.Bvin) Then
                            Dim templateBvin As String = Me.lstEmailTemplate.SelectedValue
                            If String.IsNullOrEmpty(templateBvin) Then
                                templateBvin = "6312e781-9961-4384-82cb-84b1f2baa44f"
                            End If

                            Dim toEmail As String = o.UserEmail
                            If toEmail.Trim.Length > 0 Then
                                Dim t As Content.EmailTemplate = Content.EmailTemplate.FindByBvin(templateBvin)
                                Dim m As New System.Net.Mail.MailMessage
                                m = t.ConvertToMailMessage(t.From, toEmail, o)
                                If m IsNot Nothing Then
                                    If Not Regex.IsMatch(m.Body, "\[\[.+\]\]") Then
                                        If Utilities.MailServices.SendMail(m) Then
                                            IncrementEmailSendCount(o, t)
                                            sendCount += 1
                                        Else
                                            failedSendCount += 1
                                        End If
                                    Else
                                        t = Content.EmailTemplate.FindByBvin(templateBvin)
                                        Dim packages As Collection(Of Shipping.Package) = Shipping.Package.FindByOrderID(o.Bvin)
                                        m = t.ConvertToMailMessage(t.From, toEmail, o, packages)
                                        If Not Regex.IsMatch(m.Body, "\[\[.+\]\]") Then
                                            If Utilities.MailServices.SendMail(m) Then
                                                IncrementEmailSendCount(o, t)
                                                sendCount += 1
                                            Else
                                                failedSendCount += 1
                                            End If
                                        Else
                                            Me.msg.ShowError("This Email Template Could Not Replace All Tags. E-mails Will Not Be Sent.")
                                            failedSendCount += 1
                                            Exit For
                                        End If
                                    End If
                                Else
                                    Me.msg.ShowError(String.Format("Message for cart '{0}' was not created successfully.", o.Bvin))
                                    failedSendCount += 1
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        Next

        Me.msg.ShowInformation(String.Format("Sent: {0} email(s)<br/>Failed: {1} email(s)", sendCount.ToString(), failedSendCount.ToString()))
        LoadData()
    End Sub

    Private Sub IncrementEmailSendCount(ByVal o As Orders.Order, ByVal template As Content.EmailTemplate)
        Dim count As Integer = 0

        Dim strCount As String = o.CustomPropertyGet("Develisys", "CartAbandonmentSendCount")
        If Not String.IsNullOrEmpty(strCount) Then
            Integer.TryParse(strCount, count)
        End If
        count += 1

        o.CustomPropertySet("Develisys", "CartAbandonmentSendCount", count.ToString())
        Orders.Order.Update(o)

        Dim n As New Orders.OrderNote()
        n.NoteType = Orders.OrderNoteType.Private
        n.Note = String.Format("Cart Abandonment email #{0} sent using ""{1}"" template", count.ToString(), template.DisplayName)
        o.AddNote(n)
    End Sub

End Class