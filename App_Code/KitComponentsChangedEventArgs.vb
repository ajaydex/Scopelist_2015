Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Public Class KitComponentsChangedEventArgs
    Inherits EventArgs

    Private _kitSelections As Catalog.KitSelections

    Public Property KitSelections() As Catalog.KitSelections
        Get
            Return _kitSelections
        End Get
        Set(ByVal value As Catalog.KitSelections)
            _kitSelections = value
        End Set
    End Property
End Class