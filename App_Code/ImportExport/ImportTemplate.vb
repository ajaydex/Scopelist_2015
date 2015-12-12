Imports BVSoftware.Bvc5.Core

Namespace ImportExport

    Public MustInherit Class ImportTemplate
        Inherits BVSoftware.Bvc5.Core.Content.BVModule

        Private _import As BaseImport

        Public Property Import As BaseImport
            Get
                Return Me._import
            End Get
            Set(value As BaseImport)
                Me._import = value
            End Set
        End Property

        Public MustOverride Sub ApplyFormSettings(ByVal export As BaseImport)

    End Class

End Namespace