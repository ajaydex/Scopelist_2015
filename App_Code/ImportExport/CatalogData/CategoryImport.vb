Imports System.Collections.ObjectModel
Imports System.Linq
Imports System.Reflection
Imports BVSoftware.Bvc5.Core

Namespace ImportExport.CatalogData

    Public Class CategoryImport
        Inherits BaseImport

        Private templates As New StringCollection()
        Private allCats As New Collection(Of Catalog.Category)


#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_IMPORTNAME As String
            Get
                Return "Category Import"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_REQUIREDIMPORTFIELDS As String()
            Get
                Return New String() {"ParentID", _
                                     "Name"}
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overrides ReadOnly Property Bvin As String
            Get
                Return "F3C1883F-694D-4649-938A-1938940D08D5"
            End Get
        End Property

        Public Overrides ReadOnly Property ObjectType As Type
            Get
                Return GetType(Catalog.Category)
            End Get
        End Property

#End Region

        Public Overrides Function ProcessPreImport() As Boolean
            Dim result As Boolean = True

            templates = New StringCollection()
            For Each template As String In Content.ModuleController.FindCategoryTemplates()
                templates.Add(template.ToLower())
            Next

            allCats = Catalog.Category.FindAllLight()

            Return result
        End Function

        Public Overrides Function FindRowOjbect(key As Object) As Object
            Return Catalog.Category.FindByBvin(key.ToString())
        End Function

        Public Overrides Function ValidateRowObject(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result = MyBase.ValidateRowObject(data)

            If result Then
                Dim item As Catalog.Category = CType(data(Me.KeyField), Catalog.Category)

                ' CustomUrl: validation of CustomUrl takes place in SaveRow() to save a lookup

                ' ParentId
                If item.ParentId <> "0" AndAlso Catalog.Category.FindInCollection(allCats, item.ParentId) Is Nothing Then
                    result = False
                    Me.AddMessage(Content.DisplayMessageType.Error, String.Format("ParentId ""{0}"" does not exist - skipping row.", item.ParentId))
                End If
                If result Then
                    If item.ParentId = item.Bvin Then
                        result = False
                        Me.AddMessage(Content.DisplayMessageType.Error, "ParentId cannot equal the bvin field (i.e. a category cannot be its parent) - skipping row.")
                    End If
                End If
                If result Then
                    If Not String.IsNullOrEmpty(item.Bvin) Then
                        Dim oldItem As Catalog.Category = Catalog.Category.FindInCollection(allCats, item.Bvin)
                        If oldItem IsNot Nothing AndAlso item.ParentId <> oldItem.ParentId Then
                            Dim children As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(allCats, item.Bvin, True)
                            If children.Any(Function(c) c.Bvin = item.ParentId) Then
                                result = False
                                Me.AddMessage(Content.DisplayMessageType.Error, String.Format("Invalid ParentId ""{0}"": ParentId cannot be set to a bvin of a child category (i.e. a parent category cannot have a child as its parent) - skipping row.", item.ParentId))
                            End If
                        End If
                    End If
                End If

                ' TemplateName
                If result Then
                    If Not templates.Contains(item.TemplateName.ToLower()) Then
                        result = False
                        Me.AddMessage(Content.DisplayMessageType.Error, String.Format("TemplateName ""{0}"" does not exist - skipping row.", item.TemplateName))
                    End If
                End If
            End If
            
            Return result
        End Function

        Public Overrides Function SaveRow(data As Generic.Dictionary(Of String, Object)) As Boolean
            Dim result As Boolean = False

            Dim c As Catalog.Category = CType(data(Me.KeyField), Catalog.Category)

            ' make sure RewriteUrl is unique - we're doing this here rather than in ValidateRowObject to save a lookup
            Dim customUrl As Content.CustomUrl = Nothing
            If Not String.IsNullOrEmpty(c.RewriteUrl) Then
                customUrl = Content.CustomUrl.FindByRequestedUrl(c.RewriteUrl)
                If Not String.IsNullOrEmpty(customUrl.Bvin) Then
                    ' if RewriteUrl already exists as a CustomUrl that's NOT tied to this Category object
                    If customUrl.SystemData <> c.Bvin OrElse (String.IsNullOrEmpty(c.Bvin) AndAlso String.IsNullOrEmpty(customUrl.SystemData)) Then
                        Me.AddMessage(Content.DisplayMessageType.Error, String.Format("RewriteUrl ""{0}"" already exists - skipping row.", c.RewriteUrl))
                        Return False
                    End If
                End If
            End If

            If String.IsNullOrEmpty(c.Bvin) Then
                ' insert
                If Catalog.Category.Insert(c) Then
                    result = True
                Else
                    AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to save new category ""{0}"".", c.Name))
                End If
            Else
                ' update
                If Catalog.Category.Update(c) Then
                    result = True
                Else
                    AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update category ""{0}"" ({1}).", c.Name, c.Bvin))
                End If
            End If

            If result = True Then
                ' update allCats data to reflect new/updated category data (so validation works correctly for subsequent rows)
                allCats = Catalog.Category.FindAllLight(True)

                ' associated CustomUrl
                If Not String.IsNullOrEmpty(c.RewriteUrl) Then
                    ' Create or update Custom Url
                    If Not (customUrl IsNot Nothing AndAlso customUrl.SystemData = c.Bvin) Then
                        customUrl = Content.CustomUrl.FindBySystemData(c.Bvin)
                    End If

                    customUrl.SystemUrl = True
                    customUrl.SystemData = c.Bvin
                    customUrl.RequestedUrl = c.RewriteUrl
                    customUrl.RedirectToUrl = Utilities.UrlRewriter.BuildPhysicalUrlForCategory(c, "")
                    If String.IsNullOrEmpty(customUrl.Bvin) Then
                        If Not Content.CustomUrl.Insert(customUrl) Then
                            AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to add CustomUrl ""{0}"".", customUrl.RequestedUrl))
                        End If
                    Else
                        If Not Content.CustomUrl.Update(customUrl) Then
                            AddMessage(Content.DisplayMessageType.Error, String.Format("Unable to update CustomUrl ""{0}"".", customUrl.RequestedUrl))
                        End If
                    End If
                Else
                    ' Delete any system Custom Urls
                    Dim target As Content.CustomUrl = Content.CustomUrl.FindBySystemData(c.Bvin)
                    If target IsNot Nothing Then
                        If target.Bvin <> String.Empty Then
                            Content.CustomUrl.Delete(target.Bvin)
                        End If
                    End If
                End If
            End If

            Return result
        End Function

    End Class

End Namespace