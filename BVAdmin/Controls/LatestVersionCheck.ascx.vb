
Partial Class BVAdmin_Controls_LatestVersionCheck
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadVersionCheck()
        End If
    End Sub

    Private Sub LoadVersionCheck()
        Dim latest As String = BVSoftware.Bvc5.Core.Utilities.VersionHelper.GetLatestVersionFromBV()
        Dim isLatest As Boolean = BVSoftware.Bvc5.Core.Utilities.VersionHelper.IsLatestVersion(latest)

        If (isLatest) Then
            'Me.litVersionCheck.Text = "<div class=""messagebox center""><ul><li>Your software is up to date.</li></ul></div>"
            'Me.lnkDownload.Visible = False
            Me.Visible = False
        Else
            Me.litVersionCheck.Text = "<div class=""cap"">New version available!</div>"
            Me.lnkDownload.Text = "<div class=""box clearfix""><i class=""icon-download-alt icon-4x""></i> <span>Download</span> BV Commerce <br />" + latest + "</div>"
            Me.lnkDownload.Visible = True
        End If
    End Sub
End Class
