
Partial Class BVModules_Themes_OpticAuthority_Cart
    Inherits BaseStoreProductMasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.MessageBox = MessageBox1
        If TypeOf Me.Page Is BaseStoreProductPage Then
            DirectCast(Me.Page, BaseStoreProductPage).MessageBox = Me.MessageBox1
        End If
        Me.ChildContentHolder = Me.MainContentHolder
    End Sub
End Class

