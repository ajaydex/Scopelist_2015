Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.IO

Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Plugins_FeedEngine_FeedGroup
    Inherits System.Web.UI.UserControl

    Private _Feeds As List(Of FeedEngine.BaseFeed) = Nothing

#Region " Properties "

    Public ReadOnly Property PageMessageBox() As IMessageBox
        Get
            Dim result As IMessageBox = Nothing

            Dim messageBoxes As New List(Of IMessageBox)
            BVSoftware.BVC5.Core.Controls.BVBaseUserControl.FindControlsByType(Me.Page.Controls, messageBoxes)
            If messageBoxes.Count > 0 Then
                result = messageBoxes(0)
            End If

            Return result
        End Get
    End Property

    Public Property Feeds() As List(Of FeedEngine.BaseFeed)
        Get
            Return Me._Feeds
        End Get
        Set(ByVal value As List(Of FeedEngine.BaseFeed))
            Me._Feeds = value
        End Set
    End Property

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadFeeds()
        End If
    End Sub

    Private Sub LoadFeeds()
        Me.gvFeeds.DataSource = Me.Feeds
        Me.gvFeeds.DataBind()
    End Sub

    Protected Sub gvFeeds_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs) Handles gvFeeds.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim f As FeedEngine.BaseFeed = CType(e.Row.DataItem, FeedEngine.BaseFeed)

            Dim chkFeed As CheckBox = CType(e.Row.FindControl("chkFeed"), CheckBox)
            chkFeed.Text = f.FeedName

            Dim hfBvin As HiddenField = CType(e.Row.FindControl("hfBvin"), HiddenField)
            hfBvin.Value = f.Bvin

            Dim lnkFeedFile As HyperLink = CType(e.Row.FindControl("lnkFeedFile"), HyperLink)
            Dim lblLastUpdated As Label = CType(e.Row.FindControl("lblLastUpdated"), Label)
            Dim lblSize As Label = CType(e.Row.FindControl("lblSize"), Label)
            If System.IO.File.Exists(f.PhysicalFilePath) Then
                Dim fi As New FileInfo(f.PhysicalFilePath)
                lnkFeedFile.Text = "/" + f.FileFolderPath.Replace("\", "/") + f.FileName
                lnkFeedFile.NavigateUrl = f.FileUrl
                lblLastUpdated.Text = fi.LastWriteTime.ToString("M/d/yyyy h:mm tt")
                lblSize.Text = String.Format("{0} MB", Math.Round(fi.Length / 1024 / 1024, 1).ToString())
            Else
                lnkFeedFile.Enabled = False
                lnkFeedFile.Text = "-"
                lblLastUpdated.Text = "-"
            End If
        End If
    End Sub

    Protected Sub gvFeeds_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs) Handles gvFeeds.RowCommand
        If e.CommandName = "Edit" Then
            Dim f As FeedEngine.BaseFeed = CType(e.CommandSource, FeedEngine.BaseFeed)
            Response.Redirect("~/BVAdmin/Plugins/FeedEngine/FeedEdit.aspx?id=" + f.Bvin)
        End If
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
        Dim selectedFeeds As New Collection(Of FeedEngine.BaseFeed)()

        For Each row As GridViewRow In gvFeeds.Rows
            If row.RowType = DataControlRowType.DataRow Then
                Dim chkFeed As CheckBox = CType(row.FindControl("chkFeed"), CheckBox)
                Dim hfBvin As HiddenField = CType(row.FindControl("hfBvin"), HiddenField)

                If chkFeed.Checked Then
                    Try
                        Dim f As FeedEngine.BaseFeed = FeedEngine.AvailableFeeds.FindByBvin(hfBvin.Value)
                        selectedFeeds.Add(f)

                        chkFeed.Checked = False
                    Catch ex As Exception
                        Me.PageMessageBox.ShowException(ex)
                    End Try
                End If
            End If
        Next

        If selectedFeeds.Count = 0 Then
            Me.PageMessageBox.ShowWarning("No feeds were selected")
        Else
            Dim auditLogUrl As String = Me.ResolveUrl("~/BVAdmin/Configuration/EventLog.aspx")

            Select Case Me.ddlGenerationType.SelectedValue
                Case "1"
                    System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf GenerateFeeds), selectedFeeds)
                    Me.PageMessageBox.ShowOk(String.Format("Feed generation started! This can take several minutes to complete depending on the size of the feed(s).<br/>Check the <a href=""{0}"">Audit Log</a> for details.", auditLogUrl))

                Case "2"
                    System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf UploadFeeds), selectedFeeds)
                    Me.PageMessageBox.ShowOk(String.Format("Feed upload started! This can take several minutes to complete depending on the size of the feed(s).<br/>Check the <a href=""{0}"">Audit Log</a> for details.", auditLogUrl))

                Case "3"
                    System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf GenerateFeedsAndUpload), selectedFeeds)
                    Me.PageMessageBox.ShowOk(String.Format("Feed generation &amp; upload started! This can take several minutes to complete depending on the size of the feed(s).<br/>Check the <a href=""{0}"">Audit Log</a> for details.", auditLogUrl))

            End Select
        End If
    End Sub

    Protected Sub GenerateFeeds(ByVal state As Object)
        Dim feeds As Collection(Of FeedEngine.BaseFeed) = CType(state, Collection(Of FeedEngine.BaseFeed))
        For Each f As FeedEngine.BaseFeed In feeds
            f.GenerateFeed()
        Next
    End Sub

    Protected Sub UploadFeeds(ByVal state As Object)
        Dim feeds As Collection(Of FeedEngine.BaseFeed) = CType(state, Collection(Of FeedEngine.BaseFeed))
        For Each f As FeedEngine.BaseFeed In feeds
            f.UploadFile()
        Next
    End Sub

    Protected Sub GenerateFeedsAndUpload(ByVal state As Object)
        Dim feeds As Collection(Of FeedEngine.BaseFeed) = CType(state, Collection(Of FeedEngine.BaseFeed))
        For Each f As FeedEngine.BaseFeed In feeds
            f.GenerateFeedAndUpload()
        Next
    End Sub

End Class