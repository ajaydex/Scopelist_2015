<%@ Application Language="VB" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>

<script runat="server">
    
    Private Shared runSql As Boolean = False
    Private Shared connectionFailed As Boolean = False
    
    Private sqlLock As New Object()
    Private appReloadLock As New Object()
    
    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)                
        SyncLock sqlLock
            If Not runSql Then
                'attempt to patch the database
                runSql = Utilities.VersionHelper.SqlPatchNeeded()
            End If
        End SyncLock
        
        If Not runSql Then
            'Try out our database connection
            Try
                Datalayer.SqlDataHelper.TestConnectionString(WebAppSettings.ConnectionString)
            Catch ex As Exception
                If HttpContext.Current IsNot Nothing Then
                    connectionFailed = True
                Else
                    Throw
                End If
            End Try
            
            ' Load Encryption Keys
            LoadEncryptionKeys()
            
            ' Load WebAppSettings
            Try
                HttpContext.Current.Items("WebAppSettingsLoading") = True
                WebAppSettings.Load()
            Catch ex As Exception

            Finally
                HttpContext.Current.Items("WebAppSettingsLoading") = False
            End Try
            
            'Load all items
            TaskLoader.Load()
            
            AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, _
                           BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, _
                            "System Startup", "System is starting up.")
        End If
                
    End Sub
    
    Sub LoadEncryptionKeys()
        
        Dim keyLocation As String = System.Web.Hosting.HostingEnvironment.MapPath("~/bin")
        Dim masterKeyLocation As String = keyLocation
        
        If (ConfigurationManager.AppSettings("EncryptionKeyLocation") IsNot Nothing) Then
            masterKeyLocation = ConfigurationManager.AppSettings("EncryptionKeyLocation")
        End If
                                        
        Dim manager As New BVSoftware.Cryptography.KeyManager(keyLocation, masterKeyLocation, String.Empty)
        Dim keys As String = manager.LoadKeyJsonFromDisk()

        ' Ensure we always have at least one encryption key
        If (keys = String.Empty) Then
            manager.GenerateNewKey()
            keys = manager.LoadKeyJsonFromDisk()            
            AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, _
                                    BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, _
                                    "Generating First Encryption Key", "No encryption key was found. Generating one.")
        End If
            
        Application("EncryptionKeys") = keys
        AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, _
                                BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, _
                                "Encryption Keys Loaded", "Encryption Keys have been loaded to memory")
    End Sub
    
    
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Save Last Generated Order Number
        'Orders.OrderNumberGenerator.SaveSeed()
        AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, _
                           BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, _
                            "System Shutdown", "System is shutting down.")
    End Sub
        
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
        
        ' make sure error has not already been handled by redirector
        Dim lastError As Exception = Server.GetLastError()
        If lastError IsNot Nothing Then
            Dim ex As Exception = lastError.GetBaseException()
        
        
            AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, _
                                        BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, _
                                        "System Error", ex.Message)
            Do
                If ex.InnerException IsNot Nothing Then
                    ex = ex.InnerException
                    AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, _
                                        BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, _
                                        "System Error", ex.Message)
                End If
            Loop Until ex.InnerException Is Nothing
        End If
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        Dim redirectedForSqlUpdate As Boolean = False
        SyncLock sqlLock
            If connectionFailed Then
                connectionFailed = False
                Response.Redirect("~/SQLConnection.aspx", True)
                Return
            End If
            
            If runSql Then
                runSql = False
                redirectedForSqlUpdate = True
                Response.Redirect("~/SqlPatch.aspx", True)
            End If
        End SyncLock
        
        If Not redirectedForSqlUpdate Then
            ' Code that runs when a new session is started
            
            EnsureCleanApplicationStart()
            
            ' automatically log user in (if RememberUsers and RememberUserPasswords are both enabled), except on the SQL Patch page
            If Not Request.Url.AbsolutePath.EndsWith("/SqlPatch.aspx", StringComparison.InvariantCultureIgnoreCase) Then
                Dim userId As String = SessionManager.GetCurrentUserId()
                If Not String.IsNullOrEmpty(userId) Then
                    SessionManager.SetCurrentUserId(userId, True)
                End If
            End If
            
            Try
                If WebAppSettings.AutomaticallyRegenerateDynamicCategories Then
                    If ((DateTime.Now() - WebAppSettings.AutomaticallyRegenerateDynamicCategoriesLastDateTimeRun).Ticks / TimeSpan.TicksPerHour) > _
                            WebAppSettings.AutomaticallyRegenerateDynamicCategoriesIntervalInHours Then
                        WebAppSettings.AutomaticallyRegenerateDynamicCategoriesLastDateTimeRun = DateTime.Now()
                        System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf Catalog.Category.RegenerateDynamicCategories))
                    End If
                End If
            Catch ex As Exception
                AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Catalog, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, "Regenerate Dynamic Categories", ex.Message + " | " + ex.StackTrace)
            End Try
        
            Try
                If ((DateTime.Now() - WebAppSettings.CartCleanupLastTimeRun).Ticks / TimeSpan.TicksPerHour) > _
                        WebAppSettings.CartCleanupIntervalInHours Then
                    WebAppSettings.CartCleanupLastTimeRun = DateTime.Now()
                    System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf Orders.Order.CleanupCarts))
                End If
            Catch ex As Exception
                AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Catalog, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, "Cart Cleanup", ex.Message + " | " + ex.StackTrace)
            End Try
        
            Try
                If (WebAppSettings.InventoryLowHours > 0) AndAlso (Not WebAppSettings.DisableInventory) Then
                    If ((DateTime.Now() - WebAppSettings.InventoryLowLastTimeRun).Ticks / TimeSpan.TicksPerHour) > _
                            WebAppSettings.InventoryLowHours Then
                        WebAppSettings.InventoryLowLastTimeRun = DateTime.Now()
                        System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf Catalog.ProductInventory.EmailLowStockReport))
                    End If
                End If
            Catch ex As Exception
                AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Catalog, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, "Low Stock Report", ex.Message + " | " + ex.StackTrace)
            End Try
        
            Try
                If (WebAppSettings.CCSHours > 0) Then
                    If ((DateTime.Now() - WebAppSettings.CCSLastTimeRun).Ticks / TimeSpan.TicksPerHour) > 24 Then
                        Dim lastTimeRun As DateTime = WebAppSettings.CCSLastTimeRun
                        WebAppSettings.CCSLastTimeRun = DateTime.Now()
                        System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf Orders.Order.CleanUpCCNumbers), lastTimeRun)
                    End If
                End If
            Catch ex As Exception
                AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Catalog, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, "CC Cleanup", ex.Message + " | " + ex.StackTrace)
            End Try
            
            'Try
            '    If WebAppSettings.GoogleTrustedStoresEnabled Then
            '        If WebAppSettings.GoogleTrustedStoresFeedsLastTimeRun.Date < DateTime.Today Then
            '            WebAppSettings.GoogleTrustedStoresFeedsLastTimeRun = DateTime.Now()
                    
            '            Dim shipmentFeed As New FeedEngine.Transactions.GoogleTrustedStoresShipment()
            '            If String.IsNullOrEmpty(shipmentFeed.HostName) OrElse String.IsNullOrEmpty(shipmentFeed.UserName) OrElse String.IsNullOrEmpty(shipmentFeed.Password) Then
            '                System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf shipmentFeed.GenerateFeed))
            '            Else
            '                System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf shipmentFeed.GenerateFeedAndUpload))
            '            End If
                    
            '            Dim cancellationFeed As New FeedEngine.Transactions.GoogleTrustedStoresCancellation()
            '            If String.IsNullOrEmpty(cancellationFeed.HostName) OrElse String.IsNullOrEmpty(cancellationFeed.UserName) OrElse String.IsNullOrEmpty(cancellationFeed.Password) Then
            '                System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf cancellationFeed.GenerateFeed))
            '            Else
            '                System.Threading.ThreadPool.QueueUserWorkItem(New System.Threading.WaitCallback(AddressOf cancellationFeed.GenerateFeedAndUpload))
            '            End If
            '        End If
            '    End If
            'Catch ex As Exception
            '    AuditLog.LogSystemEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Catalog, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, "Google Trusted Stores", ex.Message + " | " + ex.StackTrace)
            'End Try
        End If
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.        
    End Sub

    Protected Sub Application_BeginRequest(ByVal sender As Object, ByVal e As System.EventArgs)
        EnsureCleanApplicationStart()
        
        Threading.Thread.CurrentThread.CurrentCulture = New System.Globalization.CultureInfo(WebAppSettings.SiteCultureCode)
        Threading.Thread.CurrentThread.CurrentUICulture = New System.Globalization.CultureInfo(WebAppSettings.SiteCultureCode)
    End Sub
    
    Private Function EnsureCleanApplicationStart() As Boolean
        Dim result As Boolean = False

        
        If WebAppSettings.WebAppSettingsLoaded Then
            result = True
        Else
            SyncLock appReloadLock
                If Not WebAppSettings.WebAppSettingsLoaded Then
                    If Not Utilities.VersionHelper.SqlPatchNeeded() Then
                        ' reload application
                        Application_Start(Me, Nothing)
                        
                        If WebAppSettings.WebAppSettingsLoaded Then
                            result = True
                            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Success, "System Reload", "Application successfully reloaded")
                        Else
                            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, "System Reload", "Unable to reload application")
                        End If
                    End If
                End If
            End SyncLock
        End If

        Return result
    End Function
    
    Public Function RestartApplication() As Boolean
        '' first try killing the worker process
        'Try
        '    Dim proc As System.Diagnostics.Process = System.Diagnostics.Process.GetCurrentProcess()
        '    If proc IsNot Nothing Then
        '        proc.Kill()
        '        Return True
        '    End If
        'Catch ex As Exception
        '    ' do nothing...continue to next method
        'End Try

        ' try unloading AppDomain
        Try
            HttpRuntime.UnloadAppDomain()
            Return True
        Catch ex As Exception
            ' do nothing...continue to next method
        End Try

        ' try bumping the Web.config file
        Try
            System.IO.File.SetLastWriteTime(System.IO.Path.Combine(HttpRuntime.AppDomainAppPath, "Web.config"), DateTime.Now)
            Return True
        Catch ex As Exception
            ' do nothing...continue to next method
        End Try

        ' last ditch effort to make the best of things -- manually run Application_Start
        Try
            Application_Start(Me, Nothing)
            Return True
        Catch ex As Exception

        End Try

        Return False
    End Function
    
</script>