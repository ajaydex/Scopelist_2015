Imports BVSoftware.BVC5.Core

Partial Class BVModules_Feeds_Commission_Junction_Edit
    Inherits FeedEngine.FeedTemplate

    Public Overloads Overrides Sub Initialize()
        Dim feed As FeedEngine.Products.CommissionJunction = DirectCast(Me.Feed, FeedEngine.Products.CommissionJunction)

        Me.txtCID.Text = feed.CID
        Me.txtSUBID.Text = feed.SUBID
        Me.txtAID.Text = feed.AID
        Me.txtPromotionalText.Text = feed.PromotionalText
    End Sub

    Public Overrides Sub Save()
        Dim feed As FeedEngine.Products.CommissionJunction = DirectCast(Me.Feed, FeedEngine.Products.CommissionJunction)

        feed.CID = Me.txtCID.Text.Trim()
        feed.SUBID = Me.txtSUBID.Text.Trim()
        feed.AID = Me.txtAID.Text.Trim()
        feed.PromotionalText = Me.txtPromotionalText.Text.Trim()

        feed.SaveSettings()
    End Sub

    Public Overrides Sub Cancel()

    End Sub

End Class