
Partial Class BVModules_Themes_Foundation4_Responsive_Product
    Inherits BaseStoreProductMasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.ChildContentHolder = Me.MainContentHolder
        If TypeOf Me.Page Is BaseStoreProductPage Then
            DirectCast(Me.Page, BaseStoreProductPage).MessageBox = Me.MessageBox1
        End If
        Me.MessageBox = MessageBox1
    End Sub

End Class