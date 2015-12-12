Imports BVSoftware.Bvc5.Core

Namespace ImportExport

    Public MustInherit Class ExportTemplate
        Inherits BVSoftware.Bvc5.Core.Content.BVModule

        Private _export As BaseExport

        Public Property Export As BaseExport
            Get
                Return Me._export
            End Get
            Set(value As BaseExport)
                Me._export = value
            End Set
        End Property

        Public MustOverride Sub ApplyFormSettings(ByVal export As BaseExport)

    End Class

End Namespace