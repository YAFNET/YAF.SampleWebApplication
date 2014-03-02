' Yet Another Forum.NET
' Copyright (C) 2003-2005 Bjørnar Henden
' Copyright (C) 2006-2013 Jaben Cargman
' Copyright (C) 2014 Ingo Herbote
' http://www.yetanotherforum.net/
' 
' Licensed to the Apache Software Foundation (ASF) under one
' or more contributor license agreements.  See the NOTICE file
' distributed with this work for additional information
' regarding copyright ownership.  The ASF licenses this file
' to you under the Apache License, Version 2.0 (the
' "License"); you may not use this file except in compliance
' with the License.  You may obtain a copy of the License at

' http://www.apache.org/licenses/LICENSE-2.0

' Unless required by applicable law or agreed to in writing,
' software distributed under the License is distributed on an
' "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
' KIND, either express or implied.  See the License for the
' specific language governing permissions and limitations
' under the License.

Imports YAF.Classes
Imports YAF.Controls
Imports YAF.Core
Imports YAF.Types.Interfaces
Imports YAF.Utilities
Imports YAF.Utils

Public Class _Default
    Inherits Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Try
            Dim csType As Type = GetType(Page)

            If Not YafContext.Current.[Get](Of YafBoardSettings)().ShowRelativeTime Then
                Return
            End If

            Dim uRLToResource = Config.JQueryFile

            If Not uRLToResource.StartsWith("http") Then
                uRLToResource = YafForumInfo.GetURLToResource(Config.JQueryFile)
            End If

            ScriptManager.RegisterClientScriptInclude(Me, csType, "JQuery", uRLToResource)

            ScriptManager.RegisterClientScriptInclude(Me, csType, "jqueryTimeagoscript", YafForumInfo.GetURLToResource("js/jquery.timeago.js"))

            ScriptManager.RegisterStartupScript(Me, csType, "timeagoloadjs", JavaScriptBlocks.TimeagoLoadJs, True)
        Catch generatedExceptionName As Exception
            Me.Response.Redirect("~/forum/install/default.aspx")
        End Try
    End Sub
End Class